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
  arduano.tmux.enable = true;

  services.vscode-server.enable = true;

  programs.openclaw = {
    enable = true;
    reloadScript.enable = true;
    runtimePlugins = [ "signal" ];

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

      secrets.providers.codex_lb_api_key = {
        source = "file";
        path = "/home/arduano/.openclaw/secrets/codex-lb-api-key";
        mode = "singleValue";
      };

      models.providers.codex-lb = {
        baseUrl = "http://100.82.173.47:2455/v1";
        apiKey = {
          source = "file";
          provider = "codex_lb_api_key";
          id = "value";
        };
        auth = "api-key";
        authHeader = true;
        api = "openai-responses";
        # Codex LB can spend many minutes queued before emitting the first byte.
        timeoutSeconds = 900;
        agentRuntime.id = "openclaw";
        request.allowPrivateNetwork = true;
        models = map
          (model: {
            inherit (model) id name;
            reasoning = true;
            input = [ "text" "image" ];
            contextWindow = 272000;
            maxTokens = 128000;
            thinkingLevelMap = {
              off = "none";
              minimal = "minimal";
              low = "low";
              medium = "medium";
              high = "high";
              xhigh = "xhigh";
              max = "xhigh";
            };
            compat = {
              supportsPromptCacheKey = true;
              supportsReasoningEffort = true;
              supportsTools = true;
              supportedReasoningEfforts = [
                "none"
                "minimal"
                "low"
                "medium"
                "high"
                "xhigh"
              ];
            };
          })
          [
            { id = "gpt-5.6-sol"; name = "GPT-5.6 Sol via Codex LB"; }
            { id = "gpt-5.6-terra"; name = "GPT-5.6 Terra via Codex LB"; }
            { id = "gpt-5.6-luna"; name = "GPT-5.6 Luna via Codex LB"; }
            { id = "gpt-5.5"; name = "GPT-5.5 via Codex LB"; }
            { id = "gpt-5.4"; name = "GPT-5.4 via Codex LB"; }
          ];
      };

      auth.profiles."openai:leonid.shchurov@gmail.com" = {
        provider = "openai";
        mode = "oauth";
        email = "leonid.shchurov@gmail.com";
      };

      auth.order.openai = [
        "openai:leonid.shchurov@gmail.com"
        "openai:api-key-backup"
      ];

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
          primary = "codex-lb/gpt-5.6-sol";
          fallbacks = [
            "codex-lb/gpt-5.5"
            "codex-lb/gpt-5.4"
            "openai/gpt-5.5"
            "openai/gpt-5.4"
          ];
        };
        models = {
          # Temporary safety workaround: codex-lb's upstream rejects
          # prompt_cache_retention on some routed requests. "none" suppresses
          # both OpenAI prompt-cache request fields until the route is fixed.
          "codex-lb/gpt-5.6-sol".params.cacheRetention = "none";
          "codex-lb/gpt-5.6-terra".params.cacheRetention = "none";
          "codex-lb/gpt-5.6-luna".params.cacheRetention = "none";
          "codex-lb/gpt-5.5".params.cacheRetention = "none";
          "codex-lb/gpt-5.4".params.cacheRetention = "none";
          "openai/gpt-5.6-sol" = { };
          "openai/gpt-5.6-terra" = { };
          "openai/gpt-5.6-luna" = { };
          "openai/gpt-5.5" = { };
          "openai/gpt-5.4" = { };
          "openai/gpt-5.3-codex" = { };
          "openrouter/anthropic/claude-sonnet-4.6" = { };
          "openrouter/anthropic/claude-opus-4.6" = { };
        };
        workspace = "/home/arduano/.openclaw/workspace";
        memorySearch = {
          enabled = true;
          sources = [ "memory" ];
          provider = "openai";
          remote.apiKey = {
            provider = "default";
            source = "env";
            id = "OPENAI_API_KEY";
          };
          sync.onSearch = true;
        };
        compaction = {
          mode = "safeguard";
          model = "codex-lb/gpt-5.6-sol";
          reserveTokensFloor = 50000;
          timeoutSeconds = 900;
          truncateAfterCompaction = true;
          midTurnPrecheck.enabled = false;
          qualityGuard.enabled = false;
        };
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
          isolatedSession = true;
          lightContext = true;
          target = "signal";
          to = "+61466965098";
          directPolicy = "allow";
          ackMaxChars = 20;
          prompt = "Read HEARTBEAT.md if it exists (workspace context). Follow it strictly. Do not infer or repeat old tasks from prior chats. If nothing needs attention, reply HEARTBEAT_OK.";
        };
        maxConcurrent = 4;
        subagents = {
          maxConcurrent = 8;
          model = "codex-lb/gpt-5.6-sol";
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

      session = {
        dmScope = "main";
      };

      messages = {
        ackReactionScope = "all";
        visibleReplies = "automatic";
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
