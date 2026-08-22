{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
  cfg = config.arduano.workVm;
  firewallTable = "work-vm-uplink";
  warpPackage = cfg.cloudflareWarp.package;

  isInterfaceName = value: builtins.match "[a-zA-Z0-9_.-]+" value != null;
  isIPv4Address =
    value:
    let
      octets = lib.splitString "." value;
      isOctet =
        octet: builtins.match "(0|[1-9][0-9]{0,2})" octet != null && builtins.fromJSON octet <= 255;
    in
    builtins.length octets == 4 && builtins.all isOctet octets;
  isIPv4Cidr =
    value:
    let
      parts = lib.splitString "/" value;
    in
    builtins.length parts == 2
    && isIPv4Address (builtins.elemAt parts 0)
    && builtins.match "(0|[1-9]|[12][0-9]|3[0-2])" (builtins.elemAt parts 1) != null;

  firewallRules = pkgs.writeText "work-vm-uplink.nft" ''
    table inet ${firewallTable}
    delete table inet ${firewallTable}

    table inet ${firewallTable} {
      chain input {
        type filter hook input priority filter - 5; policy accept;
        ${lib.optionalString
          (cfg.cloudflareWarp.enable && cfg.cloudflareWarp.expectedPrivateDestinations != [ ])
          ''
            iifname "${cfg.hostInterface}" ip daddr { ${lib.concatStringsSep ", " cfg.cloudflareWarp.expectedPrivateDestinations} } counter drop comment "prevent work VM private-route fallback to host"
          ''
        }
        iifname "${cfg.hostInterface}" ct state { established, related } accept comment "allow replies to host-originated work VM connections"
        iifname "${cfg.hostInterface}" counter drop comment "isolate host services from work VM namespace"
      }

      chain forward {
        type filter hook forward priority filter - 5; policy accept;
        ${lib.optionalString
          (cfg.cloudflareWarp.enable && cfg.cloudflareWarp.expectedPrivateDestinations != [ ])
          ''
            iifname "${cfg.hostInterface}" ip daddr { ${lib.concatStringsSep ", " cfg.cloudflareWarp.expectedPrivateDestinations} } counter drop comment "prevent work VM private-route fallback through host"
          ''
        }
        oifname "${cfg.hostInterface}" ct state != { established, related } counter drop comment "block new forwarded connections into work VM namespace"
      }

      chain postrouting {
        type nat hook postrouting priority srcnat; policy accept;
        ip saddr ${cfg.uplink.subnet} oifname != "${cfg.hostInterface}" masquerade
      }
    }
  '';

  namespaceExec = pkgs.writeShellApplication {
    name = "work-vm-netns-exec";
    runtimeInputs = [
      pkgs.iproute2
      pkgs.nftables
      pkgs.systemd
      pkgs.util-linux
    ];
    text = ''
      if (( $# == 0 )); then
        echo "usage: sudo work-vm-netns-exec COMMAND [ARG ...]" >&2
        exit 2
      fi
      if (( EUID != 0 )); then
        echo "work-vm-netns-exec must be run through sudo to enter the namespace" >&2
        exit 1
      fi
      systemctl is-active --quiet work-vm-firewall.service
      systemctl is-active --quiet work-vm-netns.service
      nft list table inet ${lib.escapeShellArg firewallTable} >/dev/null

      # Entering a named network namespace requires privilege, but QEMU must
      # never inherit root. Require a non-root sudo caller, then reset identity
      # variables while dropping to that caller inside the namespace.
      if [[ -z "''${SUDO_UID:-}" || -z "''${SUDO_GID:-}" || "$SUDO_UID" == 0 || "$SUDO_GID" == 0 ]]; then
        echo "work-vm-netns-exec requires sudo from a non-root account" >&2
        exit 1
      fi
      if [[ "$1" != /* ]]; then
        echo "work-vm-netns-exec requires an absolute command path" >&2
        exit 2
      fi

      exec ip netns exec ${lib.escapeShellArg cfg.networkNamespace} \
        setpriv --reuid "$SUDO_UID" --regid "$SUDO_GID" --init-groups --reset-env -- "$@"
    '';
  };

  warpCli = pkgs.writeShellApplication {
    name = "work-vm-warp";
    runtimeInputs = [
      warpPackage
      pkgs.systemd
    ];
    text = ''
      systemctl is-active --quiet work-vm-firewall.service
      systemctl is-active --quiet cloudflare-warp.service
      # The daemon's IPC socket is host-visible. Keeping this client unprivileged
      # lets enrollment callbacks and SSH operators reach the namespace daemon
      # without entering the root-owned network namespace.
      exec warp-cli "$@"
    '';
  };

  warpReauthBrowser = pkgs.writeShellApplication {
    name = "work-vm-warp-auth-browser";
    runtimeInputs = [
      pkgs.brave
      pkgs.coreutils
      pkgs.findutils
    ];
    text = ''
      state_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/work-vm-warp-auth"
      profile_dir="$state_dir/brave-profile"
      runtime_dir="''${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
      install -d -m 0700 "$state_dir" "$profile_dir"

      export DISPLAY="''${DISPLAY:-:0}"
      export XDG_RUNTIME_DIR="$runtime_dir"
      export DBUS_SESSION_BUS_ADDRESS="''${DBUS_SESSION_BUS_ADDRESS:-unix:path:$runtime_dir/bus}"
      if [[ -z "''${XAUTHORITY:-}" || ! -r "''${XAUTHORITY:-}" ]]; then
        xauth_line="$(${pkgs.findutils}/bin/find "$runtime_dir" -maxdepth 1 -type f -user "$(id -u)" -name 'xauth_*' -printf '%T@ %p\n' | sort -rn | head -n 1)"
        export XAUTHORITY="''${xauth_line#* }"
      fi
      [[ -n "''${XAUTHORITY:-}" && -r "$XAUTHORITY" ]] || {
        echo 'No active graphical desktop Xauthority was found; log into the main-pc desktop first.' >&2
        exit 1
      }

      nohup brave \
        --user-data-dir="$profile_dir" \
        --no-first-run \
        --no-default-browser-check \
        --new-window "$@" \
        >"$state_dir/browser.log" 2>&1 &
    '';
  };

  warpReauthServer = pkgs.writeShellApplication {
    name = "work-vm-warp-reauth-server";
    runtimeInputs = [
      warpPackage
      pkgs.bind
      pkgs.coreutils
      pkgs.curl
      pkgs.gawk
      pkgs.gnugrep
      pkgs.util-linux
    ];
    text = ''
      state_dir="''${XDG_STATE_HOME:-$HOME/.local/state}/work-vm-warp-auth"
      result="$state_dir/last-result.json"
      install -d -m 0700 "$state_dir"
      exec 9>"$state_dir/reauth.lock"
      flock -n 9 || { echo 'A WARP reauthentication is already running.' >&2; exit 1; }

      status="$(warp-cli --accept-tos status)"
      printf '%s\n' "$status"
      grep -q 'Status update: Connected' <<<"$status"
      grep -q 'Network: healthy' <<<"$status"
      organization="$(warp-cli --accept-tos registration organization)"
      [[ -n "$organization" ]] || {
        echo 'The WARP client has no Zero Trust organization registration.' >&2
        exit 1
      }
      printf 'Registered WARP organization: %s\n' "$organization"

      probe_endpoint() {
        local hostname=$1 address code
        address="$(host -W 2 -R 1 "$hostname" 127.0.2.3 2>/dev/null | awk '/ has address / { print $4; exit }')"
        [[ -n "$address" ]] || return 1
        code="$(curl \
          --http1.1 \
          --resolve "$hostname:443:$address" \
          --connect-timeout 5 \
          --max-time 20 \
          --silent \
          --show-error \
          --output /dev/null \
          --write-out '%{http_code}' \
          "https://$hostname/" 2>/dev/null)" || return 1
        [[ "$code" =~ ^[1-5][0-9][0-9]$ ]]
      }

      printf 'Opening the WiseTech reauthentication flow inside %s...\n' ${lib.escapeShellArg cfg.networkNamespace}
      BROWSER=${lib.getExe warpReauthBrowser} warp-cli --accept-tos debug access-reauth
      echo 'Approve the two-digit sign-in notification on your phone when prompted.'
      echo 'Waiting for three consecutive protected HTTPS passes...'

      deadline=$((SECONDS + 900))
      consecutive=0
      attempts=0
      while (( SECONDS < deadline )); do
        attempts=$((attempts + 1))
        if probe_endpoint devtools-build-targets.wtg.zone \
          && probe_endpoint proget.wtg.zone \
          && probe_endpoint crikey.wtg.zone; then
          consecutive=$((consecutive + 1))
          printf 'Protected HTTPS pass %d/3.\n' "$consecutive"
          if (( consecutive >= 3 )); then
            finished="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
            printf '{"schema":1,"status":"passed","consecutiveProtectedHttpsPasses":3,"finishedUtc":"%s"}\n' "$finished" > "$result.tmp"
            mv "$result.tmp" "$result"
            chmod 0600 "$result"
            echo 'WARP reauthentication and protected HTTPS validation passed.'
            exit 0
          fi
        else
          consecutive=0
          if (( attempts == 1 || attempts % 6 == 0 )); then
            echo 'Still waiting for the authenticated protected path...'
          fi
        fi
        sleep 5
      done

      finished="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
      printf '{"schema":1,"status":"failed","reason":"protected HTTPS did not recover before timeout","finishedUtc":"%s"}\n' "$finished" > "$result.tmp"
      mv "$result.tmp" "$result"
      chmod 0600 "$result"
      echo 'Timed out waiting for authenticated protected HTTPS.' >&2
      exit 1
    '';
  };

  warpReauthClient = pkgs.writeShellApplication {
    name = "work-vm-warp-reauth";
    runtimeInputs = [ pkgs.socat ];
    text = ''
      socket=/run/work-vm-warp-reauth.sock
      [[ -S "$socket" ]] || { echo "WARP reauthentication socket is unavailable: $socket" >&2; exit 1; }
      exec socat -T 1200 - "UNIX-CONNECT:$socket"
    '';
  };
in
{
  options.arduano.workVm = {
    enable = mkEnableOption "isolated host support for a work virtual machine";

    networkNamespace = mkOption {
      type = types.str;
      default = "work-vm";
      description = "Named network namespace used by the VM and its VPN client.";
    };

    hostInterface = mkOption {
      type = types.str;
      default = "workvm-host";
      description = "Host side of the namespace veth pair (15 characters maximum).";
    };

    namespaceInterface = mkOption {
      type = types.str;
      default = "workvm-uplink";
      description = "Namespace side of the veth pair (15 characters maximum).";
    };

    uplink = {
      subnet = mkOption {
        type = types.str;
        default = "10.203.0.0/30";
        description = "Private point-to-point subnet used only between the host and namespace.";
      };
      hostAddress = mkOption {
        type = types.str;
        default = "10.203.0.1/30";
        description = "Host veth address, including prefix length.";
      };
      namespaceAddress = mkOption {
        type = types.str;
        default = "10.203.0.2/30";
        description = "Namespace veth address, including prefix length.";
      };
      gateway = mkOption {
        type = types.str;
        default = "10.203.0.1";
        description = "Default gateway visible inside the namespace.";
      };
      bootstrapResolvers = mkOption {
        type = types.listOf types.str;
        default = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        description = "Resolvers used inside the namespace before the VPN client configures DNS.";
      };
    };

    cloudflareWarp = {
      enable = mkEnableOption "Cloudflare WARP isolated inside the work-VM namespace";

      package = mkOption {
        type = types.package;
        default = pkgs.cloudflare-warp;
        description = "Cloudflare WARP package used by the isolated daemon and CLI helpers.";
      };

      reauthUser = mkOption {
        type = types.str;
        default = "arduano";
        description = "Desktop user allowed to trigger and complete WARP reauthentication.";
      };

      expectedPrivateDestinations = mkOption {
        type = types.listOf types.str;
        default = [ ];
        example = [ "100.64.0.0/10" ];
        description = ''
          IPv4 CIDRs expected to be carried by the enrolled Zero Trust profile.
          Traffic for these destinations is prevented from falling back through
          the host uplink when WARP is disconnected or its managed policy omits
          the route. Account identifiers and enrollment credentials must not be
          stored in this repository.
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = isInterfaceName cfg.networkNamespace;
        message = "arduano.workVm.networkNamespace must contain only letters, digits, dot, underscore, or hyphen.";
      }
      {
        assertion = isInterfaceName cfg.hostInterface && builtins.stringLength cfg.hostInterface <= 15;
        message = "arduano.workVm.hostInterface must be a valid Linux interface name of at most 15 characters.";
      }
      {
        assertion =
          isInterfaceName cfg.namespaceInterface && builtins.stringLength cfg.namespaceInterface <= 15;
        message = "arduano.workVm.namespaceInterface must be a valid Linux interface name of at most 15 characters.";
      }
      {
        assertion = cfg.hostInterface != cfg.namespaceInterface;
        message = "arduano.workVm host and namespace interfaces must have different names.";
      }
      {
        assertion = isIPv4Cidr cfg.uplink.subnet;
        message = "arduano.workVm.uplink.subnet must be a valid IPv4 CIDR.";
      }
      {
        assertion = isIPv4Cidr cfg.uplink.hostAddress;
        message = "arduano.workVm.uplink.hostAddress must be a valid IPv4 address with prefix length.";
      }
      {
        assertion = isIPv4Cidr cfg.uplink.namespaceAddress;
        message = "arduano.workVm.uplink.namespaceAddress must be a valid IPv4 address with prefix length.";
      }
      {
        assertion = isIPv4Address cfg.uplink.gateway;
        message = "arduano.workVm.uplink.gateway must be a valid IPv4 address.";
      }
      {
        assertion = builtins.all isIPv4Address cfg.uplink.bootstrapResolvers;
        message = "arduano.workVm.uplink.bootstrapResolvers must contain only valid IPv4 addresses.";
      }
      {
        assertion = !cfg.cloudflareWarp.enable || cfg.cloudflareWarp.expectedPrivateDestinations != [ ];
        message = "arduano.workVm.cloudflareWarp.expectedPrivateDestinations must not be empty when WARP is enabled.";
      }
      {
        assertion = builtins.all isIPv4Cidr cfg.cloudflareWarp.expectedPrivateDestinations;
        message = "arduano.workVm.cloudflareWarp.expectedPrivateDestinations must contain only valid IPv4 CIDRs.";
      }
    ];

    environment.systemPackages = [
      namespaceExec
    ]
    ++ lib.optionals cfg.cloudflareWarp.enable [
      warpCli
      warpReauthClient
    ];

    boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

    # This module owns the host veth. Keep generic network managers from
    # attaching DHCP, IPv4LL, IPv6, or default-route state to it.
    networking.dhcpcd.denyInterfaces = [ cfg.hostInterface ];
    networking.networkmanager.unmanaged = [ "interface-name:${cfg.hostInterface}" ];

    # WARP's tunnel, routes, DNS, and firewall changes happen inside this
    # namespace. Host VPNs therefore remain authoritative for host traffic,
    # even when their destination ranges overlap the work tunnel. Reconcile only
    # our dedicated table instead of enabling NixOS's global nftables mode,
    # which would otherwise conflict with hosts still using Docker's iptables
    # backend. Its lifecycle follows the declarative module configuration; there
    # are no separate firewall enable/disable helpers.
    systemd.services.work-vm-firewall = {
      description = "Fail-closed nftables boundary for the work VM namespace";
      wantedBy = [ "multi-user.target" ];
      before = [ "work-vm-netns.service" ];
      reloadIfChanged = true;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.nftables}/bin/nft --file ${firewallRules}";
        ExecReload = "${pkgs.nftables}/bin/nft --file ${firewallRules}";
        ExecStop = "-${pkgs.nftables}/bin/nft delete table inet ${firewallTable}";
      };
    };

    # When the NixOS firewall filters forwarded traffic, also permit namespace
    # egress in its own chain. Our earlier-priority table still enforces the
    # private-route and inbound drops before that accept is reached.
    networking.firewall.extraForwardRules = mkIf config.networking.firewall.filterForward ''
      iifname "${cfg.hostInterface}" accept comment "work VM namespace egress"
    '';

    systemd.services.work-vm-netns = {
      description = "Network namespace and NAT uplink for the work VM";
      wantedBy = [ "multi-user.target" ];
      before = lib.optional cfg.cloudflareWarp.enable "cloudflare-warp.service";
      bindsTo = [ "work-vm-firewall.service" ];
      after = [
        "network-pre.target"
        "work-vm-firewall.service"
      ];
      path = [
        pkgs.coreutils
        pkgs.iproute2
      ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = ''
        set -eu
        ip netns delete ${lib.escapeShellArg cfg.networkNamespace} 2>/dev/null || true
        ip link delete ${lib.escapeShellArg cfg.hostInterface} 2>/dev/null || true
        ip netns add ${lib.escapeShellArg cfg.networkNamespace}
        ip link add ${lib.escapeShellArg cfg.hostInterface} type veth \
          peer name ${lib.escapeShellArg cfg.namespaceInterface} \
          netns ${lib.escapeShellArg cfg.networkNamespace}

        ip address add ${lib.escapeShellArg cfg.uplink.hostAddress} \
          dev ${lib.escapeShellArg cfg.hostInterface}
        ip link set ${lib.escapeShellArg cfg.hostInterface} up

        ip -n ${lib.escapeShellArg cfg.networkNamespace} link set lo up
        ip -n ${lib.escapeShellArg cfg.networkNamespace} address add \
          ${lib.escapeShellArg cfg.uplink.namespaceAddress} \
          dev ${lib.escapeShellArg cfg.namespaceInterface}
        ip -n ${lib.escapeShellArg cfg.networkNamespace} link set \
          ${lib.escapeShellArg cfg.namespaceInterface} up
        ip -n ${lib.escapeShellArg cfg.networkNamespace} route add default \
          via ${lib.escapeShellArg cfg.uplink.gateway}

        install -d -m 0755 /etc/netns/${lib.escapeShellArg cfg.networkNamespace}
        : > /etc/netns/${lib.escapeShellArg cfg.networkNamespace}/resolv.conf
        ${lib.concatMapStringsSep "\n" (resolver: ''
          printf 'nameserver %s\n' ${lib.escapeShellArg resolver} \
            >> /etc/netns/${lib.escapeShellArg cfg.networkNamespace}/resolv.conf
        '') cfg.uplink.bootstrapResolvers}
      '';
      preStop = ''
        ip netns delete ${lib.escapeShellArg cfg.networkNamespace} 2>/dev/null || true
        ip link delete ${lib.escapeShellArg cfg.hostInterface} 2>/dev/null || true
      '';
    };

    services.cloudflare-warp = mkIf cfg.cloudflareWarp.enable {
      enable = true;
      package = warpPackage;
      # Outer WARP packets leave through the namespace's NAT uplink; no
      # host-facing inbound port is required.
      openFirewall = false;
    };

    systemd.services.cloudflare-warp = mkIf cfg.cloudflareWarp.enable {
      requires = [ "work-vm-netns.service" ];
      after = [ "work-vm-netns.service" ];
      partOf = [ "work-vm-netns.service" ];
      serviceConfig = {
        NetworkNamespacePath = "/run/netns/${cfg.networkNamespace}";
        # Prevent WARP's DNS management from rewriting the host resolver.
        BindPaths = [
          "/etc/netns/${cfg.networkNamespace}/resolv.conf:/etc/resolv.conf"
        ];
        # Cloudflare One Client 2026.7 invokes nft through this fixed FHS path
        # instead of resolving it through PATH. Expose only nftables' bin
        # directory inside this service's private mount namespace.
        BindReadOnlyPaths = [
          "${lib.getBin pkgs.nftables}/bin:/usr/sbin"
        ];
        ReadWritePaths = [
          "/etc/netns/${cfg.networkNamespace}/resolv.conf"
        ];
      };
    };

    systemd.sockets.work-vm-warp-reauth = mkIf cfg.cloudflareWarp.enable {
      description = "User trigger for work-VM WARP reauthentication";
      wantedBy = [ "sockets.target" ];
      socketConfig = {
        ListenStream = "/run/work-vm-warp-reauth.sock";
        Accept = true;
        SocketUser = cfg.cloudflareWarp.reauthUser;
        SocketMode = "0600";
        RemoveOnStop = true;
      };
    };

    systemd.services."work-vm-warp-reauth@" = mkIf cfg.cloudflareWarp.enable {
      description = "Work-VM WARP reauthentication and protected-path validation";
      requires = [
        "cloudflare-warp.service"
        "work-vm-netns.service"
      ];
      after = [
        "cloudflare-warp.service"
        "work-vm-netns.service"
      ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = lib.getExe warpReauthServer;
        NetworkNamespacePath = "/run/netns/${cfg.networkNamespace}";
        User = cfg.cloudflareWarp.reauthUser;
        StandardInput = "socket";
        StandardOutput = "socket";
        StandardError = "socket";
        TimeoutStartSec = "20min";
        UMask = "0077";
      };
    };

    # Auditable but non-secret. The organization-managed device profile is the
    # actual authority for split-tunnel inclusion.
    environment.etc."work-vm/expected-warp-destinations" = mkIf cfg.cloudflareWarp.enable {
      text = lib.concatStringsSep "\n" cfg.cloudflareWarp.expectedPrivateDestinations + "\n";
    };
  };
}
