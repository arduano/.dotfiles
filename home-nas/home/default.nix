{ config, lib, pkgs, inputs, ... }:

let
  workmapsAttentionMap = pkgs.writeShellApplication {
    name = "workmaps-attention-map";
    runtimeInputs = with pkgs; [
      coreutils
      tailscale
    ];
    text = ''
      set -euo pipefail

      ts_ip="$(tailscale ip -4 2>/dev/null | head -n1)"
      if [ -z "$ts_ip" ]; then
        echo "No Tailscale IPv4 found" >&2
        exit 1
      fi

      cd /home/arduano/.openclaw/workspace/life/workmaps
      export WORKMAPS_HOST="$ts_ip"
      export WORKMAPS_PORT=6173
      export WORKMAPS_HMR_PORT=6174
      exec ${pkgs.arduano.nodePkgs}/bin/workmaps dev
    '';
  };
in
{
  imports = [ ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "arduano";
  home.homeDirectory = "/home/arduano";

  nixpkgs.config.allowUnfree = true;

  arduano.shell.enable = true;
  arduano.programming.enable = true;

  services.vscode-server.enable = true;

  programs.openclaw = {
    enable = true;
    reloadScript.enable = true;

    config = {
      diagnostics = {
        enabled = true;
        flags = [ "signal.*" ];
      };

      logging = {
        level = "debug";
        consoleLevel = "info";
        consoleStyle = "compact";
        redactSensitive = "tools";
      };

      auth.profiles."openai-codex:leonid.shchurov@gmail.com" = {
        provider = "openai-codex";
        mode = "oauth";
        email = "leonid.shchurov@gmail.com";
      };

      browser = {
        enabled = true;
        executablePath = "${pkgs.chromium}/bin/chromium";
        headless = true;
        noSandbox = true;
        defaultProfile = "openclaw";
        profiles.openclaw = {
          cdpPort = 18800;
          cdpUrl = "http://127.0.0.1:18800";
          driver = "clawd";
          color = "#FF4500";
        };
      };

      agents.defaults = {
        model = {
          primary = "openai-codex/gpt-5.5";
          fallbacks = [
            "openai-codex/gpt-5.5"
            "openai-codex/gpt-5.4"
            "openai-codex/gpt-5.3-codex"
            "moonshot/kimi-k2-0905"
            "openrouter/moonshot/kimi-k2-0905"
            "openrouter/anthropic/claude-sonnet-4.5"
            "openrouter/anthropic/claude-sonnet-4.6"
            "openrouter/anthropic/claude-opus-4.6"
            "deepseek/deepseek-chat"
            "google/gemini-2.5-flash"
            "openrouter/deepseek/deepseek-chat"
            "openrouter/google/gemini-2.5-flash"
            "openrouter/moonshotai/kimi-k2.5"
          ];
        };
        models = {
          "openai-codex/gpt-5.5" = { };
          "openai-codex/gpt-5.4" = { };
          "openai-codex/gpt-5.3-codex" = { };
          "openrouter/anthropic/claude-sonnet-4.6" = { };
          "openrouter/anthropic/claude-opus-4.6" = { };
        };
        workspace = "/home/arduano/.openclaw/workspace";
        memorySearch = {
          enabled = true;
          sources = [ "memory" ];
          provider = "openai";
          sync.onSearch = true;
        };
        compaction.mode = "safeguard";
        elevatedDefault = "full";
        blockStreamingDefault = "on";
        blockStreamingBreak = "message_end";
        startupContext = {
          enabled = true;
          applyOn = [
            "new"
            "reset"
          ];
          dailyMemoryDays = 2;
          maxFileBytes = 16384;
          maxFileChars = 1200;
          maxTotalChars = 2800;
        };
        heartbeat = {
          every = "30m";
          target = "signal";
          to = "+61466965098";
          ackMaxChars = 20;
          prompt = "Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats. If nothing needs attention, reply HEARTBEAT_OK.";
        };
        maxConcurrent = 4;
        subagents = {
          maxConcurrent = 8;
          model = "openai-codex/gpt-5.4";
        };
        sandbox.mode = "off";
      };

      tools = {
        elevated = {
          enabled = true;
          allowFrom.signal = [ "+61466965098" ];
        };
        web = {
          search = {
            enabled = true;
            openaiCodex = {
              enabled = true;
              mode = "cached";
            };
          };
          fetch.enabled = true;
        };
      };

      messages = {
        ackReactionScope = "group-mentions";
        groupChat.visibleReplies = "automatic";
      };

      commands = {
        native = "auto";
        nativeSkills = "auto";
        restart = true;
        ownerDisplay = "raw";
      };

      hooks.internal = {
        enabled = true;
        entries = {
          command-logger.enabled = true;
          session-memory.enabled = true;
        };
      };

      channels.signal = {
        enabled = true;
        account = "+61493904969";
        cliPath = "${pkgs.signal-cli}/bin/signal-cli";
        dmPolicy = "allowlist";
        allowFrom = [ "+61466965098" ];
        groupPolicy = "allowlist";
        blockStreaming = true;
        blockStreamingCoalesce = {
          minChars = 1;
          maxChars = 256;
          idleMs = 0;
        };
      };

      gateway = {
        port = 18789;
        mode = "local";
        bind = "loopback";
        auth = {
          mode = "token";
          token = "nix-managed-local-gateway";
        };
        tailscale = {
          mode = "off";
          resetOnExit = false;
        };
      };

      skills.install.nodeManager = "bun";
    };
  };

  systemd.user.services.openclaw-gateway.Service = {
    EnvironmentFile = "/home/arduano/.openclaw/gateway.systemd.env";
    StandardOutput = lib.mkForce "journal";
    StandardError = lib.mkForce "journal";
  };
  systemd.user.services.openclaw-gateway.Install.WantedBy = [ "default.target" ];

  systemd.user.services.workmaps-attention-map = {
    Unit = {
      Description = "Workmaps attention map server";
      After = [ "network-online.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${workmapsAttentionMap}/bin/workmaps-attention-map";
      Restart = "on-failure";
      RestartSec = 10;
      WorkingDirectory = "/home/arduano/.openclaw/workspace/life/workmaps";
    };

    Install.WantedBy = [ "default.target" ];
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # Gmail/OpenClaw tooling prerequisites
    google-cloud-sdk
    jq
  ];


  home.sessionVariables.GOG_ACCOUNT = "arduano.mail@gmail.com";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
