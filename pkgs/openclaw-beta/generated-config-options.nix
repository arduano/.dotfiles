# Generated from upstream OpenClaw schema at rev npm:openclaw@2026.8.1-beta.2. DO NOT EDIT.
# Generator: nix/scripts/generate-config-options.ts
{ lib }:
let
  t = lib.types;
in
{
  "$schema" = lib.mkOption {
    type = t.nullOr (t.str);
    default = null;
  };

  accessGroups = lib.mkOption {
    type = t.nullOr (t.attrsOf (t.oneOf [ (t.submodule { options = {
    channelId = lib.mkOption {
      type = t.str;
    };
    guildId = lib.mkOption {
      type = t.str;
    };
    membership = lib.mkOption {
      type = t.nullOr (t.enum [ "canViewChannel" ]);
      default = null;
    };
    type = lib.mkOption {
      type = t.enum [ "discord.channelAudience" ];
    };
  }; }) (t.submodule { options = {
    members = lib.mkOption {
      type = t.attrsOf (t.listOf (t.str));
    };
    type = lib.mkOption {
      type = t.enum [ "message.senders" ];
    };
  }; }) ]));
    default = null;
  };

  acp = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    allowedAgents = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Allowlist of ACP target agent ids permitted for ACP runtime sessions. Empty means no additional allowlist restriction.";
    };
    backend = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Default ACP runtime backend id (for example: acpx). Must match a registered ACP runtime plugin backend.";
    };
    defaultAgent = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Fallback ACP target agent id used when ACP spawns do not specify an explicit target.";
    };
    dispatch = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Independent dispatch gate for ACP session turns (default: true). Set false to keep ACP commands available while blocking ACP turn execution.";
      };
    }; });
      default = null;
    };
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Global ACP feature gate. Keep disabled unless ACP runtime + policy are configured.";
    };
    fallbacks = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Ordered list of fallback ACP backend ids tried when the primary backend fails with UNAVAILABLE (for example: rate-limit / quota exhausted). Each entry must match a registered ACP runtime plugin backend.";
    };
    runtime = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      installCommand = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional operator install/setup command shown by `/acp install` and `/acp doctor` when ACP backend wiring is missing.";
      };
    }; });
      default = null;
    };
    stream = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      deliveryMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "live" ]) (t.enum [ "final_only" ]) ]);
        default = null;
        description = "ACP delivery style: live streams projected output incrementally, final_only buffers all projected ACP output until terminal turn events.";
      };
      repeatSuppression = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "When true (default), suppress repeated ACP status/tool projection lines in a turn while keeping raw ACP events unchanged.";
      };
      tagVisibility = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.bool));
        default = null;
        description = "Per-sessionUpdate visibility overrides for ACP projection (for example usage_update, available_commands_update).";
      };
    }; });
      default = null;
      description = "ACP streaming projection controls for chunk sizing, metadata visibility, and deduped delivery behavior.";
    };
  }; });
    default = null;
    description = "ACP runtime controls for enabling dispatch, selecting backends, constraining allowed agent targets, and selecting streamed turn projection behavior.";
  };

  agents = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    defaults = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      authInheritance = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Agent whose legacy credential store remains the inheritance source after default-marker retirement. Written automatically during upgrade when the former owner was not main.";
        };
      }; });
        default = null;
        description = "Upgrade compatibility owner for the inherited credential store until credentials are relocated per agent.";
      };
      blockStreamingBreak = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "text_end" ]) (t.enum [ "message_end" ]) ]);
        default = null;
      };
      blockStreamingChunk = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        breakPreference = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
          default = null;
        };
        maxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        minChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      blockStreamingCoalesce = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        idleMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        maxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        minChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      blockStreamingDefault = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "on" ]) ]);
        default = null;
      };
      bootstrapMaxChars = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Max characters of each workspace bootstrap file injected into the system prompt before truncation (default: 20000).";
      };
      bootstrapTotalMaxChars = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Max total characters across all injected workspace bootstrap files (default: 60000).";
      };
      compaction = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable embedded proactive auto-compaction (default: true). Set false to stop threshold-driven embedded compaction while preserving OpenClaw overflow recovery, preflight compaction, and manual /compact.";
        };
        identifierPolicy = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "strict" ]) (t.enum [ "off" ]) ]);
          default = null;
          description = "Identifier-preservation policy for compaction summaries: \"strict\" prepends built-in opaque-identifier retention guidance (default), while \"off\" disables this prefix.";
        };
        keepRecentTokens = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Minimum token budget preserved from the most recent conversation window during compaction. Use higher values to protect immediate context continuity and lower values to keep more long-tail history.";
        };
        maxActiveTranscriptBytes = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.int) (t.str) ]);
          default = null;
          description = "Byte threshold that triggers normal preflight local compaction when the active session transcript reaches this size (bytes or strings like \"20mb\"). Set to 0 or leave unset to disable. Also caps Codex app-server native rollout transcripts; oversized native threads restart fresh.";
        };
        memoryFlush = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Enables pre-compaction memory flush before the runtime performs stronger history reduction near token limits. Keep enabled unless you intentionally disable memory side effects in constrained environments.";
          };
          forceFlushTranscriptBytes = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.int) (t.str) ]);
            default = null;
            description = "Forces pre-compaction memory flush when active transcript size reaches this threshold (bytes or strings like \"2mb\"). Use this to prevent long-session hangs even when token counters are stale; set to 0 to disable.";
          };
          model = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional provider/model override used only for pre-compaction memory flush turns. Set this to a local model such as ollama/qwen3:8b when durable memory extraction should avoid the active session's paid model. The override is exact and does not inherit the active model fallback chain.";
          };
          softThresholdTokens = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
            description = "Threshold distance to compaction (in tokens) that triggers pre-compaction memory flush execution. Use earlier thresholds for safer persistence, or tighter thresholds for lower flush frequency.";
          };
        }; });
          default = null;
          description = "Pre-compaction memory flush settings that run an agentic memory write before heavy compaction. Keep enabled for long sessions so salient context is persisted before aggressive trimming.";
        };
        midTurnPrecheck = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Enable structured mid-turn context pressure checks for embedded OpenClaw tool loops. Default: false. Keep disabled unless long tool-heavy sessions hit context overflow before normal turn-end compaction can run.";
          };
        }; });
          default = null;
          description = "Optional embedded OpenClaw tool-loop precheck that detects context pressure after a tool result is appended and before the next model call. When enabled, OpenClaw reuses existing precheck recovery to truncate tool results or compact before retrying.";
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "default" ]) (t.enum [ "safeguard" ]) ]);
          default = null;
          description = "Compaction strategy mode: \"default\" uses baseline behavior, while \"safeguard\" applies stricter guardrails to preserve recent context. Keep \"default\" unless you observe aggressive history loss near limit boundaries.";
        };
        model = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Optional provider/model or configured bare alias used only for compaction summarization. Bare aliases resolve before dispatch; a configured literal model ID wins if it collides with an alias. Leave unset to keep using the primary agent model.";
        };
        notifyUser = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "When enabled, sends brief context-maintenance notices to the user: when compaction starts and completes (for example, '🧹 Compacting context...' and '🧹 Compaction complete'), and when a pre-compaction memory flush is exhausted so the reply continues in a degraded state (for example, '⚠️ Memory maintenance temporarily failed; continuing your reply.'). Disabled by default to keep context maintenance silent and non-intrusive.";
        };
        postCompactionSections = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Opt-in AGENTS.md H2/H3 section names re-injected after compaction. Leave unset or set [] to disable reinjection. Explicitly set [\"Session Startup\", \"Red Lines\"] to enable the legacy default pair.";
        };
        postIndexSync = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "async" "await" ]);
          default = null;
          description = "Controls post-compaction session memory reindex mode: \"off\", \"async\", or \"await\" (default: \"async\"). Use \"await\" for strongest freshness, \"async\" for lower compaction latency, and \"off\" only when session-memory sync is handled elsewhere.";
        };
        provider = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Id of a registered compaction provider plugin used for summarization. When set and the provider is registered, its summarize() method is called instead of the built-in summarizeInStages pipeline. Falls back to built-in on provider failure. Leave unset to use the default built-in summarization.";
        };
        qualityGuard = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Enables summary quality audits and regeneration retries for safeguard compaction. Default: true in safeguard mode.";
          };
          maxRetries = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
            description = "Maximum number of regeneration retries after a failed safeguard summary quality audit. Use small values to bound extra latency and token cost.";
          };
        }; });
          default = null;
          description = "Quality-audit retry settings for safeguard compaction summaries. Safeguard mode enables this by default; set enabled: false to skip summary audits and regeneration.";
        };
        recentTurnsPreserve = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Number of most recent user/assistant turns kept verbatim outside safeguard summarization (default: 3). Raise this to preserve exact recent dialogue context, or lower it to maximize compaction savings.";
        };
        thinkingLevel = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "minimal" "low" "medium" "high" "xhigh" "adaptive" "max" "ultra" ]);
          default = null;
          description = "Optional thinking level used only for embedded OpenClaw compaction summaries: \"off\", \"minimal\", \"low\", \"medium\", \"high\", \"xhigh\", \"adaptive\", \"max\", or \"ultra\". It overrides the session level and is clamped to the actual compaction model/runtime; leave unset to inherit the session level. Native Codex app-server compaction ignores this setting because its compact request has no per-operation thinking override, and OpenClaw logs a warning.";
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum time in seconds allowed for a single compaction operation before it is aborted (default: 180). Increase this for very large sessions that need more time to summarize, or decrease it to fail faster on unresponsive models.";
        };
      }; });
        default = null;
        description = "Compaction behavior for when context nears token limits, including strategy and pre-compaction memory flush behavior. Use this when long-running sessions need stable continuity under tight context windows.";
      };
      contextInjection = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "always" ]) (t.enum [ "continuation-skip" ]) (t.enum [ "never" ]) ]);
        default = null;
        description = "Controls when workspace bootstrap files are injected into the system prompt: \"always\" (default) or \"continuation-skip\" for safe continuation turns after a completed assistant response.";
      };
      contextLimits = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        memoryGetMaxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default max characters returned by memory_get before truncation metadata and continuation notice are added. Increase to approximate older larger excerpts, but keep it bounded.";
        };
        postCompactionMaxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default max characters retained from AGENTS.md during post-compaction context refresh injection. Lower this to make compaction recovery cheaper, or raise it for agents that depend on longer startup guidance.";
        };
      }; });
        default = null;
        description = "Focused per-agent-context budget defaults for selected high-volume excerpts and injected prompt blocks. Use this to tune bounded read/injection sizes without reopening any unbounded call paths.";
      };
      contextPruning = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        hardClear = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          placeholder = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "cache-ttl" ]) ]);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        ttl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      contextTokens = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      elevatedDefault = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "on" ]) (t.enum [ "ask" ]) (t.enum [ "full" ]) ]);
        default = null;
      };
      embeddedAgent = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        executionContract = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "default" ]) (t.enum [ "strict-agentic" ]) ]);
          default = null;
          description = "Embedded OpenClaw execution contract: \"default\" keeps the standard runner behavior, while \"strict-agentic\" enables structured plan tracking and non-visible turn recovery for supported OpenAI/OpenAI Codex GPT-5-family runs.";
        };
        projectSettingsPolicy = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "trusted" ]) (t.enum [ "sanitize" ]) (t.enum [ "ignore" ]) ]);
          default = null;
          description = "How embedded OpenClaw handles workspace-local `.openclaw/settings.json`: \"sanitize\" (default) strips shellPath/shellCommandPrefix, \"ignore\" disables project settings entirely, and \"trusted\" applies project settings as-is.";
        };
      }; });
        default = null;
        description = "Embedded OpenClaw runner hardening controls for how workspace-local agent settings are trusted and applied in OpenClaw sessions.";
      };
      experimental = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        localModelLean = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Experimental local-model prompt trim. When enabled, OpenClaw drops heavyweight default tools like browser, cron, and message for weaker or smaller local-model backends.";
        };
      }; });
        default = null;
        description = "Experimental agent-default flags. Keep these off unless you are intentionally testing a preview surface.";
      };
      fastModeDefault = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
        default = null;
        description = "Default fast-mode policy for the agent loop (\"auto\", true, or false). Individual agent entries override it.";
      };
      heartbeat = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        accountId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        activeHours = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          end = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          start = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          timezone = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        agentId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Agent that owns ambient heartbeat runs when no per-agent heartbeat configuration exists. Leave unset to preserve configured-default routing.";
        };
        directPolicy = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "block" ]) ]);
          default = null;
          description = "Controls whether heartbeat delivery may target direct/DM chats: \"allow\" (default) permits DM delivery and \"block\" suppresses direct-target sends.";
        };
        every = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        isolatedSession = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        lightContext = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        model = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        prompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        session = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        target = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum time in seconds allowed for a heartbeat agent turn before it is aborted. Leave unset to use agents.defaults.timeoutSeconds when set, otherwise the heartbeat cadence capped at 600 seconds.";
        };
        to = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      humanDelay = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        maxMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum delay in ms for custom humanDelay (default: 2500).";
        };
        minMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Minimum delay in ms for custom humanDelay (default: 800).";
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "natural" ]) (t.enum [ "custom" ]) ]);
          default = null;
          description = "Delay style for block replies (\"off\", \"natural\", \"custom\").";
        };
      }; });
        default = null;
      };
      imageMaxDimensionPx = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Max image side length in pixels when sanitizing transcript/tool-result image payloads (default: 1200).";
      };
      imageModel = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        fallbacks = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Ordered fallback image models (provider/model).";
        };
        primary = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Optional image model (provider/model) used when the primary model lacks image input.";
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }) ]);
        default = null;
      };
      imageQuality = lib.mkOption {
        type = t.nullOr (t.enum [ "auto" "efficient" "balanced" "high" ]);
        default = null;
        description = "Image-tool media compression preference: \"auto\" adapts to provider/model limits and image count, \"efficient\" saves tokens and bytes, \"balanced\" keeps the current middle ground, and \"high\" preserves more detail for screenshots and document images.";
      };
      maxConcurrent = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      mediaModels = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        image = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          fallbacks = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
            description = "Ordered fallback image-generation models (provider/model).";
          };
          primary = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional image-generation model (provider/model) used by the shared image generation capability.";
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
            description = "Default provider request timeout in milliseconds for image_generate calls. Per-call timeoutMs overrides this.";
          };
        }; }) ]);
          default = null;
        };
        music = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          fallbacks = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
            description = "Ordered fallback music-generation models (provider/model).";
          };
          primary = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional music-generation model (provider/model) used by the shared music generation capability.";
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }) ]);
          default = null;
        };
        video = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          fallbacks = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
            description = "Ordered fallback video-generation models (provider/model).";
          };
          primary = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional video-generation model (provider/model) used by the shared video generation capability.";
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
            description = "Default provider request timeout in milliseconds for video_generate calls. Per-call timeoutMs overrides this, and this value overrides provider-authored defaults.";
          };
        }; }) ]);
          default = null;
        };
      }; });
        default = null;
      };
      model = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        fallbacks = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Ordered fallback models (provider/model). Used when the primary model fails.";
        };
        primary = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Primary model (provider/model).";
        };
      }; }) ]);
        default = null;
      };
      modelPolicy = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Allowed model override refs. Accepts aliases, full \"provider/model\" refs, and provider wildcards such as \"openai/*\". Empty permits any model.";
        };
      }; });
        default = null;
        description = "Explicit policy for model overrides. Omit it or leave allow empty to permit any model.";
      };
      models = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        agentRuntime = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          id = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Default-agent model runtime id: \"openclaw\", \"auto\", a registered plugin harness id such as \"codex\", or a supported CLI backend alias such as \"claude-cli\".";
          };
        }; });
          default = null;
          description = "Optional per-model runtime policy for the default agent. Use this for model-specific runtime exceptions instead of setting a whole-agent runtime.";
        };
        alias = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        params = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.anything));
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; }));
        default = null;
        description = "Configured model catalog and per-model settings. Entries provide aliases, params, and runtime metadata; they do not restrict model overrides.";
      };
      params = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.anything));
        default = null;
      };
      pdfMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
        description = "Maximum PDF file size in megabytes for the PDF tool (default: 10).";
      };
      pdfMaxPages = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum number of PDF pages to process for the PDF tool (default: 20).";
      };
      pdfModel = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        fallbacks = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Ordered fallback PDF models (provider/model).";
        };
        primary = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Optional PDF model (provider/model) for the PDF analysis tool. Defaults to imageModel, then session model.";
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }) ]);
        default = null;
      };
      reasoningDefault = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "on" ]) (t.enum [ "stream" ]) ]);
        default = null;
      };
      repoRoot = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional repository root shown in the system prompt runtime line (overrides auto-detect).";
      };
      sandbox = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        backend = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        browser = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowHostControl = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          autoStart = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          autoStartTimeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          binds = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          cdpPort = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          cdpSourceRange = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional CIDR allowlist for container-edge CDP ingress (for example 172.21.0.1/32).";
          };
          containerPrefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          headless = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          image = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          network = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Docker network for sandbox browser containers (default: openclaw-sandbox-browser). Use the dedicated default or a custom bridge network; \"none\" is unsupported because browser control requires published CDP ports.";
          };
          noVncEnabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          noVncPort = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          vncPort = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        docker = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          apparmorProfile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          binds = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          capDrop = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          containerPrefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          cpus = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          dangerouslyAllowContainerNamespaceJoin = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "DANGEROUS break-glass override that allows sandbox Docker network mode container:<id>. This joins another container namespace and weakens sandbox isolation.";
          };
          dangerouslyAllowExternalBindSources = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          dangerouslyAllowReservedContainerTargets = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          dns = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          env = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.str));
            default = null;
          };
          extraHosts = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          gpus = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional Docker GPU passthrough value passed to --gpus, for example \"all\" or \"device=GPU-uuid\". Requires a compatible host runtime such as NVIDIA Container Toolkit.";
          };
          image = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          memory = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
            default = null;
          };
          memorySwap = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
            default = null;
          };
          network = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          pidsLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          readOnlyRoot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          seccompProfile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          setupCommand = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.listOf (t.str)) ]);
            default = null;
          };
          tmpfs = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          ulimits = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.submodule { options = {
            hard = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            soft = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; }) ]));
            default = null;
          };
          user = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          workdir = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "non-main" ]) (t.enum [ "all" ]) ]);
          default = null;
        };
        prune = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          idleHours = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxAgeDays = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        scope = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "session" ]) (t.enum [ "agent" ]) (t.enum [ "shared" ]) ]);
          default = null;
        };
        sessionToolsVisibility = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "spawned" ]) (t.enum [ "all" ]) ]);
          default = null;
        };
        ssh = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          certificateData = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          certificateFile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          command = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          identityData = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          identityFile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          knownHostsData = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          knownHostsFile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          strictHostKeyChecking = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          target = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          updateHostKeys = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          workspaceRoot = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        workspaceAccess = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "ro" ]) (t.enum [ "rw" ]) ]);
          default = null;
        };
        workspaceRoot = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      sessionStore = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Agent that owns retired main-agent rows or unscoped rows in a fixed legacy session store after default-marker retirement. Written automatically during upgrade when the former owner was not main or the sole agent.";
        };
      }; });
        default = null;
        description = "Upgrade compatibility owner for retired main-agent rows and fixed legacy session stores.";
      };
      silentReply = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        group = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "disallow" ]) ]);
          default = null;
        };
        internal = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "disallow" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      skills = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional default skill allowlist inherited by agents that omit agents.entries.*.skills. Omit for unrestricted skills, set [] to give inheriting agents no skills, and remember explicit agents.entries.*.skills replaces this default instead of merging with it.";
      };
      skipBootstrap = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      skipOptionalBootstrapFiles = lib.mkOption {
        type = t.nullOr (t.listOf (t.enum [ "SOUL.md" "USER.md" "HEARTBEAT.md" "IDENTITY.md" ]));
        default = null;
        description = "Optional bootstrap files that should not be created in agent workspaces. Valid values: SOUL.md, USER.md, IDENTITY.md (HEARTBEAT.md is accepted but a no-op).";
      };
      startupContext = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        applyOn = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "new" ]) (t.enum [ "reset" ]) ]));
          default = null;
          description = "Chooses which bare reset commands get startup context: include \"new\", \"reset\", or both (default: [\"new\",\"reset\"]).";
        };
        dailyMemoryDays = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Number of dated memory files to load counting backward from today in the configured user timezone (default: 2 for today + yesterday).";
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable the startup-context prelude for bare session resets (default: true). Disable this to fall back to prompt-only behavior with no runtime-loaded daily memory.";
        };
        maxFileBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum bytes allowed per daily memory file when building startup context (default: 16384). Files over this boundary-safe read limit are skipped.";
        };
        maxFileChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum characters retained from each loaded daily memory file in the startup prelude (default: 1200).";
        };
        maxTotalChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum total characters retained across all loaded daily memory files in the startup prelude (default: 2800). Additional files are truncated from the prelude once this cap is reached.";
        };
      }; });
        default = null;
        description = "Runtime-owned first-turn prelude for bare \"/new\" and \"/reset\". Use this to control whether recent daily memory files are preloaded into the first prompt instead of asking the model to decide what to read.";
      };
      subagents = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowAgents = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        announceTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        archiveAfterMinutes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        delegationMode = lib.mkOption {
          type = t.nullOr (t.enum [ "suggest" "prefer" ]);
          default = null;
          description = "Prompt-only sub-agent delegation strength. \"suggest\" keeps the default guidance; \"prefer\" strongly instructs the main agent to delegate anything more involved than a direct reply via sessions_spawn.";
        };
        maxChildrenPerAgent = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum number of active children a single agent session can spawn (default: 5).";
        };
        maxConcurrent = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        maxSpawnDepth = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum nesting depth for sub-agent spawning. 1 = no nesting (default), 2 = sub-agents can spawn sub-sub-agents.";
        };
        model = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          fallbacks = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          primary = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }) ]);
          default = null;
        };
        requireAgentId = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        runTimeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        thinking = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      systemAgent = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Agent whose model and credentials own ambient system-agent and Custodian consults. Delegated consults still use their requesting agent.";
        };
      }; });
        default = null;
        description = "Target settings for ambient OpenClaw system-agent and Custodian inference.";
      };
      thinkingDefault = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "minimal" "low" "medium" "high" "xhigh" "adaptive" "max" "ultra" ]);
        default = null;
      };
      timeoutSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      toolProgressDetail = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "explain" ]) (t.enum [ "raw" ]) ]);
        default = null;
      };
      typingIntervalSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Controls typing-indicator keepalive cadence in seconds for every agent. Increase it to reduce update frequency across all typing-capable channels.";
      };
      typingMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "never" ]) (t.enum [ "instant" ]) (t.enum [ "thinking" ]) (t.enum [ "message" ]) ]);
        default = null;
        description = "Controls when typing starts for agents: \"never\", \"instant\", \"thinking\", or \"message\". Per-agent typingMode overrides this default.";
      };
      userTimezone = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      utilityModel = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional lower-cost model (provider/model or alias) for short internal tasks such as generated titles and progress narration. Unset derives the primary provider's declared small model when available (otherwise the primary model); set to an empty string to disable utility routing.";
      };
      verboseDefault = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "on" ]) (t.enum [ "full" ]) ]);
        default = null;
      };
      voiceModel = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        fallbacks = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Ordered fallback voice models (provider/model).";
        };
        primary = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Optional voice model (provider/model) used by speech, transcription, and realtime voice capabilities.";
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default provider request timeout in milliseconds for voice model operations when the caller supports timeouts.";
        };
      }; }) ]);
        default = null;
      };
      workspace = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Default workspace path exposed to agent runtime tools for filesystem context and repo-aware behavior. Set this explicitly when running from wrappers so path resolution stays deterministic.";
      };
    }; });
      default = null;
      description = "Shared default settings inherited by agents unless overridden per entry in agents.entries. Use defaults to enforce consistent baseline behavior and reduce duplicated per-agent configuration.";
    };
    entries = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      agentDir = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      bootstrapMaxChars = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Per-agent override for max characters of each workspace bootstrap file injected into this agent's system prompt. Omit to inherit agents.defaults.bootstrapMaxChars.";
      };
      bootstrapTotalMaxChars = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Per-agent override for max total characters across all workspace bootstrap files injected into this agent's system prompt. Omit to inherit agents.defaults.bootstrapTotalMaxChars.";
      };
      contextInjection = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "always" ]) (t.enum [ "continuation-skip" ]) (t.enum [ "never" ]) ]);
        default = null;
        description = "Per-agent override for when workspace bootstrap files are injected into this agent's system prompt. Omit to inherit agents.defaults.contextInjection.";
      };
      contextLimits = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        memoryGetMaxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Per-agent override for the default memory_get max character budget.";
        };
        postCompactionMaxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Per-agent override for the post-compaction AGENTS.md excerpt budget.";
        };
      }; });
        default = null;
        description = "Optional per-agent overrides for the focused context budget knobs. Omitted fields inherit agents.defaults.contextLimits.";
      };
      contextTokens = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      default = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      description = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      embeddedAgent = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        executionContract = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "default" ]) (t.enum [ "strict-agentic" ]) ]);
          default = null;
          description = "Optional per-agent embedded OpenClaw execution contract override. Set \"strict-agentic\" to enable structured plan tracking and non-visible turn recovery for that agent on supported OpenAI/OpenAI Codex GPT-5-family runs, or \"default\" to inherit the standard runner behavior.";
        };
      }; });
        default = null;
        description = "Optional per-agent embedded OpenClaw overrides. Use this to opt specific agents into stricter GPT-5 execution behavior without changing the global default.";
      };
      experimental = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        localModelLean = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Per-agent override for lean local-model mode. Enable it for one smaller local-model agent without trimming tools from every agent.";
        };
      }; });
        default = null;
        description = "Per-agent experimental flags. Omitted fields inherit agents.defaults.experimental.";
      };
      fastModeDefault = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
        default = null;
        description = "Optional per-agent default for fast mode (\"auto\", true, or false). Applies when no per-message or session fast-mode override is set.";
      };
      groupChat = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        unmentionedInbound = lib.mkOption {
          type = t.nullOr (t.enum [ "user_request" "room_event" ]);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeat = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        accountId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        activeHours = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          end = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          start = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          timezone = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        directPolicy = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "block" ]) ]);
          default = null;
          description = "Per-agent override for heartbeat direct/DM delivery policy; use \"block\" for agents that should only send heartbeat alerts to non-DM destinations.";
        };
        every = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        isolatedSession = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        lightContext = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        model = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        prompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        session = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        target = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Per-agent maximum time in seconds allowed for a heartbeat agent turn before it is aborted. Leave unset to inherit the merged heartbeat timeout, then agents.defaults.timeoutSeconds when set, otherwise the heartbeat cadence capped at 600 seconds.";
        };
        to = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      humanDelay = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        maxMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        minMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "natural" ]) (t.enum [ "custom" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      identity = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        avatar = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Agent avatar (workspace-relative path, http(s) URL, or data URI).";
        };
        emoji = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        theme = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      memory = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        search = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cache = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          documentInputType = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          experimental = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            sessionMemory = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          extraPaths = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.submodule { options = {
            path = lib.mkOption {
              type = t.str;
            };
            pattern = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; }) ]));
            default = null;
          };
          fallback = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          inputType = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          local = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            modelPath = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; });
            default = null;
          };
          model = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          multimodal = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            maxFileBytes = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            modalities = lib.mkOption {
              type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "image" ]) (t.enum [ "audio" ]) (t.enum [ "all" ]) ]));
              default = null;
            };
          }; });
            default = null;
          };
          outputDimensionality = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          provider = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          query = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            maxResults = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minScore = lib.mkOption {
              type = t.nullOr (t.number);
              default = null;
            };
          }; });
            default = null;
          };
          queryInputType = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          rememberAcrossConversations = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          remote = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            apiKey = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            baseUrl = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            batch = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              enabled = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
            }; });
              default = null;
            };
            headers = lib.mkOption {
              type = t.nullOr (t.attrsOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          sources = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "memory" ]) (t.enum [ "sessions" ]) ]));
            default = null;
          };
          store = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            fts = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              tokenizer = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "unicode61" ]) (t.enum [ "trigram" ]) ]);
                default = null;
              };
            }; });
              default = null;
            };
            vector = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              enabled = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              extensionPath = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
      model = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        fallbacks = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        primary = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }) ]);
        default = null;
      };
      modelPolicy = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Allowed model override refs for this agent. Accepts aliases, full \"provider/model\" refs, and trailing prefix wildcards such as \"provider/*\" or \"provider/namespace/*\"; empty permits any model.";
        };
      }; });
        default = null;
        description = "Per-agent model override policy. An explicit allow list replaces the default policy for this agent.";
      };
      models = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        agentRuntime = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          id = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Per-agent model runtime id: \"openclaw\", \"auto\", a registered plugin harness id such as \"codex\", or a supported CLI backend alias such as \"claude-cli\".";
          };
        }; });
          default = null;
          description = "Optional per-model runtime policy for this agent. Use this for agent-specific model exceptions instead of setting a whole-agent runtime.";
        };
        alias = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        params = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.anything));
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; }));
        default = null;
        description = "Per-agent model catalog overrides keyed by full provider/model IDs.";
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      params = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.anything));
        default = null;
      };
      reasoningDefault = lib.mkOption {
        type = t.nullOr (t.enum [ "on" "off" "stream" ]);
        default = null;
        description = "Optional per-agent default reasoning visibility (on|off|stream). Applies when no per-message or session reasoning override is set.";
      };
      runtime = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.submodule { options = {
        type = lib.mkOption {
          type = t.enum [ "embedded" ];
          description = "Runtime type for this agent: \"embedded\" (default OpenClaw runtime) or \"acp\" (ACP harness defaults).";
        };
      }; }) (t.submodule { options = {
        acp = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          agent = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional ACP harness agent id to use for this OpenClaw agent (for example codex, claude, cursor, gemini, openclaw).";
          };
          backend = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional ACP backend override for this agent's ACP sessions (falls back to global acp.backend).";
          };
          cwd = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional default working directory for this agent's ACP sessions.";
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "persistent" "oneshot" ]);
            default = null;
            description = "Optional ACP session mode default for this agent (persistent or oneshot).";
          };
        }; });
          default = null;
          description = "ACP runtime defaults for this agent when runtime.type=acp. Binding-level ACP overrides still take precedence per conversation.";
        };
        type = lib.mkOption {
          type = t.enum [ "acp" ];
          description = "Runtime type for this agent: \"embedded\" (default OpenClaw runtime) or \"acp\" (ACP harness defaults).";
        };
      }; }) ]);
        default = null;
        description = "Optional runtime descriptor for this agent. Use embedded for default OpenClaw execution or acp for external ACP harness defaults.";
      };
      sandbox = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        backend = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        browser = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowHostControl = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          autoStart = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          autoStartTimeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          binds = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          cdpPort = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          cdpSourceRange = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Per-agent override for CDP source CIDR allowlist.";
          };
          containerPrefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          headless = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          image = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          network = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Per-agent override for the sandbox browser Docker network. Use a bridge network; \"none\" is unsupported because browser control requires published CDP ports.";
          };
          noVncEnabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          noVncPort = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          vncPort = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        docker = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          apparmorProfile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          binds = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          capDrop = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          containerPrefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          cpus = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          dangerouslyAllowContainerNamespaceJoin = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Per-agent DANGEROUS override for container namespace joins in sandbox Docker network mode.";
          };
          dangerouslyAllowExternalBindSources = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          dangerouslyAllowReservedContainerTargets = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          dns = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          env = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.str));
            default = null;
          };
          extraHosts = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          gpus = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Per-agent Docker GPU passthrough override for sandbox containers.";
          };
          image = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          memory = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
            default = null;
          };
          memorySwap = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
            default = null;
          };
          network = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          pidsLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          readOnlyRoot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          seccompProfile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          setupCommand = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.listOf (t.str)) ]);
            default = null;
          };
          tmpfs = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          ulimits = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.submodule { options = {
            hard = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            soft = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; }) ]));
            default = null;
          };
          user = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          workdir = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "non-main" ]) (t.enum [ "all" ]) ]);
          default = null;
        };
        prune = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          idleHours = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxAgeDays = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        scope = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "session" ]) (t.enum [ "agent" ]) (t.enum [ "shared" ]) ]);
          default = null;
        };
        sessionToolsVisibility = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "spawned" ]) (t.enum [ "all" ]) ]);
          default = null;
        };
        ssh = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          certificateData = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          certificateFile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          command = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          identityData = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          identityFile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          knownHostsData = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          knownHostsFile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          strictHostKeyChecking = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          target = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          updateHostKeys = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          workspaceRoot = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        workspaceAccess = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "ro" ]) (t.enum [ "rw" ]) ]);
          default = null;
        };
        workspaceRoot = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      skills = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional allowlist of skills for this agent. If omitted, the agent inherits agents.defaults.skills when set; otherwise skills stay unrestricted. Set [] for no skills. An explicit list fully replaces inherited defaults instead of merging with them.";
      };
      skillsLimits = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        maxSkillsPromptChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Per-agent override for the skills prompt character budget. This extends the existing skills.limits.maxSkillsPromptChars path instead of routing the same budget through contextLimits.";
        };
      }; });
        default = null;
        description = "Optional per-agent overrides for skills subsystem budgets. Use this when an agent needs a different skills prompt budget without introducing a second generic context-limits path.";
      };
      subagents = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowAgents = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        delegationMode = lib.mkOption {
          type = t.nullOr (t.enum [ "suggest" "prefer" ]);
          default = null;
          description = "Per-agent override for sub-agent delegation strength. Use this for coordinator agents that should stay responsive and push non-trivial work into spawned sub-agents.";
        };
        model = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          fallbacks = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          primary = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }) ]);
          default = null;
        };
        requireAgentId = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        thinking = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      thinkingDefault = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "minimal" "low" "medium" "high" "xhigh" "adaptive" "max" "ultra" ]);
        default = null;
        description = "Optional per-agent default thinking level. Overrides agents.defaults.thinkingDefault for this agent when no per-message or session override is set.";
      };
      toolProgressDetail = lib.mkOption {
        type = t.nullOr (t.enum [ "explain" "raw" ]);
        default = null;
      };
      tools = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        alsoAllow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Per-agent additive allowlist for tools on top of global and profile policy. Keep narrow to avoid accidental privilege expansion on specialized agents.";
        };
        byProvider = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          profile = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "minimal" ]) (t.enum [ "coding" ]) (t.enum [ "messaging" ]) (t.enum [ "full" ]) ]);
            default = null;
          };
        }; }));
          default = null;
          description = "Per-agent provider-specific tool policy overrides for channel-scoped capability control. Use this when a single agent needs tighter restrictions on one provider than others.";
        };
        codeMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          languages = lib.mkOption {
            type = t.nullOr (t.listOf (t.enum [ "javascript" "typescript" ]));
            default = null;
          };
          maxOutputBytes = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxPendingToolCalls = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxSearchLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxSnapshotBytes = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          memoryLimitBytes = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "only" ]);
            default = null;
          };
          runtime = lib.mkOption {
            type = t.nullOr (t.enum [ "quickjs-wasi" ]);
            default = null;
          };
          searchDefaultLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          snapshotTtlSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }) ]);
          default = null;
          description = "Per-agent code mode override. Use this to test or roll out exec/wait tool-surface mode for one agent without enabling it fleet-wide.";
        };
        deny = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        elevated = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowFrom = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.listOf (t.oneOf [ (t.str) (t.number) ])));
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        exec = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          applyPatch = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allowModels = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            workspaceOnly = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          approvalRunningNoticeMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          ask = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "on-miss" "always" ]);
            default = null;
          };
          backgroundMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          cleanupMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          commandHighlighting = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          host = lib.mkOption {
            type = t.nullOr (t.enum [ "auto" "sandbox" "gateway" "node" ]);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "deny" "allowlist" "ask" "auto" "full" ]);
            default = null;
          };
          node = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          notifyOnExit = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          notifyOnExitEmptySuccess = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          pathPrepend = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          reviewer = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            model = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              fallbacks = lib.mkOption {
                type = t.nullOr (t.listOf (t.str));
                default = null;
              };
              primary = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; }) ]);
              default = null;
            };
            timeoutMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          safeBinProfiles = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allowedValueFlags = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deniedFlags = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            maxPositional = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minPositional = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; }));
            default = null;
          };
          safeBinTrustedDirs = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          safeBins = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          security = lib.mkOption {
            type = t.nullOr (t.enum [ "deny" "allowlist" "full" ]);
            default = null;
          };
          strictInlineEval = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          timeoutSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        fs = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          workspaceOnly = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        loopDetection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        message = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          actions = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
              description = "Per-agent message action allowlist for the message tool. Set to a minimal list such as [\"send\"] for public sandbox agents so read, edit, delete, reaction, and other provider-specific message actions stay hidden and blocked.";
            };
          }; });
            default = null;
          };
          broadcast = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          crossContext = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allowAcrossProviders = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
              description = "Per-agent message guard for sending across providers. Keep false for public or sandboxed agents.";
            };
            allowWithinProvider = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
              description = "Per-agent message guard for sending to other conversations on the same provider. Set false for current-conversation-only public agents.";
            };
            marker = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              enabled = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              prefix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              suffix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        profile = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "minimal" ]) (t.enum [ "coding" ]) (t.enum [ "messaging" ]) (t.enum [ "full" ]) ]);
          default = null;
          description = "Per-agent override for tool profile selection when one agent needs a different capability baseline. Use this sparingly so policy differences across agents stay intentional and reviewable.";
        };
        sandbox = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        swarm = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
          defaultAgentId = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxChildrenPerGroup = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxConcurrent = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxTotalPerGroup = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          waitTimeoutSecondsMax = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }) ]);
          default = null;
          description = "Per-agent swarm override. Values merge over the top-level tools.swarm configuration.";
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
      }; });
        default = null;
      };
      tts = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        auto = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "always" "inbound" "tagged" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxTextLength = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "final" "all" ]);
          default = null;
        };
        modelOverrides = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowModelId = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          allowNormalization = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          allowProvider = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          allowSeed = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          allowText = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          allowVoice = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          allowVoiceSettings = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        persona = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        personas = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          description = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          fallbackPolicy = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "preserve-persona" ]) (t.enum [ "provider-defaults" ]) (t.enum [ "fail" ]) ]);
            default = null;
          };
          label = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          provider = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          providers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            apiKey = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        prefsPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        provider = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        providers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          apiKey = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
        }; }));
          default = null;
        };
        summaryModel = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      typingMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "never" ]) (t.enum [ "instant" ]) (t.enum [ "thinking" ]) (t.enum [ "message" ]) ]);
        default = null;
        description = "Overrides the default typing start policy for one agent without changing other agents.";
      };
      utilityModel = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional per-agent utility model override for short internal tasks. Overrides agents.defaults.utilityModel.";
      };
      verboseDefault = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "on" "full" ]);
        default = null;
      };
      workspace = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; }));
      default = null;
      description = "Explicit list of configured agents with IDs and optional overrides for model, tools, identity, and workspace. Keep IDs stable over time so bindings, approvals, and session routing remain deterministic.";
    };
    ownership = lib.mkOption {
      type = t.nullOr (t.enum [ "explicit" ]);
      default = null;
      description = "Durable multi-agent ownership generation marker. \"explicit\" means ambient channels, heartbeat, system-agent consults, Talk, cron, and bare CLI operations must resolve a surface-specific owner or fail closed. OpenClaw stamps this automatically when creating or migrating a fleet; omit it for a sole agent.";
    };
  }; });
    default = null;
    description = "Agent runtime configuration root. Root siblings own infrastructure and cross-agent defaults; agents.defaults owns agent-loop behavior; agent entries may override either where supported.";
  };

  approvals = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    exec = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      agentFilter = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional allowlist of agent IDs eligible for forwarded approvals, for example `[\"primary\", \"ops-agent\"]`. Use this to limit forwarding blast radius and avoid notifying channels for unrelated agents.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables forwarding of exec approval requests to configured delivery destinations (default: false). Keep disabled in low-risk setups and enable only when human approval responders need channel-visible prompts.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "session" ]) (t.enum [ "targets" ]) (t.enum [ "both" ]) ]);
        default = null;
        description = "Controls where approval prompts are sent: \"session\" uses origin chat, \"targets\" uses configured targets, and \"both\" sends to both paths. Use \"session\" as baseline and expand only when operational workflow requires redundancy.";
      };
      sessionFilter = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional session-key filters matched as substring or regex-style patterns, for example `[\"discord:\", \"^agent:ops:\"]`. Use narrow patterns so only intended approval contexts are forwarded to shared destinations.";
      };
      targets = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        accountId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Optional account selector for multi-account channel setups when approvals must route through a specific account context. Use this only when the target channel has multiple configured identities.";
        };
        channel = lib.mkOption {
          type = t.str;
          description = "Channel/provider ID used for forwarded approval delivery, such as discord, slack, or a plugin channel id. Use valid channel IDs only so approvals do not silently fail due to unknown routes.";
        };
        threadId = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
          default = null;
          description = "Optional thread/topic target for channels that support threaded delivery of forwarded approvals. Use this to keep approval traffic contained in operational threads instead of main channels.";
        };
        to = lib.mkOption {
          type = t.str;
          description = "Destination identifier inside the target channel (channel ID, user ID, or thread root depending on provider). Verify semantics per provider because destination format differs across channel integrations.";
        };
      }; }));
        default = null;
        description = "Explicit delivery targets used when forwarding mode includes targets, each with channel and destination details. Keep target lists least-privilege and validate each destination before enabling broad forwarding.";
      };
    }; });
      default = null;
      description = "Groups exec-approval forwarding behavior including enablement, routing mode, filters, and explicit targets. Configure here when approval prompts must reach operational channels instead of only the origin thread.";
    };
    plugin = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      agentFilter = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional allowlist of agent IDs eligible for forwarded plugin approvals, for example `[\"primary\", \"ops-agent\"]`. Use this to limit forwarding blast radius.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables forwarding of plugin approval requests to configured delivery destinations (default: false). Independent of approvals.exec.enabled.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "session" ]) (t.enum [ "targets" ]) (t.enum [ "both" ]) ]);
        default = null;
        description = "Controls where plugin approval prompts are sent: \"session\" uses origin chat, \"targets\" uses configured targets, and \"both\" sends to both paths.";
      };
      sessionFilter = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional session-key filters matched as substring or regex-style patterns, for example `[\"discord:\", \"^agent:ops:\"]`. Use narrow patterns so only intended approval contexts are forwarded.";
      };
      targets = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        accountId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Optional account selector for multi-account channel setups when plugin approvals must route through a specific account context.";
        };
        channel = lib.mkOption {
          type = t.str;
          description = "Channel/provider ID used for forwarded plugin approval delivery, such as discord, slack, or a plugin channel id.";
        };
        threadId = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
          default = null;
          description = "Optional thread/topic target for channels that support threaded delivery of forwarded plugin approvals.";
        };
        to = lib.mkOption {
          type = t.str;
          description = "Destination identifier inside the target channel (channel ID, user ID, or thread root depending on provider).";
        };
      }; }));
        default = null;
        description = "Explicit delivery targets used when plugin approval forwarding mode includes targets, each with channel and destination details.";
      };
    }; });
      default = null;
      description = "Groups plugin-approval forwarding behavior including enablement, routing mode, filters, and explicit targets. Independent of exec approval forwarding. Configure here when plugin approval prompts must reach operational channels.";
    };
  }; });
    default = null;
    description = "Approval routing controls for forwarding exec and plugin approval requests to chat destinations outside the originating session. Keep these disabled unless operators need explicit out-of-band approval visibility.";
  };

  attachments = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    ttlHours = lib.mkOption {
      type = t.nullOr (t.int);
      default = null;
      description = "Optional retention window in hours for persisted media handled by the general mtime sweep. Leave unset to disable that sweep, or set values like 24 (1 day) or 168 (7 days) to periodically remove older staged media. Managed outgoing media (chat-generated attachments) is excluded and follows its own SQLite- and transcript-aware retention.";
    };
  }; });
    default = null;
    description = "Top-level retention behavior shared across providers and tools that persist media. Use ttlHours when general staged media needs bounded cleanup.";
  };

  auth = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    order = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.listOf (t.str)));
      default = null;
      description = "Ordered auth profile IDs per provider (used for automatic failover).";
    };
    profiles = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      displayName = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      email = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      mode = lib.mkOption {
        type = t.oneOf [ (t.enum [ "api_key" ]) (t.enum [ "aws-sdk" ]) (t.enum [ "oauth" ]) (t.enum [ "token" ]) ];
      };
      provider = lib.mkOption {
        type = t.str;
      };
    }; }));
      default = null;
      description = "Named auth profiles (provider + mode + optional email).";
    };
  }; });
    default = null;
    description = "Authentication profile root used for multi-profile provider credentials and cooldown-based failover ordering. Keep profiles minimal and explicit so automatic failover behavior stays auditable.";
  };

  bindings = lib.mkOption {
    type = t.nullOr (t.listOf (t.oneOf [ (t.submodule { options = {
    agentId = lib.mkOption {
      type = t.str;
      description = "Target agent ID that receives traffic when the corresponding binding match rule is satisfied. Use valid configured agent IDs only so routing does not fail at runtime.";
    };
    comment = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
    };
    match = lib.mkOption {
      type = t.submodule { options = {
      accountId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional account selector for multi-account channel setups so the binding applies only to one identity. Use this when account scoping is required for the route and leave unset otherwise.";
      };
      channel = lib.mkOption {
        type = t.str;
        description = "Channel/provider identifier this binding applies to, such as `telegram`, `discord`, or a plugin channel ID. Use the configured channel key exactly so binding evaluation works reliably.";
      };
      guildId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional Discord-style guild/server ID constraint for binding evaluation in multi-server deployments. Use this when the same peer identifiers can appear across different guilds.";
      };
      peer = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        id = lib.mkOption {
          type = t.str;
          description = "Conversation identifier used with peer matching, such as a chat ID, channel ID, or group ID from the provider. Keep this exact to avoid silent non-matches.";
        };
        kind = lib.mkOption {
          type = t.oneOf [ (t.enum [ "direct" ]) (t.enum [ "group" ]) (t.enum [ "channel" ]) ];
          description = "Peer conversation type: \"direct\", \"group\", \"channel\", or legacy \"dm\" (deprecated alias for direct). Prefer \"direct\" for new configs and keep kind aligned with channel semantics.";
        };
      }; });
        default = null;
        description = "Optional peer matcher for specific conversations including peer kind and peer id. Use this when only one direct/group/channel target should be pinned to an agent.";
      };
      roles = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional role-based filter list used by providers that attach roles to chat context. Use this to route privileged or operational role traffic to specialized agents.";
      };
      teamId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional team/workspace ID constraint used by providers that scope chats under teams. Add this when you need bindings isolated to one workspace context.";
      };
    }; };
      description = "Match rule object for deciding when a binding applies, including channel and optional account/peer constraints. Keep rules narrow to avoid accidental agent takeover across contexts.";
    };
    session = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      dmScope = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "main" ]) (t.enum [ "per-peer" ]) (t.enum [ "per-channel-peer" ]) (t.enum [ "per-account-channel-peer" ]) ]);
        default = null;
        description = "Optional DM session scope override for this route binding. For example, keep global session.dmScope=\"main\" while using \"per-account-channel-peer\" for selected direct peers.";
      };
    }; });
      default = null;
      description = "Optional route session overrides for conversations matched by this binding. Use this when a narrow route should keep the same agent but isolate session continuity differently.";
    };
    type = lib.mkOption {
      type = t.nullOr (t.enum [ "route" ]);
      default = null;
      description = "Binding kind. Use \"route\" (or omit for legacy route entries) for normal routing, and \"acp\" for persistent ACP conversation bindings.";
    };
  }; }) (t.submodule { options = {
    acp = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      backend = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "ACP backend override for this binding (falls back to agent runtime ACP backend, then global acp.backend).";
      };
      cwd = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Working directory override for ACP sessions created from this binding.";
      };
      label = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Human-friendly label for ACP status/diagnostics in this bound conversation.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "persistent" "oneshot" ]);
        default = null;
        description = "ACP session mode override for this binding (persistent or oneshot).";
      };
    }; });
      default = null;
      description = "Optional per-binding ACP overrides for bindings[].type=acp. This layer overrides agents.entries.*.runtime.acp defaults for the matched conversation.";
    };
    agentId = lib.mkOption {
      type = t.str;
      description = "Target agent ID that receives traffic when the corresponding binding match rule is satisfied. Use valid configured agent IDs only so routing does not fail at runtime.";
    };
    comment = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
    };
    match = lib.mkOption {
      type = t.submodule { options = {
      accountId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional account selector for multi-account channel setups so the binding applies only to one identity. Use this when account scoping is required for the route and leave unset otherwise.";
      };
      channel = lib.mkOption {
        type = t.str;
        description = "Channel/provider identifier this binding applies to, such as `telegram`, `discord`, or a plugin channel ID. Use the configured channel key exactly so binding evaluation works reliably.";
      };
      guildId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional Discord-style guild/server ID constraint for binding evaluation in multi-server deployments. Use this when the same peer identifiers can appear across different guilds.";
      };
      peer = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        id = lib.mkOption {
          type = t.str;
          description = "Conversation identifier used with peer matching, such as a chat ID, channel ID, or group ID from the provider. Keep this exact to avoid silent non-matches.";
        };
        kind = lib.mkOption {
          type = t.oneOf [ (t.enum [ "direct" ]) (t.enum [ "group" ]) (t.enum [ "channel" ]) ];
          description = "Peer conversation type: \"direct\", \"group\", \"channel\", or legacy \"dm\" (deprecated alias for direct). Prefer \"direct\" for new configs and keep kind aligned with channel semantics.";
        };
      }; });
        default = null;
        description = "Optional peer matcher for specific conversations including peer kind and peer id. Use this when only one direct/group/channel target should be pinned to an agent.";
      };
      roles = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional role-based filter list used by providers that attach roles to chat context. Use this to route privileged or operational role traffic to specialized agents.";
      };
      teamId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional team/workspace ID constraint used by providers that scope chats under teams. Add this when you need bindings isolated to one workspace context.";
      };
    }; };
      description = "Match rule object for deciding when a binding applies, including channel and optional account/peer constraints. Keep rules narrow to avoid accidental agent takeover across contexts.";
    };
    type = lib.mkOption {
      type = t.enum [ "acp" ];
      description = "Binding kind. Use \"route\" (or omit for legacy route entries) for normal routing, and \"acp\" for persistent ACP conversation bindings.";
    };
  }; }) ]));
    default = null;
    description = "Top-level binding rules for routing and persistent ACP conversation ownership. Use type=route for normal routing and type=acp for persistent ACP harness bindings.";
  };

  broadcast = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    strategy = lib.mkOption {
      type = t.nullOr (t.enum [ "parallel" "sequential" ]);
      default = null;
      description = "Delivery order for broadcast fan-out: \"parallel\" sends to all targets concurrently, while \"sequential\" sends one-by-one. Use \"parallel\" for speed and \"sequential\" for stricter ordering/backpressure control.";
    };
  }; });
    default = null;
    description = "Broadcast routing map for sending the same outbound message to multiple peer IDs per source conversation. Keep this minimal and audited because one source can fan out to many destinations.";
  };

  browser = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    allowSystemProfileImport = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allows macOS hosts to import cookies from a local Chrome-family system profile into a managed OpenClaw browser profile. Disable this to prevent browser profile cookie import and its macOS Keychain consent prompt.";
    };
    attachOnly = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Restricts browser mode to attach-only behavior without starting local browser processes. Use this when all browser sessions are externally managed by a remote CDP provider.";
    };
    cdpUrl = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "CDP/DevTools endpoint URL used to attach to an externally managed browser instance. Use this for centralized browser hosts, tunnels, or existing-session attachment, and keep URL access restricted to trusted network paths.";
    };
    defaultProfile = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Default browser profile name selected when callers do not explicitly choose a profile. Use a stable low-privilege profile as the default to reduce accidental cross-context state use.";
    };
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables browser capability wiring in the gateway so browser tools and CDP-driven workflows can run. Disable when browser automation is not needed to reduce surface area and startup work.";
    };
    evaluateEnabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables browser-side evaluate helpers for runtime script evaluation capabilities where supported. Keep disabled unless your workflows require evaluate semantics beyond snapshots/navigation.";
    };
    executablePath = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Explicit browser executable path when auto-discovery is insufficient for your host environment. Use an absolute stable path, or a path starting with ~ for your OS home directory, so launch behavior stays deterministic across restarts.";
    };
    extensionRelay = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowLegacyAuth = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Temporarily accepts legacy Bearer, Basic, and token-subprotocol relay authentication. Default: true for one migration window. Set false after every extension and external CDP client uses Browser Relay Authentication v2.";
      };
    }; });
      default = null;
      description = "Chrome extension relay authentication compatibility settings. Keep the legacy window only while older paired extensions or external CDP clients still need it.";
    };
    extraArgs = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
    };
    headless = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Forces browser launch in headless mode when the local launcher starts browser instances. Keep headless enabled for server environments and disable only when visible UI debugging is required.";
    };
    noSandbox = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Disables Chromium sandbox isolation flags for environments where sandboxing fails at runtime. Keep this off whenever possible because process isolation protections are reduced.";
    };
    profiles = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      attachOnly = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Per-profile attach-only override that skips local browser launch and only attaches to an existing CDP endpoint. Useful when one profile is externally managed but others are locally launched.";
      };
      cdpPort = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Per-profile local CDP port used when connecting to browser instances by port instead of URL. Use unique ports per profile to avoid connection collisions.";
      };
      cdpUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Per-profile CDP/DevTools endpoint URL used for explicit browser routing by profile name. Use this for remote CDP hosts, tunnels, or existing-session profiles that should attach through a running Chrome DevTools endpoint.";
      };
      driver = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "openclaw" ]) (t.enum [ "clawd" ]) (t.enum [ "existing-session" ]) (t.enum [ "extension" ]) ]);
        default = null;
        description = "Per-profile browser driver mode. Use \"openclaw\" (or legacy \"clawd\") for CDP-based profiles, \"existing-session\" for Chrome DevTools MCP attachment, or \"extension\" for the authenticated Chrome extension relay.";
      };
      executablePath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Per-profile browser executable path for locally launched managed browser profiles. Overrides browser.executablePath and accepts paths starting with ~ for the OS home directory.";
      };
      headless = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Per-profile headless override for locally launched browser instances. Use this when one profile should stay headless without forcing browser.headless for every other profile.";
      };
      mcpArgs = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Extra per-profile Chrome DevTools MCP arguments for existing-session attachment, such as --no-usage-statistics. Endpoint arguments here override the built-in auto-connect or browser URL selection.";
      };
      mcpCommand = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Per-profile Chrome DevTools MCP command for existing-session attachment. Defaults to npx.";
      };
      userDataDir = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Per-profile Chromium user data directory for existing-session attachment through Chrome DevTools MCP. Use this for Brave, Edge, Chromium, or non-default Chrome profiles when the built-in auto-connect path would pick the wrong browser data directory on the selected host or browser node. Paths starting with ~ expand to the OS home directory.";
      };
    }; }));
      default = null;
      description = "Named browser profile connection map used for explicit routing to CDP ports or URLs with optional metadata. Keep profile names consistent and avoid overlapping endpoint definitions.";
    };
    snapshotDefaults = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "efficient" ]);
        default = null;
        description = "Default snapshot extraction mode controlling how page content is transformed for agent consumption. Choose the mode that balances readability, fidelity, and token footprint for your workflows.";
      };
    }; });
      default = null;
      description = "Default snapshot capture configuration used when callers do not provide explicit snapshot options. Tune this for consistent capture behavior across channels and automation paths.";
    };
    ssrfPolicy = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowIpv6UniqueLocalRange = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allow IPv6 Unique Local Addresses (fc00::/7) for trusted fake-IP proxy environments.";
      };
      allowRfc2544BenchmarkRange = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allow RFC 2544 benchmark-range IPs (198.18.0.0/15) for trusted fake-IP proxy environments.";
      };
      allowedHostnames = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Exact hostnames or IP literals allowed by browser SSRF policy checks. Keep the list minimal.";
      };
      dangerouslyAllowPrivateNetwork = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows access to private-network address ranges from browser tooling. Default is disabled when unset; enable only for explicitly trusted private-network destinations.";
      };
    }; });
      default = null;
      description = "Server-side request forgery guardrail settings for browser/network fetch paths that could reach internal hosts. Keep restrictive defaults in production and open only explicitly approved targets.";
    };
    tabCleanup = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables cleanup of idle tracked browser tabs for primary-agent sessions. Disable only when external tooling owns tab lifecycle completely.";
      };
    }; });
      default = null;
      description = "Best-effort cleanup policy for browser tabs opened by primary-agent sessions. Keep enabled to avoid stale sandbox or managed-browser tabs accumulating across long-lived gateways.";
    };
  }; });
    default = null;
    description = "Browser runtime controls for local or remote CDP attachment, profile routing, and screenshot/snapshot behavior. Keep defaults unless your automation workflow requires custom browser transport settings.";
  };

  channels = lib.mkOption {
    type = t.nullOr (t.submodule { freeformType = t.attrsOf t.anything; options = {
    buzz = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      authTag = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; }));
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      privateKey = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      relayUrl = lib.mkOption {
        type = t.nullOr (t.anything);
        default = null;
      };
    }; });
      default = null;
    };
    clickclack = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        agentActivity = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        agentId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        allowBots = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        apiBaseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        botUserId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        commandMenu = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        discussions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          controlUrlBase = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          section = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          workspace = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowBots = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
            default = null;
          };
          botLoopProtection = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            cooldownSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            maxEventsPerWindow = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            windowSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          mentionPatterns = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; }));
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        model = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        nativeProgress = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reconnectMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        replyMode = lib.mkOption {
          type = t.nullOr (t.enum [ "agent" "model" ]);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        token = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        tokenFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        toolsAllow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        workspace = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      agentActivity = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      agentId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      allowBots = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      apiBaseUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      baseUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      botLoopProtection = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        cooldownSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxEventsPerWindow = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        windowSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      botUserId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      commandMenu = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      discussions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        controlUrlBase = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        section = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        workspace = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowBots = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; }));
        default = null;
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      model = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      nativeProgress = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      reconnectMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      replyMode = lib.mkOption {
        type = t.nullOr (t.enum [ "agent" "model" ]);
        default = null;
      };
      requireMention = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      systemPrompt = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      token = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      tokenFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      toolsAllow = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      workspace = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    discord = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        ackReaction = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        ackReactionScope = lib.mkOption {
          type = t.nullOr (t.enum [ "group-mentions" "group-all" "direct" "all" "off" "none" ]);
          default = null;
        };
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          channelInfo = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          channels = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          emojiUploads = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          events = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          memberInfo = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          messages = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          moderation = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          permissions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          pins = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          polls = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          presence = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          roleInfo = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          roles = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          search = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          stickerUploads = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          stickers = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          threads = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          voiceStatus = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        activities = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          applicationId = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          clientSecret = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        activity = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        activityType = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ 0 ]) (t.enum [ 1 ]) (t.enum [ 2 ]) (t.enum [ 3 ]) (t.enum [ 4 ]) (t.enum [ 5 ]) ]);
          default = null;
        };
        activityUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        agentComponents = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          ttlMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        allowBots = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        applicationId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        autoPresence = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          intervalMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          minUpdateIntervalMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        commands = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          native = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          nativeSkills = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        dangerouslyAllowNameMatching = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        dm = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          groupChannels = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          groupEnabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        execApprovals = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          agentFilter = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          approvers = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          cleanupAfterResolve = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          sessionFilter = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          target = lib.mkOption {
            type = t.nullOr (t.enum [ "dm" "channel" "both" ]);
            default = null;
          };
        }; });
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        guilds = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          channels = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            autoArchiveDuration = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "60" "1440" "4320" "10080" ]) (t.enum [ 60 ]) (t.enum [ 1440 ]) (t.enum [ 4320 ]) (t.enum [ 10080 ]) ]);
              default = null;
            };
            autoThread = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            autoThreadName = lib.mkOption {
              type = t.nullOr (t.enum [ "message" "generated" ]);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            ignoreOtherMentions = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            includeThreadStarter = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            requireMention = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            roles = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            skills = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            systemPrompt = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            tools = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              allow = lib.mkOption {
                type = t.nullOr (t.listOf (t.str));
                default = null;
              };
              alsoAllow = lib.mkOption {
                type = t.nullOr (t.listOf (t.str));
                default = null;
              };
              deny = lib.mkOption {
                type = t.nullOr (t.listOf (t.str));
                default = null;
              };
            }; });
              default = null;
            };
            toolsBySender = lib.mkOption {
              type = t.nullOr (t.attrsOf (t.submodule { options = {
              allow = lib.mkOption {
                type = t.nullOr (t.listOf (t.str));
                default = null;
              };
              alsoAllow = lib.mkOption {
                type = t.nullOr (t.listOf (t.str));
                default = null;
              };
              deny = lib.mkOption {
                type = t.nullOr (t.listOf (t.str));
                default = null;
              };
            }; }));
              default = null;
            };
            users = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
          ignoreOtherMentions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          presenceEvents = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            burstLimit = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            burstWindowSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            channelId = lib.mkOption {
              type = t.str;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            reconnectSuppressSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            users = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          reactionNotifications = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "own" "all" "allowlist" ]);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          roles = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          slug = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
          users = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
        healthMonitor = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          showAlerts = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          showOk = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          useIndicator = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        inboundWorker = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          runTimeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        intents = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          guildMembers = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          messageContent = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          presence = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          voiceStates = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        maxLinesPerMessage = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        mentionAliases = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          denyIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        pluralkit = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          token = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "store" "file" "exec" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
        }; });
          default = null;
        };
        proxy = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        slashCommand = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          ephemeral = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        status = lib.mkOption {
          type = t.nullOr (t.enum [ "online" "dnd" "idle" "invisible" ]);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
            default = null;
          };
          preview = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            chunk = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              breakPreference = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          progress = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            commentary = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            label = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
              default = null;
            };
            labels = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            maxLineChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxLines = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            narration = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        suppressEmbeds = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        thread = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          inheritParent = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        threadBindings = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          defaultSpawnContext = lib.mkOption {
            type = t.nullOr (t.enum [ "isolated" "fork" ]);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          idleHours = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          maxAgeHours = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          spawnSessions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        token = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        voice = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          agentSession = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            mode = lib.mkOption {
              type = t.nullOr (t.enum [ "voice" "target" ]);
              default = null;
            };
            target = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; });
            default = null;
          };
          allowedChannels = lib.mkOption {
            type = t.nullOr (t.listOf (t.submodule { options = {
            channelId = lib.mkOption {
              type = t.str;
            };
            guildId = lib.mkOption {
              type = t.str;
            };
          }; }));
            default = null;
          };
          autoJoin = lib.mkOption {
            type = t.nullOr (t.listOf (t.submodule { options = {
            channelId = lib.mkOption {
              type = t.str;
            };
            guildId = lib.mkOption {
              type = t.str;
            };
          }; }));
            default = null;
          };
          captureSilenceGraceMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          connectTimeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          daveEncryption = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          decryptionFailureTolerance = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          followUsers = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          followUsersEnabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "stt-tts" "agent-proxy" "bidi" ]);
            default = null;
          };
          model = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          realtime = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            bargeIn = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            bootstrapContextFiles = lib.mkOption {
              type = t.nullOr (t.listOf (t.enum [ "IDENTITY.md" "USER.md" "SOUL.md" ]));
              default = null;
            };
            consultPolicy = lib.mkOption {
              type = t.nullOr (t.enum [ "auto" "always" ]);
              default = null;
            };
            debounceMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            instructions = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            minBargeInAudioEndMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            model = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            provider = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            providers = lib.mkOption {
              type = t.nullOr (t.attrsOf (t.attrsOf (t.anything)));
              default = null;
            };
            requireWakeName = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            speakerVoice = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            speakerVoiceId = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            toolPolicy = lib.mkOption {
              type = t.nullOr (t.enum [ "safe-read-only" "owner" "none" ]);
              default = null;
            };
            wakeNames = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          reconnectGraceMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          tts = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            auto = lib.mkOption {
              type = t.nullOr (t.enum [ "off" "always" "inbound" "tagged" ]);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            maxTextLength = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            mode = lib.mkOption {
              type = t.nullOr (t.enum [ "final" "all" ]);
              default = null;
            };
            modelOverrides = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              allowModelId = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              allowNormalization = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              allowProvider = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              allowSeed = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              allowText = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              allowVoice = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              allowVoiceSettings = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              enabled = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
            }; });
              default = null;
            };
            persona = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            personas = lib.mkOption {
              type = t.nullOr (t.attrsOf (t.submodule { options = {
              description = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              fallbackPolicy = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "preserve-persona" ]) (t.enum [ "provider-defaults" ]) (t.enum [ "fail" ]) ]);
                default = null;
              };
              label = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              provider = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              providers = lib.mkOption {
                type = t.nullOr (t.attrsOf (t.submodule { options = {
                apiKey = lib.mkOption {
                  type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                  source = lib.mkOption {
                    type = t.enum [ "env" "file" "exec" "store" ];
                  };
                  id = lib.mkOption {
                    type = t.str;
                  };
                  provider = lib.mkOption {
                    type = t.str;
                  };
                }; }) ]);
                  default = null;
                };
              }; }));
                default = null;
              };
            }; }));
              default = null;
            };
            provider = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            providers = lib.mkOption {
              type = t.nullOr (t.attrsOf (t.submodule { options = {
              apiKey = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
            }; }));
              default = null;
            };
            summaryModel = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            timeoutMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
      }; }));
        default = null;
      };
      ackReaction = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      ackReactionScope = lib.mkOption {
        type = t.nullOr (t.enum [ "group-mentions" "group-all" "direct" "all" "off" "none" ]);
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        channelInfo = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        channels = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        emojiUploads = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        events = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        memberInfo = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        messages = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        moderation = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        permissions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        pins = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        polls = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        presence = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        roleInfo = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        roles = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        search = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        stickerUploads = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        stickers = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        threads = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        voiceStatus = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      activities = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        applicationId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        clientSecret = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      activity = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      activityType = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ 0 ]) (t.enum [ 1 ]) (t.enum [ 2 ]) (t.enum [ 3 ]) (t.enum [ 4 ]) (t.enum [ 5 ]) ]);
        default = null;
      };
      activityUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      agentComponents = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        ttlMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      allowBots = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      applicationId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      autoPresence = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        intervalMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        minUpdateIntervalMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      botLoopProtection = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        cooldownSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxEventsPerWindow = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        windowSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      commands = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        native = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        nativeSkills = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dm = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupChannels = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        groupEnabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      execApprovals = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        approvers = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        cleanupAfterResolve = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        sessionFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        target = lib.mkOption {
          type = t.nullOr (t.enum [ "dm" "channel" "both" ]);
          default = null;
        };
      }; });
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      guilds = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        channels = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          autoArchiveDuration = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "60" "1440" "4320" "10080" ]) (t.enum [ 60 ]) (t.enum [ 1440 ]) (t.enum [ 4320 ]) (t.enum [ 10080 ]) ]);
            default = null;
          };
          autoThread = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          autoThreadName = lib.mkOption {
            type = t.nullOr (t.enum [ "message" "generated" ]);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          ignoreOtherMentions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          includeThreadStarter = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          roles = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
          users = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
        ignoreOtherMentions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        presenceEvents = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          burstLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          burstWindowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          channelId = lib.mkOption {
            type = t.str;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reconnectSuppressSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          users = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        reactionNotifications = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "own" "all" "allowlist" ]);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        roles = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        slug = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
        users = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
      }; }));
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      inboundWorker = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        runTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      intents = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        guildMembers = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        messageContent = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        presence = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        voiceStates = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      maxLinesPerMessage = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      mentionAliases = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.str));
        default = null;
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        denyIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      pluralkit = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        token = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
      }; });
        default = null;
      };
      proxy = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      slashCommand = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        ephemeral = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      status = lib.mkOption {
        type = t.nullOr (t.enum [ "online" "dnd" "idle" "invisible" ]);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
          default = null;
        };
        preview = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          chunk = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            breakPreference = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        progress = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          commentary = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          label = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
            default = null;
          };
          labels = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          maxLineChars = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxLines = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          narration = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
      suppressEmbeds = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      thread = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        inheritParent = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      threadBindings = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        defaultSpawnContext = lib.mkOption {
          type = t.nullOr (t.enum [ "isolated" "fork" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        idleHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        maxAgeHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        spawnSessions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      token = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      voice = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentSession = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "voice" "target" ]);
            default = null;
          };
          target = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        allowedChannels = lib.mkOption {
          type = t.nullOr (t.listOf (t.submodule { options = {
          channelId = lib.mkOption {
            type = t.str;
          };
          guildId = lib.mkOption {
            type = t.str;
          };
        }; }));
          default = null;
        };
        autoJoin = lib.mkOption {
          type = t.nullOr (t.listOf (t.submodule { options = {
          channelId = lib.mkOption {
            type = t.str;
          };
          guildId = lib.mkOption {
            type = t.str;
          };
        }; }));
          default = null;
        };
        captureSilenceGraceMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        connectTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        daveEncryption = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        decryptionFailureTolerance = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        followUsers = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        followUsersEnabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "stt-tts" "agent-proxy" "bidi" ]);
          default = null;
        };
        model = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        realtime = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          bargeIn = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          bootstrapContextFiles = lib.mkOption {
            type = t.nullOr (t.listOf (t.enum [ "IDENTITY.md" "USER.md" "SOUL.md" ]));
            default = null;
          };
          consultPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "auto" "always" ]);
            default = null;
          };
          debounceMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          instructions = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          minBargeInAudioEndMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          model = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          provider = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          providers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.attrsOf (t.anything)));
            default = null;
          };
          requireWakeName = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          speakerVoice = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          speakerVoiceId = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          toolPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "safe-read-only" "owner" "none" ]);
            default = null;
          };
          wakeNames = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        reconnectGraceMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        tts = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          auto = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "always" "inbound" "tagged" ]);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxTextLength = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "final" "all" ]);
            default = null;
          };
          modelOverrides = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allowModelId = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowNormalization = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowProvider = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowSeed = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowText = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowVoice = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowVoiceSettings = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          persona = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          personas = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            description = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            fallbackPolicy = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "preserve-persona" ]) (t.enum [ "provider-defaults" ]) (t.enum [ "fail" ]) ]);
              default = null;
            };
            label = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            provider = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            providers = lib.mkOption {
              type = t.nullOr (t.attrsOf (t.submodule { options = {
              apiKey = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
            }; }));
              default = null;
            };
          }; }));
            default = null;
          };
          provider = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          providers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            apiKey = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
          }; }));
            default = null;
          };
          summaryModel = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
    }; });
      default = null;
    };
    feishu = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        allowBots = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        appId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        appSecret = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        connectionMode = lib.mkOption {
          type = t.nullOr (t.enum [ "websocket" "webhook" ]);
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }));
          default = null;
        };
        domain = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "feishu" "lark" ]) (t.str) ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        encryptKey = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "open" "disabled" "allowlist" ]) (t.enum [ "allowall" ]) ]);
          default = null;
        };
        groupSenderAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupSessionScope = lib.mkOption {
          type = t.nullOr (t.enum [ "group" "group_sender" "group_topic" "group_topic_sender" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          groupSessionScope = lib.mkOption {
            type = t.nullOr (t.enum [ "group" "group_sender" "group_topic" "group_topic_sender" ]);
            default = null;
          };
          replyInThread = lib.mkOption {
            type = t.nullOr (t.enum [ "disabled" "enabled" ]);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          topicSessionMode = lib.mkOption {
            type = t.nullOr (t.enum [ "disabled" "enabled" ]);
            default = null;
          };
        }; }));
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          intervalMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          visibility = lib.mkOption {
            type = t.nullOr (t.enum [ "visible" "hidden" ]);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        httpTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "native" "escape" "strip" ]);
            default = null;
          };
          tableMode = lib.mkOption {
            type = t.nullOr (t.enum [ "native" "ascii" "simple" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        reactionNotifications = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "own" "all" ]);
          default = null;
        };
        renderMode = lib.mkOption {
          type = t.nullOr (t.enum [ "auto" "raw" "card" ]);
          default = null;
        };
        replyInThread = lib.mkOption {
          type = t.nullOr (t.enum [ "disabled" "enabled" ]);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        resolveSenderNames = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "partial" ]);
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          bitable = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          chat = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          doc = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          drive = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          perm = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          scopes = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          wiki = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        topicSessionMode = lib.mkOption {
          type = t.nullOr (t.enum [ "disabled" "enabled" ]);
          default = null;
        };
        tts = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          auto = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "always" "inbound" "tagged" ]);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxTextLength = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "final" "all" ]);
            default = null;
          };
          modelOverrides = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.anything));
            default = null;
          };
          persona = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          personas = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.attrsOf (t.anything)));
            default = null;
          };
          prefsPath = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          provider = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          providers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.attrsOf (t.anything)));
            default = null;
          };
          summaryModel = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        typingIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        vcAutoJoin = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        verificationToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        webhookHost = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookPort = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowBots = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      appId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      appSecret = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      connectionMode = lib.mkOption {
        type = t.nullOr (t.enum [ "websocket" "webhook" ]);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      domain = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "feishu" "lark" ]) (t.str) ]);
        default = null;
      };
      dynamicAgentCreation = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentDirTemplate = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxAgents = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        workspaceTemplate = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      encryptKey = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "open" "disabled" "allowlist" ]) (t.enum [ "allowall" ]) ]);
        default = null;
      };
      groupSenderAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupSessionScope = lib.mkOption {
        type = t.nullOr (t.enum [ "group" "group_sender" "group_topic" "group_topic_sender" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupSessionScope = lib.mkOption {
          type = t.nullOr (t.enum [ "group" "group_sender" "group_topic" "group_topic_sender" ]);
          default = null;
        };
        replyInThread = lib.mkOption {
          type = t.nullOr (t.enum [ "disabled" "enabled" ]);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        topicSessionMode = lib.mkOption {
          type = t.nullOr (t.enum [ "disabled" "enabled" ]);
          default = null;
        };
      }; }));
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        intervalMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        visibility = lib.mkOption {
          type = t.nullOr (t.enum [ "visible" "hidden" ]);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      httpTimeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "native" "escape" "strip" ]);
          default = null;
        };
        tableMode = lib.mkOption {
          type = t.nullOr (t.enum [ "native" "ascii" "simple" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      reactionNotifications = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "own" "all" ]);
        default = null;
      };
      renderMode = lib.mkOption {
        type = t.nullOr (t.enum [ "auto" "raw" "card" ]);
        default = null;
      };
      replyInThread = lib.mkOption {
        type = t.nullOr (t.enum [ "disabled" "enabled" ]);
        default = null;
      };
      requireMention = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      resolveSenderNames = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "partial" ]);
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      tools = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        bitable = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        chat = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        doc = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        drive = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        perm = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        scopes = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        wiki = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      topicSessionMode = lib.mkOption {
        type = t.nullOr (t.enum [ "disabled" "enabled" ]);
        default = null;
      };
      tts = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        auto = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "always" "inbound" "tagged" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxTextLength = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "final" "all" ]);
          default = null;
        };
        modelOverrides = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.anything));
          default = null;
        };
        persona = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        personas = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.attrsOf (t.anything)));
          default = null;
        };
        prefsPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        provider = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        providers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.attrsOf (t.anything)));
          default = null;
        };
        summaryModel = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      typingIndicator = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      vcAutoJoin = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      verificationToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      webhookHost = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookPort = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
    };
    googlechat = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowBots = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        appPrincipal = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        audience = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        audienceType = lib.mkOption {
          type = t.nullOr (t.enum [ "app-url" "project-number" ]);
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        botUser = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        dangerouslyAllowNameMatching = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        dm = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          botLoopProtection = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            cooldownSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            maxEventsPerWindow = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            windowSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          users = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
        }; }));
          default = null;
        };
        healthMonitor = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          showAlerts = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          showOk = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          useIndicator = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        serviceAccount = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.attrsOf (t.anything)) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "file" "exec" "store" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        serviceAccountFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        typingIndicator = lib.mkOption {
          type = t.nullOr (t.enum [ "none" "message" "reaction" ]);
          default = null;
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      allowBots = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      appPrincipal = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      audience = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      audienceType = lib.mkOption {
        type = t.nullOr (t.enum [ "app-url" "project-number" ]);
        default = null;
      };
      botLoopProtection = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        cooldownSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxEventsPerWindow = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        windowSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      botUser = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dm = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        users = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
      }; }));
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
        default = null;
      };
      requireMention = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      serviceAccount = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.attrsOf (t.anything)) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      serviceAccountFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      typingIndicator = lib.mkOption {
        type = t.nullOr (t.enum [ "none" "message" "reaction" ]);
        default = null;
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    imessage = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          addParticipant = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          edit = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          leaveGroup = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          polls = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          removeParticipant = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          renameGroup = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reply = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          sendAttachment = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          sendWithEffect = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          setGroupIcon = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          unsend = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        attachmentRoots = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        catchup = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          firstRunLookbackMinutes = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxAgeMinutes = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxFailureRetries = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          perRunLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        cliPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        dbPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        healthMonitor = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          showAlerts = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          showOk = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          useIndicator = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        includeAttachments = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        probeTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        reactionNotifications = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "own" "all" ]);
          default = null;
        };
        region = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        remoteAttachmentRoots = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        remoteHost = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        sendReadReceipts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        sendTransport = lib.mkOption {
          type = t.nullOr (t.enum [ "auto" "bridge" "applescript" ]);
          default = null;
        };
        service = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "imessage" ]) (t.enum [ "sms" ]) (t.enum [ "auto" ]) ]);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        addParticipant = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        edit = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        leaveGroup = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        polls = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        removeParticipant = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        renameGroup = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reply = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        sendAttachment = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        sendWithEffect = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        setGroupIcon = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        unsend = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      attachmentRoots = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      catchup = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        firstRunLookbackMinutes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        maxAgeMinutes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        maxFailureRetries = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        perRunLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      cliPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      dbPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      includeAttachments = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      probeTimeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      reactionNotifications = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "own" "all" ]);
        default = null;
      };
      region = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      remoteAttachmentRoots = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      remoteHost = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      sendReadReceipts = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      sendTransport = lib.mkOption {
        type = t.nullOr (t.enum [ "auto" "bridge" "applescript" ]);
        default = null;
      };
      service = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "imessage" ]) (t.enum [ "sms" ]) (t.enum [ "auto" ]) ]);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
    };
    irc = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        channels = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        dangerouslyAllowNameMatching = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        host = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        nick = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        nickserv = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          password = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          passwordFile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          register = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          registerEmail = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          service = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        password = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        passwordFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        port = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        realname = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        tls = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        username = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      channels = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      host = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      nick = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      nickserv = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        password = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        passwordFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        register = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        registerEmail = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        service = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      password = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      passwordFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      port = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      realname = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      tls = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      username = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    line = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        channelAccessToken = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        channelSecret = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }));
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        secretFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        threadBindings = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          defaultSpawnContext = lib.mkOption {
            type = t.nullOr (t.enum [ "isolated" "fork" ]);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          idleHours = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          maxAgeHours = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          spawnSessions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        tokenFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      channelAccessToken = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      channelSecret = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      secretFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      threadBindings = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        defaultSpawnContext = lib.mkOption {
          type = t.nullOr (t.enum [ "isolated" "fork" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        idleHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        maxAgeHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        spawnSessions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      tokenFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    matrix = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accessToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.anything));
        default = null;
      };
      ackReaction = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      ackReactionScope = lib.mkOption {
        type = t.nullOr (t.enum [ "group-mentions" "group-all" "direct" "all" "none" "off" ]);
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        channelInfo = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        memberInfo = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        messages = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        pins = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        profile = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        verification = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowBots = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
        default = null;
      };
      allowlistOnly = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      autoJoin = lib.mkOption {
        type = t.nullOr (t.enum [ "always" "allowlist" "off" ]);
        default = null;
      };
      autoJoinAllowlist = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      avatarUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      botLoopProtection = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        cooldownSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxEventsPerWindow = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        windowSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      deviceId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      deviceName = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dm = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        policy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        sessionScope = lib.mkOption {
          type = t.nullOr (t.enum [ "per-user" "per-room" ]);
          default = null;
        };
        threadReplies = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "inbound" "always" ]);
          default = null;
        };
      }; });
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      encryption = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      execApprovals = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        approvers = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        sessionFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        target = lib.mkOption {
          type = t.nullOr (t.enum [ "dm" "channel" "both" ]);
          default = null;
        };
      }; });
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        account = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        allowBots = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
          default = null;
        };
        autoReply = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        users = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
      }; }));
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      homeserver = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      initialSyncLimit = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        denyIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      network = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        dangerouslyAllowPrivateNetwork = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      password = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      proxy = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      reactionNotifications = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "own" ]);
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      rooms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        account = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        allowBots = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
          default = null;
        };
        autoReply = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        users = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
      }; }));
        default = null;
      };
      startupVerification = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "if-unverified" ]);
        default = null;
      };
      startupVerificationCooldownHours = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "partial" "quiet" "progress" "off" ]);
          default = null;
        };
        preview = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        progress = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          label = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
            default = null;
          };
          labels = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          maxLineChars = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxLines = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      threadBindings = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        defaultSpawnContext = lib.mkOption {
          type = t.nullOr (t.enum [ "isolated" "fork" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        idleHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        maxAgeHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        spawnSessions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      threadReplies = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "inbound" "always" ]);
        default = null;
      };
      userId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    mattermost = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          messages = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        botToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        chatmode = lib.mkOption {
          type = t.nullOr (t.enum [ "oncall" "onmessage" "onchar" ]);
          default = null;
        };
        commands = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          callbackPath = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          callbackUrl = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          native = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          nativeSkills = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dangerouslyAllowNameMatching = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dmChannelRetry = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          initialDelayMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxDelayMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxRetries = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; }));
          default = null;
        };
        implicitMentions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          quotedBot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          replyToBot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          threadParticipation = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        interactions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowedSourceIps = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          callbackBaseUrl = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        network = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          dangerouslyAllowPrivateNetwork = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        oncharPrefixes = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
          default = null;
        };
        replyToModeByChatType = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          channel = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
            default = null;
          };
          direct = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
            default = null;
          };
          group = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
            default = null;
          };
        }; });
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
            default = null;
          };
          preview = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          progress = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            label = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
              default = null;
            };
            labels = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            maxLineChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxLines = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        messages = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      baseUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      botToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      chatmode = lib.mkOption {
        type = t.nullOr (t.enum [ "oncall" "onmessage" "onchar" ]);
        default = null;
      };
      commands = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        callbackPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        callbackUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        native = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        nativeSkills = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmChannelRetry = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        initialDelayMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        maxDelayMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        maxRetries = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; }));
        default = null;
      };
      implicitMentions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        quotedBot = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        replyToBot = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        threadParticipation = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      interactions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowedSourceIps = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        callbackBaseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      network = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        dangerouslyAllowPrivateNetwork = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      oncharPrefixes = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
        default = null;
      };
      replyToModeByChatType = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        channel = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
          default = null;
        };
        direct = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
          default = null;
        };
        group = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "first" "all" "batched" ]);
          default = null;
        };
      }; });
        default = null;
      };
      requireMention = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
          default = null;
        };
        preview = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        progress = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          label = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
            default = null;
          };
          labels = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          maxLineChars = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxLines = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
    };
    msteams = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      appId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      appPassword = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      authType = lib.mkOption {
        type = t.nullOr (t.enum [ "secret" "federated" ]);
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      certificatePath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      certificateThumbprint = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      cloud = lib.mkOption {
        type = t.nullOr (t.enum [ "Public" "USGov" "USGovDoD" "China" ]);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      delegatedAuth = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        scopes = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
      }; });
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      feedbackEnabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      feedbackReflection = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      feedbackReflectionCooldownMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      graphMediaFallback = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groupWelcomeCard = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      managedIdentityClientId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaAllowHosts = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      mediaAuthAllowHosts = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      promptStarters = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      replyStyle = lib.mkOption {
        type = t.nullOr (t.enum [ "thread" "top-level" ]);
        default = null;
      };
      requireMention = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      serviceUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      sharePointSiteId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      sso = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        connectionName = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
          default = null;
        };
        preview = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          chunk = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            breakPreference = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        progress = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          commentary = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          label = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
            default = null;
          };
          labels = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          maxLineChars = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxLines = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          narration = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
      teams = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        channels = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          replyStyle = lib.mkOption {
            type = t.nullOr (t.enum [ "thread" "top-level" ]);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        replyStyle = lib.mkOption {
          type = t.nullOr (t.enum [ "thread" "top-level" ]);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      tenantId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      typingIndicator = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      useManagedIdentity = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      webhook = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        path = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        port = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      welcomeCard = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
    }; });
      default = null;
    };
    "nextcloud-talk" = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        apiPassword = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        apiPasswordFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        apiUser = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        botSecret = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        botSecretFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        network = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          dangerouslyAllowPrivateNetwork = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        rooms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
        }; }));
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        webhookHost = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookPort = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        webhookPublicUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      apiPassword = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      apiPasswordFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      apiUser = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      baseUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      botSecret = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      botSecretFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      network = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        dangerouslyAllowPrivateNetwork = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      rooms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
      }; }));
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      webhookHost = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookPort = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      webhookPublicUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    nostr = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      privateKey = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      profile = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        about = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        banner = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        displayName = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        lud16 = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        nip05 = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        picture = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        website = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      relays = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
    }; });
      default = null;
    };
    "qa-channel" = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          messages = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          search = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          threads = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        botDisplayName = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        botUserId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "allowlist" "disabled" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        pollTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        messages = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        search = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        threads = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      baseUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      botDisplayName = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      botUserId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "allowlist" "disabled" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      pollTimeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
    };
    raft = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        profile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      profile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    reef = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      email = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      friends = lib.mkOption {
        type = t.nullOr (t.anything);
        default = null;
      };
      guard = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        apiKeyEnv = lib.mkOption {
          type = t.str;
        };
        pinnedModel = lib.mkOption {
          type = t.str;
        };
        policyVersion = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.enum [ "anthropic" "openai" ];
        };
        timeoutMs = lib.mkOption {
          type = t.int;
        };
      }; });
        default = null;
      };
      handle = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      relayUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      requestPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "code-only" "friends-of-friends" "open" ]);
        default = null;
      };
      stateDir = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    signal = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      account = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      accountUuid = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        account = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        accountUuid = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        aliases = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          ingest = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        healthMonitor = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          showAlerts = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          showOk = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          useIndicator = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        ignoreAttachments = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        reactionAllowlist = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        reactionLevel = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "ack" "minimal" "extensive" ]);
          default = null;
        };
        reactionNotifications = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "own" "all" "allowlist" ]);
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        replyToModeByChatType = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          direct = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
            default = null;
          };
          group = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        sendReadReceipts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        transport = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.submodule { options = {
          cliPath = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          configPath = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          httpHost = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          httpPort = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          ignoreStories = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          kind = lib.mkOption {
            type = t.enum [ "managed-native" ];
          };
          receiveMode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "on-start" ]) (t.enum [ "manual" ]) ]);
            default = null;
          };
          startupTimeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          url = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }) (t.submodule { options = {
          kind = lib.mkOption {
            type = t.enum [ "external-native" ];
          };
          url = lib.mkOption {
            type = t.str;
          };
        }; }) (t.submodule { options = {
          kind = lib.mkOption {
            type = t.enum [ "container" ];
          };
          url = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
      }; }));
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      aliases = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.str));
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        ingest = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      ignoreAttachments = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      reactionAllowlist = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      reactionLevel = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "ack" "minimal" "extensive" ]);
        default = null;
      };
      reactionNotifications = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "own" "all" "allowlist" ]);
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
        default = null;
      };
      replyToModeByChatType = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        direct = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        group = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      sendReadReceipts = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      transport = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.submodule { options = {
        cliPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        configPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        httpHost = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        httpPort = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        ignoreStories = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        kind = lib.mkOption {
          type = t.enum [ "managed-native" ];
        };
        receiveMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "on-start" ]) (t.enum [ "manual" ]) ]);
          default = null;
        };
        startupTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        url = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }) (t.submodule { options = {
        kind = lib.mkOption {
          type = t.enum [ "external-native" ];
        };
        url = lib.mkOption {
          type = t.str;
        };
      }; }) (t.submodule { options = {
        kind = lib.mkOption {
          type = t.enum [ "container" ];
        };
        url = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
    }; });
      default = null;
    };
    slack = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        ackReaction = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          channelInfo = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          emojiList = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          memberInfo = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          messages = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          permissions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          pins = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          search = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        allowBots = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        appToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        botToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        channels = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowBots = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
            default = null;
          };
          botLoopProtection = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            cooldownSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            maxEventsPerWindow = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            windowSeconds = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          ignoreOtherMentions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          presenceEvents = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            mode = lib.mkOption {
              type = t.nullOr (t.enum [ "off" "auto" "on" ]);
              default = null;
            };
          }; });
            default = null;
          };
          replyToMode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
          users = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
        }; }));
          default = null;
        };
        commands = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          native = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          nativeSkills = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        dangerouslyAllowNameMatching = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        dm = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          groupChannels = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          groupEnabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        execApprovals = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          agentFilter = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          approvers = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          sessionFilter = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          target = lib.mkOption {
            type = t.nullOr (t.enum [ "dm" "channel" "both" ]);
            default = null;
          };
        }; });
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        healthMonitor = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          showAlerts = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          showOk = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          useIndicator = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        implicitMentions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          quotedBot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          replyToBot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          threadParticipation = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          denyIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "socket" "http" "relay" ]);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        postAs = lib.mkOption {
          type = t.nullOr (t.enum [ "bot" "user" ]);
          default = null;
        };
        presenceEvents = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "auto" "on" ]);
            default = null;
          };
        }; });
          default = null;
        };
        reactionAllowlist = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        reactionNotifications = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "own" "all" "allowlist" ]);
          default = null;
        };
        relay = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          authToken = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "store" "file" "exec" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          gatewayId = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          url = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        replyToModeByChatType = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          channel = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
            default = null;
          };
          direct = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
            default = null;
          };
          group = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        signingSecret = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        slashCommand = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          ephemeral = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          name = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          sessionPrefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
            default = null;
          };
          nativeTransport = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          preview = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            chunk = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              breakPreference = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          progress = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            commentary = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            label = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
              default = null;
            };
            labels = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            maxLineChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxLines = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            narration = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            nativeTaskCards = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        thread = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          historyScope = lib.mkOption {
            type = t.nullOr (t.enum [ "thread" "channel" ]);
            default = null;
          };
          inheritParent = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          initialHistoryLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        typingReaction = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        unfurlLinks = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        unfurlMedia = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        userToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        userTokenReadOnly = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      ackReaction = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        channelInfo = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        emojiList = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        memberInfo = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        messages = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        permissions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        pins = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        search = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowBots = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      appToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      botLoopProtection = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        cooldownSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxEventsPerWindow = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        windowSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      botToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      channels = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowBots = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "mentions" ]) ]);
          default = null;
        };
        botLoopProtection = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cooldownSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          maxEventsPerWindow = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          windowSeconds = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        ignoreOtherMentions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        presenceEvents = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "auto" "on" ]);
            default = null;
          };
        }; });
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
        users = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
      }; }));
        default = null;
      };
      commands = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        native = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        nativeSkills = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dm = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupChannels = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupEnabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      execApprovals = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        approvers = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        sessionFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        target = lib.mkOption {
          type = t.nullOr (t.enum [ "dm" "channel" "both" ]);
          default = null;
        };
      }; });
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      implicitMentions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        quotedBot = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        replyToBot = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        threadParticipation = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        denyIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "socket" "http" "relay" ]);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      postAs = lib.mkOption {
        type = t.nullOr (t.enum [ "bot" "user" ]);
        default = null;
      };
      presenceEvents = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "auto" "on" ]);
          default = null;
        };
      }; });
        default = null;
      };
      reactionAllowlist = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      reactionNotifications = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "own" "all" "allowlist" ]);
        default = null;
      };
      relay = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        authToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        gatewayId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        url = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
        default = null;
      };
      replyToModeByChatType = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        channel = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        direct = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        group = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      requireMention = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      signingSecret = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      slashCommand = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        ephemeral = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        sessionPrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
          default = null;
        };
        nativeTransport = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        preview = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          chunk = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            breakPreference = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        progress = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          commentary = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          label = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
            default = null;
          };
          labels = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          maxLineChars = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxLines = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          narration = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          nativeTaskCards = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      thread = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        historyScope = lib.mkOption {
          type = t.nullOr (t.enum [ "thread" "channel" ]);
          default = null;
        };
        inheritParent = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        initialHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; });
        default = null;
      };
      typingReaction = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      unfurlLinks = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      unfurlMedia = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      userToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      userTokenReadOnly = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    sms = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accountSid = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        accountSid = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        authToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dangerouslyDisableSignatureValidation = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        fromNumber = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        messagingServiceSid = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        publicWebhookUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      authToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      dangerouslyDisableSignatureValidation = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      fromNumber = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      messagingServiceSid = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      publicWebhookUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    "synology-chat" = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      dangerouslyAllowInheritedWebhookPath = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      webhookUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    telegram = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        ackReaction = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        actions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          createForumTopic = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          deleteMessage = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          editForumTopic = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          editMessage = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          poll = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          reactions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          sendMessage = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          sticker = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        apiRoot = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        autoTopicLabel = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          prompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }) ]);
          default = null;
        };
        botToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.listOf (t.str)) (t.submodule { options = {
          inlineButtons = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "dm" "group" "all" "allowlist" ]);
            default = null;
          };
        }; }) ]);
          default = null;
        };
        commands = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          native = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          nativeSkills = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        customCommands = lib.mkOption {
          type = t.nullOr (t.listOf (t.submodule { options = {
          command = lib.mkOption {
            type = t.str;
          };
          description = lib.mkOption {
            type = t.str;
          };
        }; }));
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
          default = null;
        };
        direct = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          autoTopicLabel = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            prompt = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; }) ]);
            default = null;
          };
          dmPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          errorPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "always" "once" "silent" ]);
            default = null;
          };
          requireTopic = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
          topics = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            agentId = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            allowFrom = lib.mkOption {
              type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
              default = null;
            };
            disableAudioPreflight = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            errorPolicy = lib.mkOption {
              type = t.nullOr (t.enum [ "always" "once" "silent" ]);
              default = null;
            };
            groupPolicy = lib.mkOption {
              type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
              default = null;
            };
            ingest = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            requireMention = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            skills = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            systemPrompt = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        errorPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "always" "once" "silent" ]);
          default = null;
        };
        execApprovals = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          agentFilter = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          approvers = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
            default = null;
          };
          sessionFilter = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          target = lib.mkOption {
            type = t.nullOr (t.enum [ "dm" "channel" "both" ]);
            default = null;
          };
        }; });
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          disableAudioPreflight = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          errorPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "always" "once" "silent" ]);
            default = null;
          };
          groupPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
            default = null;
          };
          ingest = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
          topics = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            agentId = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            allowFrom = lib.mkOption {
              type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
              default = null;
            };
            disableAudioPreflight = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            errorPolicy = lib.mkOption {
              type = t.nullOr (t.enum [ "always" "once" "silent" ]);
              default = null;
            };
            groupPolicy = lib.mkOption {
              type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
              default = null;
            };
            ingest = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            requireMention = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            skills = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            systemPrompt = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        healthMonitor = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          showAlerts = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          showOk = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          useIndicator = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        linkPreview = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          denyIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        network = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          autoSelectFamily = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          dangerouslyAllowPrivateNetwork = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Dangerous opt-in for trusted Telegram fake-IP or transparent-proxy environments where api.telegram.org resolves to private/internal/special-use addresses during media downloads.";
          };
          dnsResultOrder = lib.mkOption {
            type = t.nullOr (t.enum [ "ipv4first" "verbatim" ]);
            default = null;
          };
        }; });
          default = null;
        };
        proxy = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        reactionLevel = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "ack" "minimal" "extensive" ]);
          default = null;
        };
        reactionNotifications = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "own" "all" ]);
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        richMessages = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        silentErrorReplies = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
            default = null;
          };
          preview = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            chunk = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              breakPreference = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          progress = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            commandText = lib.mkOption {
              type = t.nullOr (t.enum [ "raw" "status" ]);
              default = null;
            };
            commentary = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            label = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
              default = null;
            };
            labels = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            maxLineChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxLines = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            narration = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            toolProgress = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        threadBindings = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          defaultSpawnContext = lib.mkOption {
            type = t.nullOr (t.enum [ "isolated" "fork" ]);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          idleHours = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          maxAgeHours = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          spawnSessions = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        tokenFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        trustedLocalFileRoots = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Trusted local filesystem roots for self-hosted Telegram Bot API absolute file_path values. Only absolute paths under these roots are read directly; all other absolute paths are rejected.";
        };
        webhookCertPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Path to the self-signed certificate (PEM) to upload to Telegram during webhook registration. Required for self-signed certs (direct IP or no domain).";
        };
        webhookHost = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Local bind host for the webhook listener. Defaults to 127.0.0.1; keep loopback unless you intentionally expose direct ingress.";
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Local webhook route path served by the gateway listener. Defaults to /telegram-webhook.";
        };
        webhookPort = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Local bind port for the webhook listener. Defaults to 8787; set to 0 to let the OS assign an ephemeral port.";
        };
        webhookSecret = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
          description = "Secret token sent to Telegram during webhook registration and verified on inbound webhook requests. Telegram returns this value for verification; this is not the gateway auth token and not the bot token.";
        };
        webhookUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Public HTTPS webhook URL registered with Telegram for inbound updates. This must be internet-reachable and requires channels.telegram.webhookSecret.";
        };
      }; }));
        default = null;
      };
      ackReaction = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        createForumTopic = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        deleteMessage = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        editForumTopic = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        editMessage = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        poll = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        sendMessage = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        sticker = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      apiRoot = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      autoTopicLabel = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        prompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }) ]);
        default = null;
      };
      botToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.listOf (t.str)) (t.submodule { options = {
        inlineButtons = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "dm" "group" "all" "allowlist" ]);
          default = null;
        };
      }; }) ]);
        default = null;
      };
      commands = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        native = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        nativeSkills = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      customCommands = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        command = lib.mkOption {
          type = t.str;
        };
        description = lib.mkOption {
          type = t.str;
        };
      }; }));
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
        default = null;
      };
      direct = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        autoTopicLabel = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          prompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }) ]);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        errorPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "always" "once" "silent" ]);
          default = null;
        };
        requireTopic = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
        topics = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          agentId = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          disableAudioPreflight = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          errorPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "always" "once" "silent" ]);
            default = null;
          };
          groupPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
            default = null;
          };
          ingest = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      errorPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "always" "once" "silent" ]);
        default = null;
      };
      execApprovals = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agentFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        approvers = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
          default = null;
        };
        sessionFilter = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        target = lib.mkOption {
          type = t.nullOr (t.enum [ "dm" "channel" "both" ]);
          default = null;
        };
      }; });
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        disableAudioPreflight = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        errorPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "always" "once" "silent" ]);
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        ingest = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        skills = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
        topics = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          agentId = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          allowFrom = lib.mkOption {
            type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
            default = null;
          };
          disableAudioPreflight = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          errorPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "always" "once" "silent" ]);
            default = null;
          };
          groupPolicy = lib.mkOption {
            type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
            default = null;
          };
          ingest = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          skills = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      linkPreview = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        denyIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      network = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        autoSelectFamily = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dangerouslyAllowPrivateNetwork = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Dangerous opt-in for trusted Telegram fake-IP or transparent-proxy environments where api.telegram.org resolves to private/internal/special-use addresses during media downloads.";
        };
        dnsResultOrder = lib.mkOption {
          type = t.nullOr (t.enum [ "ipv4first" "verbatim" ]);
          default = null;
        };
      }; });
        default = null;
      };
      proxy = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      reactionLevel = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "ack" "minimal" "extensive" ]);
        default = null;
      };
      reactionNotifications = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "own" "all" ]);
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      richMessages = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      silentErrorReplies = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "partial" "block" "progress" ]);
          default = null;
        };
        preview = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          chunk = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            breakPreference = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "paragraph" ]) (t.enum [ "newline" ]) (t.enum [ "sentence" ]) ]);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        progress = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          commandText = lib.mkOption {
            type = t.nullOr (t.enum [ "raw" "status" ]);
            default = null;
          };
          commentary = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          label = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
            default = null;
          };
          labels = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          maxLineChars = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          maxLines = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          narration = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          toolProgress = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      threadBindings = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        defaultSpawnContext = lib.mkOption {
          type = t.nullOr (t.enum [ "isolated" "fork" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        idleHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        maxAgeHours = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        spawnSessions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      tokenFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      trustedLocalFileRoots = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Trusted local filesystem roots for self-hosted Telegram Bot API absolute file_path values. Only absolute paths under these roots are read directly; all other absolute paths are rejected.";
      };
      webhookCertPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Path to the self-signed certificate (PEM) to upload to Telegram during webhook registration. Required for self-signed certs (direct IP or no domain).";
      };
      webhookHost = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Local bind host for the webhook listener. Defaults to 127.0.0.1; keep loopback unless you intentionally expose direct ingress.";
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Local webhook route path served by the gateway listener. Defaults to /telegram-webhook.";
      };
      webhookPort = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Local bind port for the webhook listener. Defaults to 8787; set to 0 to let the OS assign an ephemeral port.";
      };
      webhookSecret = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Secret token sent to Telegram during webhook registration and verified on inbound webhook requests. Telegram returns this value for verification; this is not the gateway auth token and not the bot token.";
      };
      webhookUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Public HTTPS webhook URL registered with Telegram for inbound updates. This must be internet-reachable and requires channels.telegram.webhookSecret.";
      };
    }; });
      default = null;
    };
    tlon = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        autoAcceptDmInvites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        autoAcceptGroupInvites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        autoDiscoverChannels = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        code = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dmAllowlist = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupChannels = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        groupInviteAllowlist = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        implicitMentions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          quotedBot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          replyToBot = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          threadParticipation = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        network = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          dangerouslyAllowPrivateNetwork = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        ownerShip = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        ship = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        showModelSignature = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        url = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      authorization = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        channelRules = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allowedShips = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.enum [ "restricted" "open" ]);
            default = null;
          };
        }; }));
          default = null;
        };
      }; });
        default = null;
      };
      autoAcceptDmInvites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      autoAcceptGroupInvites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      autoDiscoverChannels = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      code = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAuthorizedShips = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      dmAllowlist = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupChannels = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      groupInviteAllowlist = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      implicitMentions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        quotedBot = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        replyToBot = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        threadParticipation = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      network = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        dangerouslyAllowPrivateNetwork = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      ownerShip = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      ship = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      showModelSignature = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      url = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    twitch = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.submodule { options = {
      accessToken = lib.mkOption {
        type = t.str;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      allowedRoles = lib.mkOption {
        type = t.nullOr (t.listOf (t.enum [ "moderator" "owner" "vip" "subscriber" "all" ]));
        default = null;
      };
      channel = lib.mkOption {
        type = t.str;
      };
      clientId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      clientSecret = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      expiresIn = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      obtainmentTimestamp = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      refreshToken = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      requireMention = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      username = lib.mkOption {
        type = t.str;
      };
    }; }) (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.attrsOf (t.submodule { options = {
        accessToken = lib.mkOption {
          type = t.str;
        };
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        allowedRoles = lib.mkOption {
          type = t.nullOr (t.listOf (t.enum [ "moderator" "owner" "vip" "subscriber" "all" ]));
          default = null;
        };
        channel = lib.mkOption {
          type = t.str;
        };
        clientId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        clientSecret = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        expiresIn = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        obtainmentTimestamp = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        refreshToken = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        username = lib.mkOption {
          type = t.str;
        };
      }; });
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; }) ]);
      default = null;
    };
    whatsapp = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        authDir = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        contextVisibility = lib.mkOption {
          type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
          default = null;
        };
        defaultTo = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        direct = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }));
          default = null;
        };
        dmHistoryLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        dms = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          historyLimit = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; }));
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          systemPrompt = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          toolsBySender = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; }));
            default = null;
          };
        }; }));
          default = null;
        };
        healthMonitor = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        heartbeatVisibility = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          showAlerts = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          showOk = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          useIndicator = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mentionPatterns = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          denyIn = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        pluginHooks = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          messageReceived = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        reactionLevel = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "ack" "minimal" "extensive" ]);
          default = null;
        };
        replyToMode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        selfChatMode = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        sendReadReceipts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        streaming = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          block = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            coalesce = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              idleMs = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            enabled = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
          }; });
            default = null;
          };
          chunkMode = lib.mkOption {
            type = t.nullOr (t.enum [ "length" "newline" ]);
            default = null;
          };
        }; });
          default = null;
        };
        textChunkLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        calls = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        polls = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        reactions = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        sendMessage = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      capabilities = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      contextVisibility = lib.mkOption {
        type = t.nullOr (t.enum [ "all" "allowlist" "allowlist_quote" ]);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      defaultTo = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      direct = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      dmHistoryLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      dms = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        systemPrompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        toolsBySender = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; }));
          default = null;
        };
      }; }));
        default = null;
      };
      healthMonitor = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      heartbeatVisibility = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        showAlerts = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        showOk = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        useIndicator = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        denyIn = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
          default = null;
        };
      }; });
        default = null;
      };
      pluginHooks = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        messageReceived = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
      reactionLevel = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "ack" "minimal" "extensive" ]);
        default = null;
      };
      replyToMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "first" ]) (t.enum [ "all" ]) (t.enum [ "batched" ]) ]);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      selfChatMode = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      sendReadReceipts = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      streaming = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        block = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          coalesce = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            idleMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            minChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
          }; });
            default = null;
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
        }; });
          default = null;
        };
        chunkMode = lib.mkOption {
          type = t.nullOr (t.enum [ "length" "newline" ]);
          default = null;
        };
      }; });
        default = null;
      };
      textChunkLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
    };
    zalo = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        botToken = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        mediaMaxMb = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        proxy = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        tokenFile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        webhookSecret = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "store" "file" "exec" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
        webhookUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      botToken = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      mediaMaxMb = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      proxy = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      tokenFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      webhookSecret = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "store" "file" "exec" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      webhookUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    zalouser = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accounts = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        configWrites = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dangerouslyAllowNameMatching = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        dmPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        groupAllowFrom = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
          default = null;
        };
        groupPolicy = lib.mkOption {
          type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
          default = null;
        };
        groups = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requireMention = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          tools = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            alsoAllow = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            deny = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
        }; }));
          default = null;
        };
        historyLimit = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        markdown = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tables = lib.mkOption {
            type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
            default = null;
          };
        }; });
          default = null;
        };
        messagePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        name = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        profile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        responsePrefix = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
      allowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      configWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      dangerouslyAllowNameMatching = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      defaultAccount = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      dmPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "pairing" "allowlist" "open" "disabled" ]);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      groupAllowFrom = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
        default = null;
      };
      groupPolicy = lib.mkOption {
        type = t.nullOr (t.enum [ "open" "disabled" "allowlist" ]);
        default = null;
      };
      groups = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        requireMention = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        tools = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          alsoAllow = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          deny = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
      }; }));
        default = null;
      };
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      markdown = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        tables = lib.mkOption {
          type = t.nullOr (t.enum [ "off" "bullets" "code" "block" ]);
          default = null;
        };
      }; });
        default = null;
      };
      messagePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      profile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      responsePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
  }; });
    default = null;
    description = "Channel provider configurations plus shared defaults that control access policies, heartbeat visibility, and per-surface behavior. Keep defaults centralized and override per provider only where required.";
  };

  cloudWorkers = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    desktop = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables the experimental worker.desktop.observe surface and Control UI Desktop panel for desktop-capable cloud worker environments.";
    };
    profiles = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      install = lib.mkOption {
        type = t.nullOr (t.enum [ "bundle" "npm" ]);
        default = null;
        description = "Worker installation method: \"bundle\" (default) transfers the gateway's content-hashed installed build and supports released, development, and unreleased versions; \"npm\" installs the exact gateway version and is available only when that version is released.";
      };
      provider = lib.mkOption {
        type = t.str;
        description = "Worker provider id registered by a plugin. The configured plugin must expose this id before the gateway can provision environments from the profile.";
      };
      settings = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.anything));
        default = null;
        description = "Provider-owned settings validated by the selected plugin. Use SecretRef objects for secret-bearing values; opaque settings do not gain automatic secret resolution.";
      };
    }; }));
      default = null;
      description = "Named cloud worker profiles. Each profile selects a worker provider registered by a plugin and carries provider-owned settings.";
    };
  }; });
    default = null;
    description = "Opt-in cloud worker profiles for disposable remote environments. When this section is omitted or has no profiles, cloud worker creation remains unavailable and existing gateway/node status behavior is unchanged.";
  };

  commands = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    allowFrom = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.listOf (t.oneOf [ (t.str) (t.number) ])));
      default = null;
      description = "Defines elevated command allow rules by channel and sender for owner-level command surfaces. Use narrow provider-specific identities so privileged commands are not exposed to broad chat audiences.";
    };
    bash = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allow bash chat command (`!`; `/bash` alias) to run host shell commands (default: false; requires tools.elevated).";
    };
    bashForegroundMs = lib.mkOption {
      type = t.nullOr (t.int);
      default = null;
      description = "How long bash waits before backgrounding (default: 2000; 0 backgrounds immediately).";
    };
    config = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allow /config chat command to read/write config on disk (default: false).";
    };
    debug = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allow /debug chat command for runtime-only overrides (default: false).";
    };
    mcp = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allow /mcp chat command to manage OpenClaw MCP server config under mcp.servers (default: false).";
    };
    native = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
      default = null;
      description = "Registers native slash/menu commands with channels that support command registration (Discord, Slack, Telegram). Keep enabled for discoverability unless you intentionally run text-only command workflows.";
    };
    nativeSkills = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
      default = null;
      description = "Registers native skill commands so users can invoke skills directly from provider command menus where supported. Keep aligned with your skill policy so exposed commands match what operators expect.";
    };
    ownerAllowFrom = lib.mkOption {
      type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.number) ]));
      default = null;
      description = "Explicit owner allowlist for owner-scoped commands. Use channel-native IDs (optionally prefixed like \"whatsapp:+15551234567\"). '*' is ignored.";
    };
    plugins = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allow /plugins chat command to list discovered plugins and toggle plugin enablement in config (default: false).";
    };
    restart = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allow /restart and external SIGUSR1 restart requests (default: true).";
    };
    text = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables text-command parsing in chat input in addition to native command surfaces where available. Keep this enabled for compatibility across channels that do not support native command registration.";
    };
  }; });
    default = null;
    description = "Controls chat command surfaces, owner gating, and elevated command access behavior across providers. Keep defaults unless you need stricter operator controls or broader command availability.";
  };

  cron = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables automation execution for stored schedules managed by the gateway. Keep enabled for normal reminder/automation flows, and disable only to pause all automation execution without deleting jobs.";
    };
    failureAlert = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      accountId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      after = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      channel = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      cooldownMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      includeSkipped = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "announce" "webhook" ]);
        default = null;
      };
      to = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    sessionRetention = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
      default = null;
      description = "Controls how long completed automation run sessions are kept before pruning (`24h`, `7d`, `1h30m`, or `false` to disable pruning; a zero duration such as `0h` also disables; default: `24h`). Use shorter retention to reduce storage growth on high-frequency schedules.";
    };
    triggers = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
    }; });
      default = null;
    };
    webhookSsrfPolicy = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowIpv6UniqueLocalRange = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows automation webhooks to IPv6 Unique Local Addresses (fc00::/7). Use only with trusted fake-IP proxy environments.";
      };
      allowRfc2544BenchmarkRange = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows automation webhooks to RFC 2544 benchmark-range IPs (198.18.0.0/15). Use only with trusted fake-IP proxy environments.";
      };
      allowedHostnames = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Exact hostnames or IP literals allowed for automation webhook delivery, including otherwise blocked targets. Keep the list minimal.";
      };
      dangerouslyAllowPrivateNetwork = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows automation webhooks to private and internal network targets. Keep disabled unless every configured webhook destination is trusted.";
      };
    }; });
      default = null;
      description = "SSRF policy applied to every outbound automation webhook. Private, loopback, link-local, and internal targets stay blocked unless this policy explicitly allows them. Keep unset for strict delivery.";
    };
    webhookToken = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
      source = lib.mkOption {
        type = t.enum [ "env" "file" "exec" "store" ];
      };
      id = lib.mkOption {
        type = t.str;
      };
      provider = lib.mkOption {
        type = t.str;
      };
    }; }) ]);
      default = null;
      description = "Bearer token attached to automation webhook POST deliveries when webhook mode is used. Prefer secret/env substitution and rotate this token regularly if shared webhook endpoints are internet-reachable.";
    };
  }; });
    default = null;
    description = "Global scheduler settings for stored automations, run concurrency, delivery fallback, and run-session retention. Keep defaults unless you are scaling automation volume or integrating external webhook receivers.";
  };

  desktop = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    host = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.bool;
        description = "Enables the experimental gateway-host desktop source. Restart the gateway after changing this setting.";
      };
      managed = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Runs and supervises a loopback-only headless TigerVNC/XFCE desktop on Linux. An explicit port or existing default-port VNC server still takes precedence.";
      };
      passwordFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Absolute path to the VNC password file. Omit on macOS to use account/ARD authentication after that support lands.";
      };
      port = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Loopback RFB port of an already-running VNC server on the gateway host (default: 5900).";
      };
    }; });
      default = null;
      description = "Experimental gateway-host desktop observation backed by an existing or managed loopback VNC server.";
    };
  }; });
    default = null;
  };

  diagnostics = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    cacheTrace = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Log cache trace snapshots for embedded agent runs (default: false).";
      };
    }; });
      default = null;
      description = "Cache-trace logging settings for observing cache decisions and payload context in embedded runs. Enable this temporarily for debugging and disable afterward to reduce sensitive log footprint.";
    };
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Master toggle for diagnostics instrumentation output in logs and telemetry wiring paths. Defaults to enabled; set false only in tightly constrained environments.";
    };
    flags = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Enable targeted diagnostics logs by flag (e.g. [\"telegram.http\"]). Supports wildcards like \"telegram.*\" or \"*\".";
    };
    otel = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      captureContent = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Opt-in OTEL span content capture. Defaults to off; true captures non-system message and tool content.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables OpenTelemetry export pipeline for traces, metrics, and logs based on configured endpoint/protocol settings. Keep disabled unless your collector endpoint and auth are fully configured.";
      };
      endpoint = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Collector endpoint URL used for OpenTelemetry export transport, including scheme and port. Use a reachable, trusted collector endpoint and monitor ingestion errors after rollout.";
      };
      flushIntervalMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Interval in milliseconds for periodic telemetry flush from buffers to the collector. Increase to reduce export chatter, or lower for faster visibility during active incident response.";
      };
      headers = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.str));
        default = null;
        description = "Additional HTTP request headers sent with OpenTelemetry export requests, often used for tenant auth or routing. Keep secrets in env-backed values and avoid unnecessary header sprawl.";
      };
      logs = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable log signal export through OpenTelemetry in addition to local logging sinks. Use this when centralized log correlation is required across services and agents.";
      };
      logsEndpoint = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Signal-specific OTLP/HTTP logs endpoint. When set, this overrides diagnostics.otel.endpoint and OTEL_EXPORTER_OTLP_ENDPOINT for log export only.";
      };
      logsExporter = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "otlp" ]) (t.enum [ "stdout" ]) (t.enum [ "both" ]) ]);
        default = null;
        description = "Log export sink for diagnostics.otel.logs. Use \"otlp\" for the configured OTLP logs endpoint, \"stdout\" for one JSON record per stdout line in container log pipelines, and \"both\" when both sinks are required.";
      };
      metricNamePrefix = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Replaces the default \"openclaw.\" prefix on OpenClaw-owned metric names. Use an empty string to remove the prefix, or up to 128 ASCII letters, digits, underscores, dots, hyphens, and slashes starting with a letter. Include any separator you need, for example \"acme.\"; standard gen_ai.* metric names are unchanged. Changing this value requires updating dashboards and alerts that query the old names.";
      };
      metrics = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable metrics signal export to the configured OpenTelemetry collector endpoint. Keep enabled for runtime health dashboards, and disable only if metric volume must be minimized.";
      };
      metricsEndpoint = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Signal-specific OTLP/HTTP metrics endpoint. When set, this overrides diagnostics.otel.endpoint and OTEL_EXPORTER_OTLP_ENDPOINT for metrics export only.";
      };
      protocol = lib.mkOption {
        type = t.nullOr (t.enum [ "http/protobuf" ]);
        default = null;
        description = "OTel transport protocol for telemetry export. Only \"http/protobuf\" is accepted; run \"openclaw doctor --fix\" to repair a persisted legacy \"grpc\" value or get source-specific manual-edit guidance.";
      };
      sampleRate = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
        description = "Trace sampling rate (0-1) controlling how much trace traffic is exported to observability backends. Lower rates reduce overhead/cost, while higher rates improve debugging fidelity.";
      };
      serviceName = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Service name reported in telemetry resource attributes to identify this gateway instance in observability backends. Use stable names so dashboards and alerts remain consistent over deployments.";
      };
      traces = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable trace signal export to the configured OpenTelemetry collector endpoint. Keep enabled when latency/debug tracing is needed, and disable if you only want metrics/logs.";
      };
      tracesEndpoint = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Signal-specific OTLP/HTTP trace endpoint. When set, this overrides diagnostics.otel.endpoint and OTEL_EXPORTER_OTLP_ENDPOINT for trace export only.";
      };
    }; });
      default = null;
      description = "OpenTelemetry export settings for traces, metrics, and logs emitted by gateway components. Use this when integrating with centralized observability backends and distributed tracing pipelines.";
    };
  }; });
    default = null;
    description = "Diagnostics controls for targeted tracing, telemetry export, and cache inspection during debugging. Keep baseline diagnostics minimal in production and enable deeper signals only when investigating issues.";
  };

  discovery = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    mdns = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "minimal" "full" ]);
        default = null;
        description = "mDNS broadcast mode (\"minimal\" default, \"full\" includes cliPath/sshPort, \"off\" disables mDNS).";
      };
    }; });
      default = null;
      description = "mDNS discovery configuration group for local network advertisement and discovery behavior tuning. Keep minimal mode for routine LAN discovery unless extra metadata is required.";
    };
    wideArea = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      domain = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional unicast DNS-SD domain for wide-area discovery, such as openclaw.internal. Use this when you intentionally publish gateway discovery beyond local mDNS scopes.";
      };
    }; });
      default = null;
      description = "Wide-area discovery configuration group for exposing discovery signals beyond local-link scopes. Enable only in deployments that intentionally aggregate gateway presence across sites.";
    };
  }; });
    default = null;
    description = "Service discovery settings for local mDNS advertisement and optional wide-area presence signaling. Keep discovery scoped to expected networks to avoid leaking service metadata.";
  };

  env = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    shellEnv = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables loading environment variables from the user shell profile during startup initialization. Keep enabled for developer machines, or disable in locked-down service environments with explicit env management.";
      };
      timeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum time in milliseconds allowed for shell environment resolution before fallback behavior applies. Use tighter timeouts for faster startup, or increase when shell initialization is heavy.";
      };
    }; });
      default = null;
      description = "Shell environment import controls for loading variables from your login shell during startup. Keep this enabled when you depend on profile-defined secrets or PATH customizations.";
    };
    vars = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.str));
      default = null;
      description = "Explicit key/value environment variable overrides merged into runtime process environment for OpenClaw. Use this for deterministic env configuration instead of relying only on shell profile side effects.";
    };
  }; });
    default = null;
    description = "Environment import and override settings used to supply runtime variables to the gateway process. Use this section to control shell-env loading and explicit variable injection behavior.";
  };

  gateway = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    allowRealIpFallback = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables x-real-ip fallback when x-forwarded-for is missing in proxy scenarios. Keep disabled unless your ingress stack requires this compatibility behavior.";
    };
    auth = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowTailscale = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows trusted Tailscale identity paths to satisfy gateway auth checks when configured. Use this only when your tailnet identity posture is strong and operator workflows depend on it.";
      };
      identityScopes = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.listOf (t.enum [ "operator.admin" "operator.read" "operator.write" "operator.approvals" "operator.questions" "operator.pairing" "operator.talk" "operator.talk.secrets" ])));
        default = null;
        description = "Maps verified trusted-proxy or Tailscale identities to connection-only operator scope grants. Email keys match case-insensitively; grants augment device scopes before the connection scope cap is applied.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "token" ]) (t.enum [ "password" ]) (t.enum [ "trusted-proxy" ]) ]);
        default = null;
        description = "Gateway auth mode: \"none\", \"token\", \"password\", or \"trusted-proxy\" depending on your edge architecture. Use token/password for direct exposure, and trusted-proxy only behind hardened identity-aware proxies.";
      };
      password = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Required for Tailscale funnel.";
      };
      rateLimit = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        exemptLoopback = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        lockoutMs = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        maxAttempts = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        windowMs = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
      }; });
        default = null;
        description = "Login/auth attempt throttling controls to reduce credential brute-force risk at the gateway boundary. Keep enabled in exposed environments and tune thresholds to your traffic baseline.";
      };
      token = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Required by default for gateway access (unless using Tailscale Serve identity); required for non-loopback binds.";
      };
      trustedProxy = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowLoopback = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        allowUsers = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        deviceAutoApprove = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Automatically approves new browser device identities after the reverse proxy authenticates an allowed user. Default: false. Enable only when the proxy identity boundary is strong enough to replace manual device pairing.";
          };
          scopes = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
            description = "Maximum scopes granted to auto-approved browser devices. Requested scopes are capped to this list; requests without scopes receive this list. Explicitly listing operator.admin lets every proxy-authenticated user auto-approve full admin and makes scope-less requests receive full admin automatically; it also triggers a critical security audit finding and Gateway startup warning.";
          };
        }; });
          default = null;
          description = "Optional policy for automatically approving new Control UI and WebChat device identities after trusted-proxy authentication. Existing-device scope upgrades always remain manual.";
        };
        requiredHeaders = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        userHeader = lib.mkOption {
          type = t.str;
        };
      }; });
        default = null;
        description = "Trusted-proxy auth header mapping for upstream identity providers that inject user claims. Use only with known proxy CIDRs and strict header allowlists to prevent spoofed identity headers.";
      };
    }; });
      default = null;
      description = "Authentication policy for gateway HTTP/WebSocket access including mode, credentials, trusted-proxy behavior, and rate limiting. Keep auth enabled for every non-loopback deployment.";
    };
    bind = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "auto" ]) (t.enum [ "lan" ]) (t.enum [ "loopback" ]) (t.enum [ "custom" ]) (t.enum [ "tailnet" ]) ]);
      default = null;
      description = "Network bind profile: \"auto\", \"lan\", \"loopback\", \"custom\", or \"tailnet\" to control interface exposure. Keep \"loopback\" for local-only operation; \"auto\" can expose all interfaces.";
    };
    cliAgents = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Shows catalog-backed CLI agents in the Control UI new-session model picker when true (default: false). Only catalogs that advertise session creation are listed, and the picker stays hidden when the Gateway does not advertise session catalog support.";
      };
    }; });
      default = null;
      description = "Experimental Control UI discovery for external CLI session engines exposed by the Gateway session catalog. Keep disabled unless operators should be able to start those engines from the new-session model picker.";
    };
    controlUi = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowExternalEmbedUrls = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "DANGEROUS toggle that allows hosted embeds to load absolute external http(s) URLs. Keep this off unless your Control UI intentionally embeds trusted third-party pages; hosted /__openclaw__/canvas and /__openclaw__/a2ui documents do not need it.";
      };
      allowedOrigins = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Allowed browser origins for Control UI/WebChat websocket connections (full origins only, e.g. https://control.example.com). Required for non-loopback Control UI deployments unless dangerous Host-header fallback is explicitly enabled. Setting [\"*\"] means allow any browser origin and should be avoided outside tightly controlled local testing.";
      };
      basePath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional URL prefix where the Control UI is served (e.g. /openclaw).";
      };
      dangerouslyAllowHostHeaderOriginFallback = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "DANGEROUS toggle that enables Host-header based origin fallback for Control UI/WebChat websocket checks. This mode is supported when your deployment intentionally relies on Host-header origin policy; explicit gateway.controlUi.allowedOrigins remains the recommended hardened default.";
      };
      dangerouslyDisableDeviceAuth = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      embedSandbox = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "strict" ]) (t.enum [ "scripts" ]) (t.enum [ "trusted" ]) ]);
        default = null;
        description = "Iframe sandbox policy for hosted Control UI embeds. \"strict\" disables scripts, \"scripts\" allows interactive embeds while keeping origin isolation (default), and \"trusted\" adds `allow-same-origin` for same-site documents that intentionally need stronger privileges.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables serving the gateway Control UI from the gateway HTTP process when true. Keep enabled for local administration, and disable when an external control surface replaces it.";
      };
      root = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional filesystem root for Control UI assets (defaults to dist/control-ui).";
      };
      sessionObserver = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Produce live session status digests for subscribed Control UI clients with each agent's utility model (default on). Set false to disable observer model calls gateway-wide; setting agents.defaults.utilityModel to an empty string disables utility-model observation for agents that do not override it.";
      };
      toolTitles = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Opt-in AI purpose titles for tool calls in Control UI chat (default off). When enabled, the chat.toolTitles method generates short titles for complex tool calls with the agent's utility model (an explicit utilityModel may route bounded tool arguments to the operator-chosen provider like every utility task; the derived default stays on the session's provider) and caches them in the per-agent state database. Setting utilityModel to an empty string disables titles too. Leave off to keep tool rendering fully deterministic with no background model calls.";
      };
    }; });
      default = null;
      description = "Control UI hosting settings including enablement, pathing, and browser-origin/auth hardening behavior. Keep UI exposure minimal and pair with strong auth controls before internet-facing deployments.";
    };
    customBindHost = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "IPv4 address used for a custom bind. Specific IPv4s also require the same Gateway port on 127.0.0.1; avoid 0.0.0.0 unless all-interface exposure is required.";
    };
    http = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      endpoints = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        chatCompletions = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Enable the OpenAI-compatible `POST /v1/chat/completions` endpoint (default: false).";
          };
          images = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allowUrl = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
              description = "Allow server-side URL fetches for `image_url` parts (default: false; data URIs remain supported). Set this to `false` to disable URL fetching entirely.";
            };
            allowedMimes = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
              description = "Allowed MIME types for `image_url` parts (case-insensitive list).";
            };
            maxBytes = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
              description = "Max bytes per fetched/decoded `image_url` image (default: 10MB).";
            };
            maxRedirects = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
              description = "Max HTTP redirects allowed when fetching `image_url` URLs (default: 3).";
            };
            timeoutMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
              description = "Timeout in milliseconds for `image_url` URL fetches (default: 10000).";
            };
            urlAllowlist = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
              description = "Optional hostname allowlist for `image_url` URL fetches; supports exact hosts and `*.example.com` wildcards. Empty or omitted lists mean no hostname allowlist restriction.";
            };
          }; });
            default = null;
            description = "Image fetch/validation controls for OpenAI-compatible `image_url` parts.";
          };
        }; });
          default = null;
        };
        responses = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          files = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allowUrl = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowedMimes = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            maxBytes = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxChars = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxRedirects = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            pdf = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              maxPages = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              maxPixels = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
              minTextChars = lib.mkOption {
                type = t.nullOr (t.int);
                default = null;
              };
            }; });
              default = null;
            };
            timeoutMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            urlAllowlist = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          images = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            allowUrl = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            allowedMimes = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
            maxBytes = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            maxRedirects = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            timeoutMs = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
            };
            urlAllowlist = lib.mkOption {
              type = t.nullOr (t.listOf (t.str));
              default = null;
            };
          }; });
            default = null;
          };
          maxUrlParts = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
        }; });
          default = null;
        };
      }; });
        default = null;
        description = "HTTP endpoint feature toggles under the gateway API surface for compatibility routes and optional integrations. Enable endpoints intentionally and monitor access patterns after rollout.";
      };
      securityHeaders = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        strictTransportSecurity = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.enum [ false ]) ]);
          default = null;
          description = "Value for the Strict-Transport-Security response header. Set only on HTTPS origins that you fully control; use false to explicitly disable.";
        };
      }; });
        default = null;
        description = "Optional HTTP response security headers applied by the gateway process itself. Prefer setting these at your reverse proxy when TLS terminates there.";
      };
    }; });
      default = null;
      description = "Gateway HTTP API configuration grouping endpoint toggles and transport-facing API exposure controls. Keep only required endpoints enabled to reduce attack surface.";
    };
    mode = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "local" ]) (t.enum [ "remote" ]) ]);
      default = null;
      description = "Gateway operation mode: \"local\" runs channels and agent runtime on this host, while \"remote\" connects through remote transport. Keep \"local\" unless you intentionally run a split remote gateway topology.";
    };
    nodes = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowSkills = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Accept skills published by paired nodes while they are connected (default: true). Set false to ignore node-published skills.";
      };
      browser = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "auto" ]) (t.enum [ "manual" ]) (t.enum [ "off" ]) ]);
          default = null;
          description = "Node browser routing (\"auto\" = pick single connected browser node, \"manual\" = require node param, \"off\" = disable).";
        };
        node = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Pin browser routing to a specific node id or name (optional).";
        };
      }; });
        default = null;
      };
      commands = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Extra node.invoke commands to allow beyond the gateway defaults (array of command strings). Enabling dangerous commands here is a security-sensitive override and is flagged by `openclaw security audit`.";
        };
        deny = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Node command names to block even if present in node claims or default allowlist (exact command-name matching only, e.g. `system.run`; does not inspect shell text inside that command).";
        };
      }; });
        default = null;
      };
      pairing = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        autoApproveCidrs = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Opt-in CIDR/IP allowlist for auto-approving first-time node-role device pairing with no requested scopes. Disabled when unset. Operator, browser, Control UI, and any role, scope, metadata, or public-key upgrade pairing still require manual approval.";
        };
        autoApproveLocal = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Silently approve trusted local pairing and access upgrades (default: true); set false to trade convenience for explicit approval of every device.";
        };
        sshVerify = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
          cidrs = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          identity = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          user = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }) ]);
          default = null;
          description = "SSH-verified auto-approval for first-time node-role device pairing (default: enabled). The gateway SSHes back to the pairing host (BatchMode, strict host keys) and approves only when the remote `openclaw node identity` output matches the pending device key. Set false to disable SSH verification (independent of autoApproveCidrs, which stays active); for manual-only pairing also unset autoApproveCidrs. Pass an object to override user/identity/timeoutMs/cidrs.";
        };
      }; });
        default = null;
        description = "Node pairing policy settings. SSH-verified auto-approval is enabled by default; CIDR auto-approval stays disabled unless explicit trusted CIDR/IP allowlists are configured.";
      };
      pluginTools = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Accept agent-visible plugin tool descriptors published by paired nodes (default: true). Set false to ignore and remove all node-published plugin tools.";
        };
      }; });
        default = null;
        description = "Controls whether paired nodes may publish agent-visible plugin tool descriptors.";
      };
    }; });
      default = null;
    };
    port = lib.mkOption {
      type = t.nullOr (t.int);
      default = null;
      description = "TCP port used by the gateway listener for API, control UI, and channel-facing ingress paths. Use a dedicated port and avoid collisions with reverse proxies or local developer services.";
    };
    publicOrigin = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Externally reachable HTTPS origin of the Gateway. HTTP is allowed only for localhost, 127.0.0.1, or [::1]. Per-requester MCP OAuth uses it to build the callback URL at /oauth/mcp/callback; channel session links and plugin-generated viewer links use it to reach the Control UI and Gateway routes.";
    };
    push = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      apns = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        relay = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          baseUrl = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional custom base HTTPS URL for the external APNs relay service used by official App Store iOS builds. Keep this aligned with the relay URL baked into the iOS build so registration and send traffic hit the same deployment.";
          };
          timeoutMs = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
            description = "Timeout in milliseconds for relay send requests from the gateway to the APNs relay (default: 10000). Increase for slower relays or networks, or lower to fail wake attempts faster.";
          };
        }; });
          default = null;
          description = "External relay settings for relay-backed APNs sends. The gateway uses the hosted OpenClaw relay by default, or this custom relay for push.test, wake nudges, and reconnect wakes after a paired official iOS build publishes a relay-backed registration.";
        };
      }; });
        default = null;
        description = "APNs delivery settings for iOS devices paired to this gateway. Use relay settings for official App Store builds that register through the external push relay.";
      };
    }; });
      default = null;
      description = "Push-delivery settings used by the gateway when it needs to wake or notify paired devices. Configure relay-backed APNs here for official iOS builds; direct APNs auth remains env-based for local/manual builds.";
    };
    reload = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "hybrid" ]) ]);
        default = null;
        description = "Controls how config edits are applied: \"off\" ignores live edits and \"hybrid\" applies hot-safe changes then restarts when required.";
      };
    }; });
      default = null;
      description = "Live config-reload policy for how edits are applied and when full restarts are triggered. Keep hybrid behavior for safest operational updates unless debugging reload internals.";
    };
    remote = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      password = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Password credential used for remote gateway authentication when password mode is enabled. Keep this secret managed externally and avoid plaintext values in committed config.";
      };
      remotePort = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      sshHostKeyPolicy = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "strict" ]) (t.enum [ "openssh" ]) ]);
        default = null;
        description = "macOS SSH host-key verification policy. \"strict\" requires an already trusted host key; \"openssh\" explicitly delegates to effective OpenSSH configuration.";
      };
      sshIdentity = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional SSH identity file path (passed to ssh -i).";
      };
      sshTarget = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Remote gateway over SSH (tunnels the gateway port to localhost). Format: user@host or user@host:port.";
      };
      tlsFingerprint = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Expected sha256 TLS fingerprint for the remote gateway (pin to avoid MITM).";
      };
      token = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Bearer token used to authenticate this client to a remote gateway in token-auth deployments. Store via secret/env substitution and rotate alongside remote gateway auth changes.";
      };
      transport = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "ssh" ]) (t.enum [ "direct" ]) ]);
        default = null;
        description = "Remote connection transport: \"direct\" uses configured URL connectivity, while \"ssh\" tunnels through SSH. Use SSH when you need encrypted tunnel semantics without exposing remote ports.";
      };
      url = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Remote Gateway WebSocket URL (ws:// or wss://).";
      };
    }; });
      default = null;
      description = "Remote gateway connection settings for direct or SSH transport when this instance proxies to another runtime host. Use remote mode only when split-host operation is intentionally configured.";
    };
    tailscale = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "serve" ]) (t.enum [ "funnel" ]) ]);
        default = null;
        description = "Tailscale publish mode: \"off\", \"serve\", or \"funnel\" for private or public exposure paths. Use \"serve\" for tailnet-only access and \"funnel\" only when public internet reachability is required.";
      };
      preserveFunnel = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "When mode='serve' and an externally configured Tailscale Funnel route already covers the gateway port, skip re-applying tailscale serve on startup. Lets operators keep Funnel exposure managed outside OpenClaw without losing it across gateway restarts.";
      };
      resetOnExit = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Resets Tailscale Serve/Funnel state on gateway exit to avoid stale published routes after shutdown. Keep enabled unless another controller manages publish lifecycle outside the gateway.";
      };
      serviceName = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional Tailscale Service name for Serve mode, such as \"svc:openclaw\". The value must use Tailscale's svc:<dns-label> format. When set, OpenClaw passes it to tailscale serve --service and reports the derived Service URL.";
      };
    }; });
      default = null;
      description = "Tailscale integration settings for Serve/Funnel exposure and lifecycle handling on gateway start/exit. Keep off unless your deployment intentionally relies on Tailscale ingress.";
    };
    terminal = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      detachedSessionTimeoutSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Seconds a terminal session survives after its connection drops (laptop sleep, page reload), staying reattachable via terminal.attach with its recent output replayed. Set 0 to kill sessions the moment the connection drops. Default: 300 (5 minutes). Detached sessions keep running their commands, so shorten this on shared or exposed hosts.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables the operator terminal for admin-scope clients (default: true). This exposes a browser/mobile shell with the gateway process environment; set false to opt out on deployments where admin operators should not get a host shell. Changing this restarts the gateway so connected clients reload with the correct terminal availability and content-security policy.";
      };
      shell = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Shell executable the operator terminal launches. Leave unset to use the host login shell ($SHELL on Unix, %ComSpec% on Windows), or pin an explicit interpreter for a consistent operator environment.";
      };
    }; });
      default = null;
      description = "Operator terminal served to Control UI and mobile clients: a PTY-backed shell on the gateway host, restricted to admin-scope operator sessions. It starts in the target agent's workspace and is refused for fully-sandboxed agents (sandbox.mode 'all') rather than handing back an unconfined host shell.";
    };
    tls = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      autoGenerate = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Auto-generates a local TLS certificate/key pair when explicit files are not configured. Use only for local/dev setups and replace with real certificates for production traffic.";
      };
      caPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional CA bundle path for client verification or custom trust-chain requirements at the gateway edge. Use this when private PKI or custom certificate chains are part of deployment.";
      };
      certPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Filesystem path to the TLS certificate file used by the gateway when TLS is enabled. Use managed certificate paths and keep renewal automation aligned with this location.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables TLS termination at the gateway listener so clients connect over HTTPS/WSS directly. Keep enabled for direct internet exposure or any untrusted network boundary.";
      };
      keyPath = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Filesystem path to the TLS private key file used by the gateway when TLS is enabled. Keep this key file permission-restricted and rotate per your security policy.";
      };
    }; });
      default = null;
      description = "TLS certificate and key settings for terminating HTTPS directly in the gateway process. Use explicit certificates in production and avoid plaintext exposure on untrusted networks.";
    };
    tools = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allow = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Explicit gateway-level tool allowlist when you want a narrow set of tools available at runtime. Use this for locked-down environments where tool scope must be tightly controlled.";
      };
      deny = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Explicit gateway-level tool denylist to block risky tools even if lower-level policies allow them. Use deny rules for emergency response and defense-in-depth hardening.";
      };
    }; });
      default = null;
      description = "Gateway-level tool exposure allow/deny policy that can restrict runtime tool availability independent of agent/tool profiles. Use this for coarse emergency controls and production hardening.";
    };
    trustedProxies = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "CIDR/IP allowlist of upstream proxies permitted to provide forwarded client identity headers. Keep this list narrow so untrusted hops cannot impersonate users.";
    };
  }; });
    default = null;
    description = "Gateway runtime surface for bind mode, auth, control UI, remote transport, and operational safety controls. Keep conservative defaults unless you intentionally expose the gateway beyond trusted local interfaces.";
  };

  hooks = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    allowRequestSessionKey = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Allows callers to supply a session key in hook requests when true, enabling caller-controlled routing. Keep false unless trusted integrators explicitly need custom session threading.";
    };
    allowedAgentIds = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Allowlist of effective agent IDs that hook requests and mappings are allowed to target, including default-agent routing when agentId is omitted. Use this to constrain automation events to dedicated service agents and reduce blast radius if a hook token is exposed.";
    };
    allowedSessionKeyPrefixes = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Allowlist of accepted session-key prefixes for inbound hook requests when caller-provided keys are enabled. Use narrow prefixes to prevent arbitrary session-key injection.";
    };
    defaultSessionKey = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Fallback session key used for hook deliveries when a request does not provide one through allowed channels. Use a stable but scoped key to avoid mixing unrelated automation conversations.";
    };
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables the hooks endpoint and mapping execution pipeline for inbound webhook requests. Keep disabled unless you are actively routing external events into the gateway.";
    };
    gmail = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      account = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Google account identifier used for Gmail watch/subscription operations in this hook integration. Use a dedicated automation mailbox account to isolate operational permissions.";
      };
      allowUnsafeExternalContent = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows less-sanitized external Gmail content to pass into processing when enabled. Keep disabled for safer defaults, and enable only for trusted mail streams with controlled transforms.";
      };
      hookUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Public callback URL Gmail or intermediaries invoke to deliver notifications into this hook pipeline. Keep this URL protected with token validation and restricted network exposure.";
      };
      includeBody = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "When true, fetch and include email body content for downstream mapping/agent processing. Keep false unless body text is required, because this increases payload size and sensitivity.";
      };
      label = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional Gmail label filter limiting which labeled messages trigger hook events. Keep filters narrow to avoid flooding automations with unrelated inbox traffic.";
      };
      maxBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum Gmail payload bytes processed per event when includeBody is enabled. Keep conservative limits to reduce oversized message processing cost and risk.";
      };
      model = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional model override for Gmail-triggered runs when mailbox automations should use dedicated model behavior. Keep unset to inherit agent defaults unless mailbox tasks need specialization.";
      };
      pushToken = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Shared secret token required on Gmail push hook callbacks before processing notifications. Use env substitution and rotate if callback endpoints are exposed externally.";
      };
      renewEveryMinutes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Renewal cadence in minutes for Gmail watch subscriptions to prevent expiration. Set below provider expiration windows and monitor renew failures in logs.";
      };
      serve = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        bind = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Bind address for the local Gmail callback HTTP server used when serving hooks directly. Keep loopback-only unless external ingress is intentionally required.";
        };
        path = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "HTTP path on the local Gmail callback server where push notifications are accepted. Keep this consistent with subscription configuration to avoid dropped events.";
        };
        port = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Port for the local Gmail callback HTTP server when serve mode is enabled. Use a dedicated port to avoid collisions with gateway/control interfaces.";
        };
      }; });
        default = null;
        description = "Local callback server settings block for directly receiving Gmail notifications without a separate ingress layer. Enable only when this process should terminate webhook traffic itself.";
      };
      subscription = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Pub/Sub subscription consumed by the gateway to receive Gmail change notifications from the configured topic. Keep subscription ownership clear so multiple consumers do not race unexpectedly.";
      };
      tailscale = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "serve" ]) (t.enum [ "funnel" ]) ]);
          default = null;
          description = "Tailscale exposure mode for Gmail callbacks: \"off\", \"serve\", or \"funnel\". Use \"serve\" for private tailnet delivery and \"funnel\" only when public internet ingress is required.";
        };
        path = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Path published by Tailscale Serve/Funnel for Gmail callback forwarding when enabled. Keep it aligned with Gmail webhook config so requests reach the expected handler.";
        };
        target = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Local service target forwarded by Tailscale Serve/Funnel (for example http://127.0.0.1:8787). Use explicit loopback targets to avoid ambiguous routing.";
        };
      }; });
        default = null;
        description = "Tailscale exposure configuration block for publishing Gmail callbacks through Serve/Funnel routes. Use private tailnet modes before enabling any public ingress path.";
      };
      thinking = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "minimal" ]) (t.enum [ "low" ]) (t.enum [ "medium" ]) (t.enum [ "high" ]) ]);
        default = null;
        description = "Thinking effort override for Gmail-driven agent runs: \"off\", \"minimal\", \"low\", \"medium\", or \"high\". Keep modest defaults for routine inbox automations to control cost and latency.";
      };
      topic = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Google Pub/Sub topic name used by Gmail watch to publish change notifications for this account. Ensure the topic IAM grants Gmail publish access before enabling watches.";
      };
    }; });
      default = null;
      description = "Gmail push integration settings used for Pub/Sub notifications and optional local callback serving. Keep this scoped to dedicated Gmail automation accounts where possible.";
    };
    internal = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables processing for internal hooks and configured entries in the internal hook runtime. Keep disabled unless internal hooks are intentionally configured.";
      };
      entries = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        env = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
      }; }));
        default = null;
        description = "Configured internal hook entry records used to register concrete runtime handlers and metadata. Keep entries explicit and versioned so production behavior is auditable.";
      };
      load = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        extraDirs = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Additional directories searched for internal hook modules beyond default load paths. Keep this minimal and controlled to reduce accidental module shadowing.";
        };
      }; });
        default = null;
        description = "Internal hook loader settings controlling where handler modules are discovered at startup. Use constrained load roots to reduce accidental module conflicts or shadowing.";
      };
    }; });
      default = null;
      description = "Internal hook runtime settings for bundled/custom event handlers loaded from module paths. Use this for trusted in-process automations and keep handler loading tightly scoped.";
    };
    mappings = lib.mkOption {
      type = t.nullOr (t.listOf (t.submodule { options = {
      action = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "wake" ]) (t.enum [ "agent" ]) ]);
        default = null;
        description = "Mapping action type: \"wake\" triggers agent wake flow, while \"agent\" sends directly to agent handling. Use \"agent\" for immediate execution and \"wake\" when heartbeat-driven processing is preferred.";
      };
      agentId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Target agent ID for mapping execution when action routing should not use defaults. Use dedicated automation agents to isolate webhook behavior from interactive operator sessions.";
      };
      allowUnsafeExternalContent = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "When true, mapping content may include less-sanitized external payload data in generated messages. Keep false by default and enable only for trusted sources with reviewed transform logic.";
      };
      channel = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Delivery channel override for mapping outputs (for example \"last\", \"telegram\", \"discord\", \"slack\", \"signal\", \"imessage\", or \"msteams\"). Keep channel overrides explicit to avoid accidental cross-channel sends.";
      };
      deliver = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Controls whether mapping execution results are delivered back to a channel destination versus being processed silently. Disable delivery for background automations that should not post user-facing output.";
      };
      id = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional stable identifier for a hook mapping entry used for auditing, troubleshooting, and targeted updates. Use unique IDs so logs and config diffs can reference mappings unambiguously.";
      };
      match = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        path = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Path match condition for a hook mapping, usually compared against the inbound request path. Use this to split automation behavior by webhook endpoint path families.";
        };
        source = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Source match condition for a hook mapping, typically set by trusted upstream metadata or adapter logic. Use stable source identifiers so routing remains deterministic across retries.";
        };
      }; });
        default = null;
        description = "Grouping object for mapping match predicates such as path and source before action routing is applied. Keep match criteria specific so unrelated webhook traffic does not trigger automations.";
      };
      messageTemplate = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Template for synthesizing structured mapping input into the final message content sent to the target action path. Keep templates deterministic so downstream parsing and behavior remain stable.";
      };
      model = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional model override for mapping-triggered runs when automation should use a different model than agent defaults. Use this sparingly so behavior remains predictable across mapping executions.";
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Human-readable mapping display name used in diagnostics and operator-facing config UIs. Keep names concise and descriptive so routing intent is obvious during incident review.";
      };
      sessionKey = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Explicit session key override for mapping-delivered messages to control thread continuity. Use stable scoped keys so repeated events correlate without leaking into unrelated conversations.";
      };
      sessionMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "isolated" ]) (t.enum [ "persistent" ]) ]);
        default = null;
        description = "Controls mapping session continuity: \"isolated\" starts a fresh run session, while \"persistent\" reuses the resolved sessionKey. Keep isolated unless the integration intentionally needs durable context.";
      };
      textTemplate = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Text-only fallback template used when rich payload rendering is not desired or not supported. Use this to provide a concise, consistent summary string for chat delivery surfaces.";
      };
      thinking = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional thinking-effort override for mapping-triggered runs to tune latency versus reasoning depth. Keep low or minimal for high-volume hooks unless deeper reasoning is clearly required.";
      };
      timeoutSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum runtime allowed for mapping action execution before timeout handling applies. Use tighter limits for high-volume webhook sources to prevent queue pileups.";
      };
      to = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Destination identifier inside the selected channel when mapping replies should route to a fixed target. Verify provider-specific destination formats before enabling production mappings.";
      };
      transform = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        export = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Named export to invoke from the transform module; defaults to module default export when omitted. Set this when one file hosts multiple transform handlers.";
        };
        module = lib.mkOption {
          type = t.str;
          description = "Relative transform module path loaded from hooks.transformsDir to rewrite incoming payloads before delivery. Keep modules local, reviewed, and free of path traversal patterns.";
        };
      }; });
        default = null;
        description = "Transform configuration block defining module/export preprocessing before mapping action handling. Use transforms only from reviewed code paths and keep behavior deterministic for repeatable automation.";
      };
      wakeMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "now" ]) (t.enum [ "next-heartbeat" ]) ]);
        default = null;
        description = "Wake scheduling mode: \"now\" wakes immediately, while \"next-heartbeat\" defers until the next heartbeat cycle. Use deferred mode for lower-priority automations that can tolerate slight delay.";
      };
    }; }));
      default = null;
      description = "Ordered mapping rules that match inbound hook requests and choose wake or agent actions with optional delivery routing. Use specific mappings first to avoid broad pattern rules capturing everything.";
    };
    path = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "HTTP path used by the hooks endpoint (for example `/hooks`) on the gateway control server. Use a non-guessable path and combine it with token validation for defense in depth.";
    };
    presets = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Named hook preset bundles applied at load time to seed standard mappings and behavior defaults. Keep preset usage explicit so operators can audit which automations are active.";
    };
    token = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Shared bearer token checked by hooks ingress for request authentication before mappings run. Treat holders as full-trust callers for the hook ingress surface, not as a separate non-owner role. Use environment substitution and rotate regularly when webhook endpoints are internet-accessible.";
    };
    transformsDir = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Base directory for hook transform modules referenced by mapping transform.module paths. Use a controlled repo directory so dynamic imports remain reviewable and predictable.";
    };
  }; });
    default = null;
    description = "Inbound webhook automation surface for mapping external events into wake or agent actions in OpenClaw. Keep this locked down with explicit token/session/agent controls before exposing it beyond trusted networks.";
  };

  logging = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    audit = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Records new run, tool, and enabled message audit events. Default: true. Disabling event inserts does not immediately delete existing records; retained rows remain queryable until they expire.";
      };
      executionIdentity = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Retains bounded execution-identity attribution for exact-run inspection. Default: false. Requires logging.audit.enabled; restart the Gateway after changing it.";
      };
      messages = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "direct" ]) (t.enum [ "all" ]) ]);
        default = null;
        description = "Controls content-free message lifecycle records: \"off\" (default), \"direct\" for known direct conversations only, or \"all\" for direct, group, channel, and unknown conversation kinds. Both logging.audit.enabled and logging.audit.messages are startup-scoped; restart the Gateway after changing either setting.";
      };
    }; });
      default = null;
      description = "Bounded metadata-only audit history for operator review. Run and tool records are enabled by default; message lifecycle metadata is a separate privacy-sensitive opt-in. The background writer is best-effort rather than a lossless compliance archive.";
    };
    consoleLevel = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "silent" ]) (t.enum [ "fatal" ]) (t.enum [ "error" ]) (t.enum [ "warn" ]) (t.enum [ "info" ]) (t.enum [ "debug" ]) (t.enum [ "trace" ]) ]);
      default = null;
      description = "Console-specific log threshold: \"silent\", \"fatal\", \"error\", \"warn\", \"info\", \"debug\", or \"trace\" for terminal output control. Use this to keep local console quieter while retaining richer file logging if needed.";
    };
    consoleStyle = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "pretty" ]) (t.enum [ "json" ]) ]);
      default = null;
      description = "Console output format style: \"pretty\" or \"json\". Use json for machine parsing pipelines and pretty for human-first terminal workflows.";
    };
    file = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Optional file path for persisted log output in addition to or instead of console logging. Use a managed writable path and align retention/rotation with your operational policy.";
    };
    level = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "silent" ]) (t.enum [ "fatal" ]) (t.enum [ "error" ]) (t.enum [ "warn" ]) (t.enum [ "info" ]) (t.enum [ "debug" ]) (t.enum [ "trace" ]) ]);
      default = null;
      description = "Primary log level threshold for runtime logger output: \"silent\", \"fatal\", \"error\", \"warn\", \"info\", \"debug\", or \"trace\". Keep \"info\" or \"warn\" for production, and use debug/trace only during investigation.";
    };
    maxFileBytes = lib.mkOption {
      type = t.nullOr (t.int);
      default = null;
    };
    redactPatterns = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Additional custom redact regex patterns applied to log output, persisted transcript text, and safety-boundary UI/tool/diagnostic payloads before emission. Use this to mask org-specific tokens and identifiers not covered by built-in redaction rules.";
    };
  }; });
    default = null;
    description = "Logging behavior controls for severity, output destinations, formatting, and sensitive-data redaction. Keep levels and redaction strict enough for production while preserving useful diagnostics.";
  };

  mcp = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    apps = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Opt-in MCP Apps rendering and app-to-server bridge. Keep disabled unless you trust the configured MCP servers that provide app UI resources.";
      };
      sandboxOrigin = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional dedicated public HTTP(S) origin for MCP Apps. Use this behind a reverse proxy or TLS terminator and proxy it only to the configured MCP Apps sandbox port. It must differ from the Control UI origin and must not serve authenticated content.";
      };
      sandboxPort = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Dedicated MCP Apps sandbox listener port. Defaults to the Gateway port plus one. Set an unused port when another local service or Gateway profile already owns that port.";
      };
    }; });
      default = null;
      description = "MCP Apps UI support. When enabled, configured MCP servers may provide interactive HTML views for their tool results.";
    };
    servers = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      args = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      auth = lib.mkOption {
        type = t.nullOr (t.enum [ "oauth" ]);
        default = null;
      };
      clientCert = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      clientKey = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      codex = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        agents = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Optional non-empty OpenClaw agent ids that should receive this MCP server in Codex app-server thread config. Empty, blank, or invalid lists fail closed; when omitted, the server is projected for all Codex app-server agents.";
        };
        defaultToolsApprovalMode = lib.mkOption {
          type = t.nullOr (t.enum [ "auto" "prompt" "approve" ]);
          default = null;
          description = "Optional Codex MCP tool approval mode for this server: \"auto\", \"prompt\", or \"approve\". Use only for MCP servers you intentionally trust.";
        };
      }; });
        default = null;
        description = "OpenClaw projection metadata for Codex app-server threads only. It does not affect ACP sessions or generic Codex harness config. Omit this block to keep the server available to every Codex app-server agent with Codex's default MCP approval behavior.";
      };
      command = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      connectionTimeoutMs = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      cwd = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      env = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ]));
        default = null;
      };
      headers = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ]));
        default = null;
      };
      oauth = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        authProfileId = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Refresh-capable auth profile id used to inject the current bearer token into this remote MCP server. When set, OpenClaw resolves and refreshes the profile at runtime and does not project refresh material downstream.";
        };
        clientMetadataUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        identity = lib.mkOption {
          type = t.nullOr (t.enum [ "shared" "per-requester" ]);
          default = null;
          description = "OAuth credential ownership for this server. Omit this field or use \"shared\" for operator-managed credentials; use \"per-requester\" to let each authenticated sender connect their own account.";
        };
        redirectUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        scope = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; });
        default = null;
      };
      requestTimeoutMs = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
      };
      sslVerify = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      supportsParallelToolCalls = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      toolFilter = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        exclude = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Exact MCP tool names or simple '*' globs to hide from this server.";
        };
        include = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Exact MCP tool names or simple '*' globs to expose from this server. When omitted, all server tools remain eligible unless excluded.";
        };
      }; });
        default = null;
        description = "Per-server MCP tool selection. Use include to expose only selected MCP tool names, or exclude to hide selected MCP tool names. Entries accept exact names and simple '*' globs.";
      };
      transport = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "stdio" ]) (t.enum [ "sse" ]) (t.enum [ "streamable-http" ]) ]);
        default = null;
      };
      url = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; }));
      default = null;
      description = "Named MCP server definitions. OpenClaw stores them in its own config and runtime adapters decide which transports are supported at execution time.";
    };
  }; });
    default = null;
    description = "Global MCP server definitions managed by OpenClaw. Embedded OpenClaw and other runtime adapters can consume these servers without storing them inside runtime-owned project settings.";
  };

  memory = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    citations = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "auto" ]) (t.enum [ "on" ]) (t.enum [ "off" ]) ]);
      default = null;
      description = "Controls citation visibility in replies: \"auto\" shows citations when useful, \"on\" always shows them, and \"off\" hides them. Keep \"auto\" for a balanced signal-to-noise default.";
    };
    search = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      cache = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Caches computed chunk embeddings in SQLite so reindexing and incremental updates run faster (default: true). Keep this enabled unless investigating cache correctness or minimizing disk usage.";
        };
      }; });
        default = null;
      };
      documentInputType = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional provider-specific `input_type` value for document and indexing memory embeddings. Use this with OpenAI-compatible asymmetric embedding endpoints that require a passage or document label.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Master toggle for memory search indexing and retrieval behavior on this agent profile. Keep enabled for semantic recall, and disable when you want fully stateless responses.";
      };
      experimental = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        sessionMemory = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Indexes session transcripts into memory search. Keep this advanced override when root and per-agent recall inheritance differ.";
        };
      }; });
        default = null;
      };
      extraPaths = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.str) (t.submodule { options = {
        path = lib.mkOption {
          type = t.str;
          description = "Sets the extra memory directory or file. Relative paths resolve from the agent workspace; direct file entries are indexed exactly.";
        };
        pattern = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Limits a directory entry to supported files matching this root-relative glob, for example \"runbooks/**/*.md\". Omit it to scan all supported files recursively.";
        };
      }; }) ]));
        default = null;
        description = "Adds extra directories or .md files to the memory index beyond default memory files. Entries may be path strings or objects with a root-relative glob pattern. When multimodal memory is enabled, matching image/audio files under these paths are also eligible for indexing.";
      };
      fallback = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Backup provider used when primary embeddings fail: \"openai\", \"gemini\", \"voyage\", \"mistral\", \"bedrock\", \"lmstudio\", \"ollama\", \"local\", or \"none\". Set a real fallback for production reliability; use \"none\" only if you prefer explicit failures.";
      };
      inputType = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Use this optional provider-specific `input_type` value only when the same label should apply to both query and document embedding requests. For asymmetric providers, prefer queryInputType and documentInputType.";
      };
      local = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        modelPath = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Specifies the local embedding model source for local memory search, such as a GGUF file path or `hf:` URI. Use this only when provider is `local`, and verify model compatibility before large index rebuilds.";
        };
      }; });
        default = null;
      };
      model = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Embedding model override used by the selected memory provider when a non-default model is required. Set this only when you need explicit recall quality/cost tuning beyond provider defaults.";
      };
      multimodal = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enables image/audio memory indexing from extraPaths. This currently requires Gemini embedding-2, keeps the default memory roots Markdown-only, disables memory-search fallback providers, and uploads matching binary content to the configured remote embedding provider.";
        };
        maxFileBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Sets the maximum bytes allowed per multimodal file before it is skipped during memory indexing. Use this to cap upload cost and indexing latency, or raise it for short high-quality audio clips.";
        };
        modalities = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "image" ]) (t.enum [ "audio" ]) (t.enum [ "all" ]) ]));
          default = null;
          description = "Selects which multimodal file types are indexed from extraPaths: \"image\", \"audio\", or \"all\". Keep this narrow to avoid indexing large binary corpora unintentionally.";
        };
      }; });
        default = null;
        description = "Optional multimodal memory settings for indexing image and audio files from configured extra paths. Keep this off unless your embedding model explicitly supports cross-modal embeddings, and set `memory.search.fallback` to \"none\" while it is enabled. Matching files are uploaded to the configured remote embedding provider during indexing.";
      };
      outputDimensionality = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Provider-specific output vector size override for memory embeddings. Gemini embedding-2 supports 768, 1536, or 3072; Bedrock families such as Titan V2, Cohere V4, and Nova expose their own allowed sizes. Expect a full reindex when you change it because stored vector dimensions must stay consistent.";
      };
      provider = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Selects the embedding backend used to build/query memory vectors. Defaults to \"openai\"; set \"openai-compatible\", \"gemini\", \"voyage\", \"mistral\", \"bedrock\", \"deepinfra\", \"github-copilot\", \"lmstudio\", \"ollama\", or \"local\" when you want a different backend.";
      };
      query = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        maxResults = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum number of memory hits returned from search before downstream reranking and prompt injection. Raise for broader recall, or lower for tighter prompts and faster responses.";
        };
        minScore = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
          description = "Minimum relevance score threshold for including memory results in final recall output. Increase to reduce weak/noisy matches, or lower when you need more permissive retrieval.";
        };
      }; });
        default = null;
      };
      queryInputType = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional provider-specific `input_type` value for query-time memory embeddings. Use this with OpenAI-compatible asymmetric embedding endpoints that require a query label.";
      };
      rememberAcrossConversations = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Use relevant context from this agent's other private conversations through protected transcript recall. Defaults on only when global session.dmScope is unset or \"main\" and no binding overrides DM scope; any configured DM isolation defaults it off. An explicit true or false always wins.";
      };
      remote = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        apiKey = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "file" "exec" "store" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
          description = "Supplies a dedicated API key for remote embedding calls used by memory indexing and query-time embeddings. Use this when memory embeddings should use different credentials than global defaults or environment variables.";
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Overrides the embedding API endpoint, such as an OpenAI-compatible proxy or custom Gemini base URL. Use this only when routing through your own gateway or vendor endpoint; keep provider defaults otherwise.";
        };
        batch = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Enables provider batch APIs for embedding jobs when supported (OpenAI/Gemini), improving throughput on larger index runs. Keep this enabled unless debugging provider batch failures or running very small workloads.";
          };
        }; });
          default = null;
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
          description = "Adds custom HTTP headers to remote embedding requests, merged with provider defaults. Use this for proxy auth and tenant routing headers, and keep values minimal to avoid leaking sensitive metadata.";
        };
      }; });
        default = null;
      };
      sources = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "memory" ]) (t.enum [ "sessions" ]) ]));
        default = null;
        description = "Chooses which sources are indexed: \"memory\" reads MEMORY.md + memory files, and \"sessions\" includes transcript history. Keep [\"memory\"] unless you need recall from prior chat transcripts.";
      };
      store = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        fts = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          tokenizer = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "unicode61" ]) (t.enum [ "trigram" ]) ]);
            default = null;
          };
        }; });
          default = null;
        };
        vector = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Controls the sqlite-vec semantic index. Keep this advanced override when root and per-agent vector policies differ.";
          };
          extensionPath = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Overrides the auto-discovered sqlite-vec extension library path (`.dylib`, `.so`, or `.dll`). Use this when your runtime cannot find sqlite-vec automatically or you pin a known-good build.";
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
    }; });
      default = null;
      description = "Vector search over MEMORY.md and memory/*.md (per-agent overrides supported).";
    };
  }; });
    default = null;
    description = "Built-in memory configuration (global).";
  };

  messages = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    ackReaction = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Emoji reaction used to acknowledge inbound messages (empty disables).";
    };
    ackReactionScope = lib.mkOption {
      type = t.nullOr (t.enum [ "group-mentions" "group-all" "direct" "all" "off" "none" ]);
      default = null;
      description = "When to send ack reactions (\"group-mentions\", \"group-all\", \"direct\", \"all\", \"off\", \"none\"). \"group-mentions\" acks group messages that mention the agent, whether or not the group requires mentions; \"group-all\" acks every group message. \"off\"/\"none\" disables ack reactions entirely.";
    };
    groupChat = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      historyLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum number of prior group messages loaded as context per turn for group sessions. Use higher values for richer continuity, or lower values for faster and cheaper responses.";
      };
      mentionPatterns = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Safe case-insensitive regex patterns used to detect explicit mentions/trigger phrases in group chats. Use precise patterns to reduce false positives in high-volume channels; invalid or unsafe nested-repetition patterns are ignored.";
      };
      unmentionedInbound = lib.mkOption {
        type = t.nullOr (t.enum [ "user_request" "room_event" ]);
        default = null;
        description = "Controls how unmentioned always-on group chatter is submitted. \"user_request\" treats it as a user request; \"room_event\" submits it as quiet context where visible output requires the message tool.";
      };
      visibleReplies = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "automatic" "message_tool" ]) (t.bool) ]);
        default = null;
        description = "Overrides model-authored source replies for group/channel conversations. Defaults to \"automatic\" when no global visible reply policy is set. \"message_tool\" requires message(action=send) for normal assistant output and generic tool media; explicitly host-owned runtime output remains deliverable except for ambient room events. \"automatic\" posts normal replies as before.";
      };
    }; });
      default = null;
      description = "Group-message handling controls including mention triggers and history window sizing. Keep mention patterns narrow so group channels do not trigger on every message.";
    };
    inbound = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      byChannel = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.int));
        default = null;
        description = "Per-channel inbound debounce overrides keyed by provider id in milliseconds. Use this where some providers send message fragments more aggressively than others.";
      };
      debounceMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Debounce window (ms) for batching rapid inbound messages from the same sender (0 to disable).";
      };
    }; });
      default = null;
      description = "Direct inbound debounce settings used before queue/turn processing starts. Configure this for provider-specific rapid message bursts from the same sender.";
    };
    queue = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      byChannel = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        discord = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        googlechat = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        imessage = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        irc = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        matrix = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        mattermost = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        msteams = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        signal = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        slack = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        telegram = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        webchat = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
        whatsapp = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
          default = null;
        };
      }; });
        default = null;
        description = "Per-channel queue mode overrides keyed by provider id (for example telegram, discord, slack). Use this when one channel's traffic pattern needs different behavior than global defaults.";
      };
      cap = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum number of queued inbound items retained before drop policy applies. Default is 20; keep caps bounded in noisy channels so memory usage remains predictable.";
      };
      debounceMsByChannel = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.int));
        default = null;
        description = "Per-channel debounce overrides for queue behavior keyed by provider id. Use this to tune burst handling independently for chat surfaces with different pacing.";
      };
      drop = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "old" ]) (t.enum [ "new" ]) (t.enum [ "summarize" ]) ]);
        default = null;
        description = "Drop strategy when queue cap is exceeded. \"summarize\" drops oldest entries but preserves compact summaries; \"old\" drops oldest without summaries; \"new\" rejects the newest item. Use \"summarize\" for long-running chats where context matters.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "followup" ]) (t.enum [ "collect" ]) (t.enum [ "interrupt" ]) ]);
        default = null;
        description = "Queue mode for active runs. Use \"steer\" to inject prompts into the active run, \"followup\" to run later, \"collect\" to batch compatible messages later, or \"interrupt\" to abort the active run before starting the newest prompt.";
      };
    }; });
      default = null;
      description = "Queue strategy for inbound messages that arrive while a session run is active. Use this to tune steering, deferred followups, batching, or interruption.";
    };
    responsePrefix = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
    };
    responseUsage = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "on" "off" "tokens" "full" ]) (t.attrsOf (t.enum [ "on" "off" "tokens" "full" ])) ]);
      default = null;
      description = "Default per-reply usage footer mode (\"off\"|\"tokens\"|\"full\") seeded into sessions that have not chosen one via /usage. Also accepts \"on\" as a legacy alias for \"tokens\". Accepts a bare mode or a per-channel map with a \"default\" fallback. Precedence: session value -> channel entry -> default -> off; an explicit /usage choice (including off) is persisted and overrides the default. Use /usage reset (aliases: inherit, clear, default) to clear a session override and re-inherit this configured default.";
    };
    statusReactions = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable lifecycle status reactions on supported channels. Discord treats unset as enabled when ack reactions are active; Slack, Signal, Telegram, and WhatsApp require this to be true before lifecycle reactions are used. Slack uses native assistant thread status for progress by default.";
      };
    }; });
      default = null;
      description = "Lifecycle status reactions that update the emoji on the trigger message as the agent progresses (queued → thinking → tool → done/error).";
    };
    suppressToolErrors = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "When true, suppress ⚠️ tool-error warnings from being shown to the user. The agent already sees errors in context and can retry. Default: false.";
    };
    usageTemplate = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.str) (t.attrsOf (t.anything)) ]);
      default = null;
      description = "Custom /usage full footer template, either an inline object or a JSON file path. Invalid or unavailable templates fall back to the built-in usage line.";
    };
    visibleReplies = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "automatic" "message_tool" ]) (t.bool) ]);
      default = null;
      description = "Controls model-authored source replies across direct, group, and channel conversations. \"message_tool\" requires message(action=send) for normal assistant output and generic tool media; explicitly host-owned runtime output remains deliverable except for ambient room events. \"automatic\" posts normal replies as before.";
    };
  }; });
    default = null;
    description = "Message infrastructure and cross-agent defaults. Root siblings own infrastructure and cross-agent defaults; agents.defaults owns agent-loop behavior; agent entries may override either where supported.";
  };

  meta = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    lastTouchedVersion = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "OpenClaw version that most recently wrote this config.";
    };
    migrations = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      modelPolicyAllowlist = lib.mkOption {
        type = t.nullOr (t.enum [ true ]);
        default = null;
        description = "Records that legacy model-map restrictions were preserved or evaluated.";
      };
    }; });
      default = null;
      description = "Bounded compatibility markers for completed config migrations.";
    };
  }; });
    default = null;
    description = "Backward-readable compatibility metadata retained so older binaries can refuse unsafe config downgrades.";
  };

  models = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    catalogRefresh = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Fetch hosted model catalog updates in the background (default: true). Set to false to disable all remote model catalog traffic.";
      };
      url = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Override the hosted model catalog URL for a self-hosted HTTPS mirror (localhost HTTP is allowed for testing). Changes apply after a Gateway restart.";
      };
    }; });
      default = null;
      description = "Controls background updates to the bundled model catalog. Remote rows can update model metadata but cannot change provider endpoints or headers.";
    };
    mode = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "merge" ]) (t.enum [ "replace" ]) ]);
      default = null;
      description = "Controls provider catalog behavior: \"merge\" keeps built-ins and overlays your custom providers, while \"replace\" uses only your configured providers. In \"merge\", matching provider IDs preserve non-empty agent models.json baseUrl values, while apiKey values are preserved only when the provider is not SecretRef-managed in current config/auth-profile context; SecretRef-managed providers refresh apiKey from current source markers, and matching model contextWindow/maxTokens use the higher value between explicit and implicit entries.";
    };
    providers = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      agentRuntime = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        id = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Provider agent runtime id: \"openclaw\", \"auto\", a registered plugin harness id such as \"codex\", or a supported CLI backend alias such as \"claude-cli\". OpenAI on the official endpoint defaults to the Codex harness when omitted.";
        };
      }; });
        default = null;
        description = "Optional low-level agent runtime policy for this provider. Use provider/model runtime policy instead of agent-wide runtime pins; omitted/default lets OpenClaw choose the runtime for the selected provider.";
      };
      api = lib.mkOption {
        type = t.nullOr (t.enum [ "openai-completions" "openai-responses" "openai-chatgpt-responses" "anthropic-messages" "google-generative-ai" "google-vertex" "github-copilot" "bedrock-converse-stream" "ollama" "azure-openai-responses" ]);
        default = null;
        description = "Provider API adapter selection controlling request/response compatibility handling for model calls. Use the adapter that matches your upstream provider protocol to avoid feature mismatch.";
      };
      apiKey = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Provider credential used for API-key based authentication when the provider requires direct key auth. Use secret/env substitution and avoid storing real keys in committed config files.";
      };
      auth = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "api-key" ]) (t.enum [ "aws-sdk" ]) (t.enum [ "oauth" ]) (t.enum [ "token" ]) ]);
        default = null;
        description = "Selects provider auth style: \"api-key\" for API key auth, \"token\" for bearer token auth, \"oauth\" for OAuth credentials, and \"aws-sdk\" for AWS credential resolution. Match this to your provider requirements.";
      };
      authHeader = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "When true, credentials are sent via the HTTP Authorization header even if alternate auth is possible. Use this only when your provider or proxy explicitly requires Authorization forwarding.";
      };
      baseUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Base URL for the provider endpoint used to serve model requests for that provider entry. Use HTTPS endpoints and keep URLs environment-specific through config templating where needed.";
      };
      contextTokens = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Default effective runtime context cap applied to models under this provider when a model entry does not set contextTokens. Use this when runtime should budget below the native contextWindow.";
      };
      contextWindow = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
        description = "Default native context window applied to models under this provider when a model entry does not set contextWindow. Use model-level contextWindow for per-model overrides.";
      };
      headers = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]));
        default = null;
        description = "Static HTTP headers merged into provider requests for tenant routing, proxy auth, or custom gateway requirements. Use this sparingly and keep sensitive header values in secrets.";
      };
      injectNumCtxForOpenAICompat = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Controls whether OpenClaw injects `options.num_ctx` for Ollama providers configured with the OpenAI-compatible adapter (`openai-completions`). Default is true. Set false only if your proxy/upstream rejects unknown `options` payload fields.";
      };
      localService = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        args = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Argument list passed to the local model server command without shell expansion.";
        };
        command = lib.mkOption {
          type = t.str;
          description = "Absolute executable path for the local model server process. Keep this path explicit so provider startup is deterministic and does not depend on shell PATH lookup.";
        };
        cwd = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Working directory for the local model server process.";
        };
        env = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
          description = "Additional environment variables for the local model server process. Values that look secret are redacted from config snapshots.";
        };
        healthUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Readiness URL probed before model requests. If omitted, OpenClaw uses the provider baseUrl with /models appended.";
        };
        idleStopMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Milliseconds to keep an OpenClaw-started local model server alive after the last request finishes. Set 0 to keep it alive until OpenClaw exits.";
        };
        readyTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum milliseconds to wait for the local model server readiness probe after starting the process.";
        };
      }; });
        default = null;
        description = "Optional on-demand local model server process for this provider. OpenClaw probes healthUrl, starts the command when needed, waits for readiness, and then sends the model request.";
      };
      maxTokens = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
        description = "Default maximum output token budget applied to models under this provider when a model entry does not set maxTokens.";
      };
      models = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        agentRuntime = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          id = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Model agent runtime id: \"openclaw\", \"auto\", a registered plugin harness id such as \"codex\", or a supported CLI backend alias such as \"claude-cli\".";
          };
        }; });
          default = null;
          description = "Optional low-level agent runtime policy for this specific model. Model runtime policy overrides the provider runtime policy.";
        };
        api = lib.mkOption {
          type = t.nullOr (t.enum [ "openai-completions" "openai-responses" "openai-chatgpt-responses" "anthropic-messages" "google-generative-ai" "google-vertex" "github-copilot" "bedrock-converse-stream" "ollama" "azure-openai-responses" ]);
          default = null;
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        compat = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          codeMode = lib.mkOption {
            type = t.nullOr (t.enum [ "preferred" "capable" ]);
            default = null;
          };
          maxTokensField = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "max_completion_tokens" ]) (t.enum [ "max_tokens" ]) ]);
            default = null;
          };
          reasoningEffortMap = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.str));
            default = null;
          };
          requiresAssistantAfterToolResult = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requiresOpenAiAnthropicToolPayload = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requiresReasoningContentOnAssistantMessages = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requiresStringContent = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requiresThinkingAsText = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          requiresToolResultName = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          strictMessageKeys = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportedReasoningEfforts = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          supportsDeveloperRole = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsJsonSchemaResponseFormat = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsPromptCacheKey = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsReasoningEffort = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsStore = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsStrictMode = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsTemperature = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsTools = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          supportsUsageInStreaming = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
          };
          thinkingFormat = lib.mkOption {
            type = t.nullOr (t.enum [ "openai" "openrouter" "deepseek" "together" "qwen" "qwen-chat-template" "zai" ]);
            default = null;
          };
          toolCallArgumentsEncoding = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          toolSchemaProfile = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          unsupportedToolSchemaKeywords = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          visibleReasoningDetailTypes = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        contextTokens = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        contextWindow = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        cost = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          cacheRead = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          cacheWrite = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          input = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          output = lib.mkOption {
            type = t.nullOr (t.number);
            default = null;
          };
          tieredPricing = lib.mkOption {
            type = t.nullOr (t.listOf (t.submodule { options = {
            cacheRead = lib.mkOption {
              type = t.number;
            };
            cacheWrite = lib.mkOption {
              type = t.number;
            };
            input = lib.mkOption {
              type = t.number;
            };
            output = lib.mkOption {
              type = t.number;
            };
            range = lib.mkOption {
              type = t.listOf (t.anything);
            };
          }; }));
            default = null;
          };
        }; });
          default = null;
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        id = lib.mkOption {
          type = t.str;
        };
        input = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "text" ]) (t.enum [ "image" ]) (t.enum [ "video" ]) (t.enum [ "audio" ]) ]));
          default = null;
        };
        maxTokens = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        mediaInput = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          image = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            maxBytes = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
              description = "Maximum encoded image payload size accepted by the provider for this model.";
            };
            maxPixels = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
              description = "Maximum image pixel count accepted by the provider for this model.";
            };
            maxSidePx = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
              description = "Maximum image width or height accepted by the provider for this model.";
            };
            preferredSidePx = lib.mkOption {
              type = t.nullOr (t.int);
              default = null;
              description = "Preferred image resize side for balanced compression. Leave unset to use OpenClaw's conservative default.";
            };
            tokenMode = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "tile" ]) (t.enum [ "detail" ]) (t.enum [ "provider" ]) ]);
              default = null;
              description = "Provider image token accounting style: \"tile\", \"detail\", or \"provider\".";
            };
          }; });
            default = null;
            description = "Optional image input limits for this model, such as maximum side length, maximum pixels, and preferred compression side.";
          };
        }; });
          default = null;
          description = "Optional model media capability metadata used by tools to choose conservative image compression defaults.";
        };
        metadataSource = lib.mkOption {
          type = t.nullOr (t.enum [ "models-add" ]);
          default = null;
        };
        name = lib.mkOption {
          type = t.str;
        };
        params = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.anything));
          default = null;
        };
        reasoning = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        thinkingLevelMap = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          high = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          low = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          max = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          medium = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          minimal = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          off = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          xhigh = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
      }; }));
        default = null;
        description = "Declared model list for a provider including identifiers, metadata, provider-specific params, and optional compatibility/cost hints. Keep IDs exact to provider catalog values so selection and fallback resolve correctly.";
      };
      params = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.anything));
        default = null;
        description = "Provider-specific runtime parameters interpreted by provider plugins. Keep keys documented by the provider, and prefer explicit provider docs over ad hoc shared assumptions.";
      };
      region = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional provider deployment/API region interpreted by providers that expose regional endpoints. Use provider docs for supported values; baseUrl overrides usually take precedence when both are set.";
      };
      request = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowPrivateNetwork = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "When true, allow model-provider HTTP requests to private, CGNAT, or similar ranges through the provider HTTP fetch guard (fetchWithSsrFGuard). Custom/local provider base URLs already trust the exact configured origin, except metadata/link-local origins; set this to false to opt out of that trust. OpenAI Responses WebSocket reuses request for headers/TLS but does not use that fetch SSRF path. Use true only for operator-controlled self-hosted endpoints that must reach private origins outside the configured baseUrl origin.";
        };
        auth = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.submodule { options = {
          mode = lib.mkOption {
            type = t.enum [ "provider-default" ];
            description = "Auth override mode: \"provider-default\", \"authorization-bearer\", or \"header\".";
          };
        }; }) (t.submodule { options = {
          mode = lib.mkOption {
            type = t.enum [ "authorization-bearer" ];
            description = "Auth override mode: \"provider-default\", \"authorization-bearer\", or \"header\".";
          };
          token = lib.mkOption {
            type = t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ];
            description = "Bearer token used when auth mode is authorization-bearer.";
          };
        }; }) (t.submodule { options = {
          headerName = lib.mkOption {
            type = t.str;
            description = "Custom auth header name used when auth mode is header.";
          };
          mode = lib.mkOption {
            type = t.enum [ "header" ];
            description = "Auth override mode: \"provider-default\", \"authorization-bearer\", or \"header\".";
          };
          prefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional prefix prepended to request.auth.value when auth mode is header.";
          };
          value = lib.mkOption {
            type = t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ];
            description = "Custom auth header value used when auth mode is header.";
          };
        }; }) ]);
          default = null;
          description = "Override provider request authentication behavior for this provider.";
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "file" "exec" "store" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]));
          default = null;
          description = "Extra headers merged into provider requests after default attribution and auth resolution.";
        };
        proxy = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.submodule { options = {
          mode = lib.mkOption {
            type = t.enum [ "env-proxy" ];
            description = "Proxy override mode for model-provider requests: \"env-proxy\" or \"explicit-proxy\".";
          };
          tls = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            ca = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Custom CA bundle used to verify the proxy TLS certificate chain.";
            };
            cert = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Client TLS certificate presented to the proxy when mutual TLS is required.";
            };
            insecureSkipVerify = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
              description = "Skips proxy TLS certificate verification. Use only for controlled development environments.";
            };
            key = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Private key paired with request.proxy.tls.cert for proxy mutual TLS.";
            };
            passphrase = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Optional passphrase used to decrypt request.proxy.tls.key.";
            };
            serverName = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
              description = "Optional SNI/server-name override used when establishing TLS to the proxy.";
            };
          }; });
            default = null;
            description = "Optional TLS settings used when connecting to the configured proxy.";
          };
        }; }) (t.submodule { options = {
          mode = lib.mkOption {
            type = t.enum [ "explicit-proxy" ];
            description = "Proxy override mode for model-provider requests: \"env-proxy\" or \"explicit-proxy\".";
          };
          tls = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            ca = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Custom CA bundle used to verify the proxy TLS certificate chain.";
            };
            cert = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Client TLS certificate presented to the proxy when mutual TLS is required.";
            };
            insecureSkipVerify = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
              description = "Skips proxy TLS certificate verification. Use only for controlled development environments.";
            };
            key = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Private key paired with request.proxy.tls.cert for proxy mutual TLS.";
            };
            passphrase = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
              description = "Optional passphrase used to decrypt request.proxy.tls.key.";
            };
            serverName = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
              description = "Optional SNI/server-name override used when establishing TLS to the proxy.";
            };
          }; });
            default = null;
            description = "Optional TLS settings used when connecting to the configured proxy.";
          };
          url = lib.mkOption {
            type = t.str;
            description = "Explicit proxy URL used when request.proxy.mode is explicit-proxy. Credentials embedded in the URL are treated as sensitive and redacted from snapshots.";
          };
        }; }) ]);
          default = null;
          description = "Optional proxy override for model-provider requests. Use \"env-proxy\" to honor environment proxy settings or \"explicit-proxy\" to route through a specific proxy URL.";
        };
        tls = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          ca = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
            description = "Custom CA bundle used to verify the upstream TLS certificate chain.";
          };
          cert = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
            description = "Client TLS certificate presented to the upstream endpoint when mutual TLS is required.";
          };
          insecureSkipVerify = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Skips upstream TLS certificate verification. Use only for controlled development environments.";
          };
          key = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
            description = "Private key paired with request.tls.cert for upstream mutual TLS.";
          };
          passphrase = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
            description = "Optional passphrase used to decrypt request.tls.key.";
          };
          serverName = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Optional SNI/server-name override used when establishing upstream TLS.";
          };
        }; });
          default = null;
          description = "Optional TLS settings used when connecting directly to the upstream model endpoint.";
        };
      }; });
        default = null;
        description = "Optional request overrides for model-provider requests, including extra headers, auth overrides, proxy routing, TLS client settings, and optional allowPrivateNetwork for trusted self-hosted endpoints. Use these only when your upstream or enterprise network path requires transport customization.";
      };
      timeoutSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Optional per-provider model request timeout in seconds. Provider-level request settings affect explicit provider-owned model rows; they do not create implicit models. For custom providers, set it alongside the provider baseUrl and models. Applies to provider HTTP fetches, including connect, headers, body, and total request abort handling, and also raises the LLM idle/stream watchdog ceiling for this provider above the implicit ~120s default. Use this for slow local or self-hosted model servers, or for cloud providers that buffer reasoning tokens silently on the wire (Gemini preview, large-tool-payload Claude/Opus), instead of changing global agent timeouts.";
      };
    }; }));
      default = null;
      description = "Provider map keyed by provider ID containing connection/auth settings and concrete model definitions. Built-in providers may be tuned with provider-level overlays; custom providers must include baseUrl and models. Use stable provider keys so references from agents and tooling remain portable across environments.";
    };
  }; });
    default = null;
    description = "Model catalog root for provider definitions, merge/replace behavior, and optional Bedrock discovery integration. Keep provider definitions explicit and validated before relying on production failover paths.";
  };

  nodeHost = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    agentRuns = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      claude = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Advertise paired-node Claude session continuation when the local claude binary is available (default: false). Runs still require node exec approval.";
        };
      }; });
        default = null;
        description = "Controls whether this headless node host may advertise Claude CLI agent turns to the gateway.";
      };
    }; });
      default = null;
      description = "Opt in to approval-gated native agent turns on this headless node host. Disabled by default.";
    };
    browserProxy = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowProfiles = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Optional allowlist of browser profile names exposed through node proxy routing. Leave empty to preserve the default full profile surface, including profile create/delete routes. When set, OpenClaw enforces least-privilege profile access and blocks persistent profile create/delete through the proxy.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Expose the local browser control server through node proxy routing so remote clients can use this host's browser capabilities. Keep disabled unless remote automation explicitly depends on it.";
      };
    }; });
      default = null;
      description = "Groups browser-proxy settings for exposing local browser control through node routing. Enable only when remote node workflows need your local browser profiles.";
    };
    mcp = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      servers = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        args = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        auth = lib.mkOption {
          type = t.nullOr (t.enum [ "oauth" ]);
          default = null;
        };
        clientCert = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        clientKey = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        codex = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          agents = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          defaultToolsApprovalMode = lib.mkOption {
            type = t.nullOr (t.enum [ "auto" "prompt" "approve" ]);
            default = null;
          };
        }; });
          default = null;
        };
        command = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        connectionTimeoutMs = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        cwd = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        env = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ]));
          default = null;
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ]));
          default = null;
        };
        oauth = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          authProfileId = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          clientMetadataUrl = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          identity = lib.mkOption {
            type = t.nullOr (t.enum [ "shared" "per-requester" ]);
            default = null;
          };
          redirectUrl = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
          scope = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; });
          default = null;
        };
        requestTimeoutMs = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        sslVerify = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        supportsParallelToolCalls = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        toolFilter = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          exclude = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          include = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
        }; });
          default = null;
        };
        transport = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "stdio" ]) (t.enum [ "sse" ]) (t.enum [ "streamable-http" ]) ]);
          default = null;
        };
        url = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
        description = "Named MCP server definitions local to this node. Uses the same server shape as mcp.servers; OAuth servers are not supported by the node host.";
      };
    }; });
      default = null;
      description = "Use MCP servers started by the headless node host and published to its paired gateway as agent tools. Restart the node host after changing this section.";
    };
    skills = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Scan and publish node-hosted skills after connecting (default: true). Set false to disable node skill publication.";
      };
    }; });
      default = null;
      description = "Use this section to publish skills installed in ~/.openclaw/skills from the headless node host. Restart the node host after changing skill files.";
    };
    workerRuns = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Advertise this paired node as a session host and pin its local OpenClaw build identity (default: false). The node version must exactly match the gateway.";
      };
    }; });
      default = null;
      description = "Opt in to full OpenClaw worker session hosting from this headless node's local installation. Disabled by default.";
    };
  }; });
    default = null;
    description = "Node host controls for features exposed from this gateway node to other nodes or clients. Keep defaults unless you intentionally proxy local capabilities across your node network.";
  };

  plugins = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    allow = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Optional allowlist of plugin IDs; when set, only listed plugins are eligible to load. Configured bundled chat channels can still activate their bundled plugin when the channel is explicitly enabled in config. Use this to enforce approved extension inventories in controlled environments.";
    };
    deny = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Optional denylist of plugin IDs that are blocked even if allowlists or paths include them. Use deny rules for emergency rollback and hard blocks on risky plugins.";
    };
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enable or disable plugin/extension loading globally during startup and config reload (default: true). Keep enabled only when extension capabilities are required by your deployment.";
    };
    entries = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      config = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.anything));
        default = null;
        description = "Plugin-defined configuration payload interpreted by that plugin's own schema and validation rules. Use only documented fields from the plugin to prevent ignored or invalid settings.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Per-plugin enablement override for a specific entry, applied on top of global plugin policy (restart required). Use this to stage plugin rollout gradually across environments.";
      };
      hooks = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowConversationAccess = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Controls whether this plugin may read raw conversation content from typed hooks such as `before_agent_run`, `before_model_resolve`, `before_agent_reply`, `llm_input`, `llm_output`, `before_agent_finalize`, and `agent_end`. Non-bundled plugins must opt in explicitly.";
        };
        allowPromptInjection = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Controls whether this plugin may mutate prompts through typed hooks. Set false to block `before_prompt_build`.";
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default timeout in milliseconds for this plugin's typed hooks, capped at 600000. Use this to bound slow plugin hooks without changing plugin code; per-hook values in hooks.timeouts take precedence.";
        };
        timeouts = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.int));
          default = null;
          description = "Per-hook timeout overrides in milliseconds keyed by typed hook name, capped at 600000. Use narrow overrides for known slow hooks such as before_prompt_build or agent_end instead of raising every hook timeout.";
        };
      }; });
        default = null;
        description = "Per-plugin typed hook policy controls for core-enforced safety gates. Use this to constrain high-impact hook categories without disabling the entire plugin.";
      };
      llm = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowAgentIdOverride = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Explicitly allows this plugin to request api.runtime.llm.complete against a non-default agent id. Keep false unless the plugin is trusted for cross-agent model access.";
        };
        allowAuthProfileOverride = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Allows this plugin to select a non-default auth profile for isolated agent-runtime completions. Keep false unless the plugin is trusted for explicit isolated credential routing.";
        };
        allowModelOverride = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Explicitly allows this plugin to request model overrides in api.runtime.llm.complete. Keep false unless the plugin is trusted to steer model selection.";
        };
        allowedCompletionModels = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Allowed targets for every plugin LLM completion as canonical \"provider/model\" refs, including host-resolved defaults and overrides. Use \"*\" only when you intentionally allow any model.";
        };
        allowedModels = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Allowed override targets for trusted plugin LLM calls as canonical \"provider/model\" refs. Use \"*\" only when you intentionally allow any model override.";
        };
      }; });
        default = null;
        description = "Per-plugin api.runtime.llm.complete controls for model and agent override trust. Keep this unset unless a plugin must explicitly steer host-owned completion calls.";
      };
      subagent = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowModelOverride = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Explicitly allows this plugin to request provider/model overrides in background subagent runs. Keep false unless the plugin is trusted to steer model selection.";
        };
        allowedModels = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Allowed override targets for trusted plugin subagent runs as canonical \"provider/model\" refs. Use \"*\" only when you intentionally allow any model.";
        };
      }; });
        default = null;
        description = "Per-plugin subagent runtime controls for model override trust and allowlists. Keep this unset unless a plugin must explicitly steer subagent model selection.";
      };
    }; }));
      default = null;
      description = "Per-plugin settings keyed by plugin ID including enablement and plugin-specific runtime configuration payloads. Use this for scoped plugin tuning without changing global loader policy.";
    };
    load = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      paths = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Additional plugin files or directories scanned by the loader beyond built-in defaults. Use dedicated extension directories and avoid broad paths with unrelated executable content.";
      };
    }; });
      default = null;
      description = "Plugin loader configuration group for specifying filesystem paths where plugins are discovered. Keep load paths explicit and reviewed to avoid accidental untrusted extension loading.";
    };
    slots = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      contextEngine = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Selects the active context engine plugin by id so one plugin provides context orchestration behavior.";
      };
      memory = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Select the active memory plugin by id, or \"none\" to disable memory plugins.";
      };
    }; });
      default = null;
      description = "Selects which plugins own exclusive runtime slots such as memory so only one plugin provides that capability. Use explicit slot ownership to avoid overlapping providers with conflicting behavior.";
    };
  }; });
    default = null;
    description = "Plugin system controls for enabling extensions, constraining load scope, configuring entries, and tracking installs. Keep plugin policy explicit and least-privilege in production environments.";
  };

  proxy = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Explicit managed-proxy override. URL presence enables routing by default; set false to ignore configured or environment proxy URLs without deleting them.";
    };
    loopbackMode = lib.mkOption {
      type = t.nullOr (t.enum [ "gateway-only" "proxy" "block" ]);
      default = null;
      description = "Controls Gateway loopback control-plane routing while managed proxy mode is active: \"gateway-only\", \"proxy\", or \"block\".";
    };
    proxyUrl = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Managed forward proxy URL. Use http:// for a plain CONNECT proxy or https:// when the connection to the proxy endpoint itself must use TLS.";
    };
    tls = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      caFile = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Filesystem path to a custom CA bundle used to verify an HTTPS managed proxy endpoint certificate.";
      };
    }; });
      default = null;
      description = "TLS settings used when connecting to the managed proxy endpoint. These settings apply to proxy TLS, not destination TLS after CONNECT.";
    };
  }; });
    default = null;
    description = "Operator-managed forward proxy routing for OpenClaw runtime HTTP, HTTPS, WebSocket, and supported raw-egress paths. Use this when central egress control is part of the deployment boundary.";
  };

  secrets = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    defaults = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      env = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      exec = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      file = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      store = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
    }; });
      default = null;
    };
    egressProxy = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      bypassHosts = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Exact hostnames that use authenticated blind CONNECT tunnels for certificate-pinned clients. Sentinels remain ciphertext and will fail vendor authentication instead of exposing plaintext.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables secret egress substitution for Gateway-hosted agent subprocesses. Default: false.";
      };
    }; });
      default = null;
      description = "Gateway-owned loopback proxy that replaces shared-store secret sentinels only at outbound request time. Restart the Gateway after changing this startup-scoped section.";
    };
    providers = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      source = lib.mkOption {
        type = t.enum [ "env" "file" "exec" "store" ];
      };
      allowlist = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      args = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      command = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      env = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.str));
        default = null;
      };
      jsonOnly = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      maxBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      maxOutputBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "singleValue" ]) (t.enum [ "json" ]) ]);
        default = null;
      };
      noOutputTimeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      passEnv = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      path = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      pluginIntegration = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        integrationId = lib.mkOption {
          type = t.str;
        };
        pluginId = lib.mkOption {
          type = t.str;
        };
      }; });
        default = null;
      };
      timeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      trustedDirs = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
    }; }));
      default = null;
    };
  }; });
    default = null;
    description = "Secret reference providers, shared-store behavior, and optional subprocess egress protection.";
  };

  security = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    audit = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      suppressions = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        checkId = lib.mkOption {
          type = t.str;
        };
        detailIncludes = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        reason = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        titleIncludes = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
      }; }));
        default = null;
      };
    }; });
      default = null;
    };
    installPolicy = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      exec = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        args = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        command = lib.mkOption {
          type = t.str;
        };
        env = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        maxOutputBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        noOutputTimeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        passEnv = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        source = lib.mkOption {
          type = t.enum [ "exec" ];
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        trustedDirs = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
      }; });
        default = null;
      };
      targets = lib.mkOption {
        type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "skill" ]) (t.enum [ "plugin" ]) ]));
        default = null;
      };
    }; });
      default = null;
    };
  }; });
    default = null;
  };

  session = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    dmScope = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "main" ]) (t.enum [ "per-peer" ]) (t.enum [ "per-channel-peer" ]) (t.enum [ "per-account-channel-peer" ]) ]);
      default = null;
      description = "DM session scoping: \"main\" keeps continuity, while \"per-peer\", \"per-channel-peer\", and \"per-account-channel-peer\" increase isolation. Use isolated modes for shared inboxes or multi-account deployments.";
    };
    identityLinks = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.listOf (t.str)));
      default = null;
      description = "Maps canonical identities to provider-prefixed peer IDs so equivalent users resolve to one DM thread (example: telegram:123456). Use this when the same human appears across multiple channels or accounts.";
    };
    mainKey = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Overrides the canonical main session key used for continuity when dmScope or routing logic points to \"main\". Use a stable value only if you intentionally need custom session anchoring.";
    };
    maintenance = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      highWaterBytes = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
        default = null;
        description = "Target size after disk-budget cleanup (high-water mark). Defaults to 80% of maxDiskBytes; set explicitly for tighter reclaim behavior on constrained disks. A value that resolves to zero falls back to the default; negative values are invalid. Disable the budget with maxDiskBytes instead.";
      };
      maxDiskBytes = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.number) (t.enum [ false ]) ]);
        default = null;
        description = "Per-agent sessions-directory disk budget (for example `500mb`). Defaults to `10gb`; when exceeded, warn mode reports pressure and enforce mode performs oldest-first cleanup (archived transcripts before live sessions). Set `false`, `0`, or `\"0\"` to disable.";
      };
      maxEntries = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Caps total session entry count retained in the store to prevent unbounded growth over time. Protected entries count toward the limit but are never automatically removed, so the store can remain above the cap when protection alone exceeds it. Use lower limits for constrained environments, or higher limits when longer history is required.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "enforce" "warn" ]);
        default = null;
        description = "Determines whether maintenance policies are only reported (\"warn\") or actively applied (\"enforce\"). Keep \"warn\" during rollout and switch to \"enforce\" after validating safe thresholds.";
      };
      pruneAfter = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.number) ]);
        default = null;
        description = "Removes entries older than this duration (for example `30d` or `12h`) during maintenance passes. Use this as the primary age-retention control and align it with data retention policy.";
      };
      resetArchiveRetention = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.oneOf [ (t.str) (t.number) ]) (t.enum [ false ]) ]);
        default = null;
        description = "Age-based retention for archived transcripts (`*.reset.<timestamp>` and `*.deleted.<timestamp>`). Defaults to keeping archives until the disk budget evicts them oldest-first; set a duration (for example `30d`) to opt into wall-clock deletion, or `false` to disable it explicitly.";
      };
    }; });
      default = null;
      description = "Automatic session-store maintenance controls for pruning age, entry caps, reset archive retention, and disk budget cleanup. Start in warn mode to observe impact, then enforce once thresholds are tuned.";
    };
    reset = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      atHour = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Sets local-hour boundary (0-23) for daily reset mode so sessions roll over at predictable times. Use with mode=daily and align to operator timezone expectations for human-readable behavior.";
      };
      idleMinutes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Sets inactivity window before reset for idle mode and can also act as secondary guard with daily mode. Use larger values to preserve continuity or smaller values for fresher short-lived threads.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "daily" ]) (t.enum [ "idle" ]) ]);
        default = null;
        description = "Selects reset strategy: \"none\" disables automatic reset (the default), \"daily\" resets at a configured hour, and \"idle\" resets after inactivity. /new and /reset remain available in every mode.";
      };
    }; });
      default = null;
      description = "Defines the default reset policy object used when no type-specific or channel-specific override applies. By default sessions do not reset automatically; use daily or idle schedules to opt in, while /new and /reset remain available at any time.";
    };
    resetByChannel = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      atHour = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      idleMinutes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      mode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "daily" ]) (t.enum [ "idle" ]) ]);
        default = null;
      };
    }; }));
      default = null;
      description = "Provides channel-specific reset overrides keyed by provider/channel id for fine-grained behavior control. Use this only when one channel needs exceptional reset behavior beyond type-level policies.";
    };
    resetByType = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      direct = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        atHour = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        idleMinutes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "daily" ]) (t.enum [ "idle" ]) ]);
          default = null;
        };
      }; });
        default = null;
        description = "Defines reset policy for direct chats and supersedes the base session.reset configuration for that type. Use this as the canonical direct-message override instead of the legacy dm alias.";
      };
      group = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        atHour = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        idleMinutes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "daily" ]) (t.enum [ "idle" ]) ]);
          default = null;
        };
      }; });
        default = null;
        description = "Defines reset policy for group chat sessions where continuity and noise patterns differ from DMs. Use shorter idle windows for busy groups if context drift becomes a problem.";
      };
      thread = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        atHour = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        idleMinutes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "none" ]) (t.enum [ "daily" ]) (t.enum [ "idle" ]) ]);
          default = null;
        };
      }; });
        default = null;
        description = "Defines reset policy for thread-scoped sessions, including focused channel thread workflows. Use this when thread sessions should expire faster or slower than other chat types.";
      };
    }; });
      default = null;
      description = "Overrides reset behavior by chat type (direct, group, thread) when defaults are not sufficient. Use this when group/thread traffic needs different reset cadence than direct messages.";
    };
    resetTriggers = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Lists message triggers that force a session reset when matched in inbound content. Use sparingly for explicit reset phrases so context is not dropped unexpectedly during normal conversation.";
    };
    scope = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "per-sender" ]) (t.enum [ "global" ]) ]);
      default = null;
      description = "Sets base session grouping strategy: \"per-sender\" isolates by sender and \"global\" shares one session per channel context. Keep \"per-sender\" for safer multi-user behavior unless deliberate shared context is required.";
    };
    sendPolicy = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      default = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
        default = null;
        description = "Sets fallback action when no sendPolicy rule matches: \"allow\" or \"deny\". Keep \"allow\" for simpler setups, or choose \"deny\" when you require explicit allow rules for every destination.";
      };
      rules = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        action = lib.mkOption {
          type = t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ];
          description = "Defines rule decision as \"allow\" or \"deny\" when the corresponding match criteria are satisfied. Use deny-first ordering when enforcing strict boundaries with explicit allow exceptions.";
        };
        match = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          channel = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Matches rule application to a specific channel/provider id (for example discord, telegram, slack). Use this when one channel should permit or deny delivery independently of others.";
          };
          chatType = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "direct" ]) (t.enum [ "group" ]) (t.enum [ "channel" ]) ]);
            default = null;
            description = "Matches rule application to chat type (direct, group, thread) so behavior varies by conversation form. Use this when DM and group destinations require different safety boundaries.";
          };
          keyPrefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Matches a normalized session-key prefix after internal key normalization steps in policy consumers. Use this for general prefix controls, and prefer rawKeyPrefix when exact full-key matching is required.";
          };
          rawKeyPrefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Matches the raw, unnormalized session-key prefix for exact full-key policy targeting. Use this when normalized keyPrefix is too broad and you need agent-prefixed or transport-specific precision.";
          };
        }; });
          default = null;
          description = "Defines optional rule match conditions that can combine channel, chatType, and key-prefix constraints. Keep matches narrow so policy intent stays readable and debugging remains straightforward.";
        };
      }; }));
        default = null;
        description = "Ordered allow/deny rules evaluated before the default action, for example `{ action: \"deny\", match: { channel: \"discord\" } }`. Put most specific rules first so broad rules do not shadow exceptions.";
      };
    }; });
      default = null;
      description = "Controls cross-session send permissions using allow/deny rules evaluated against channel, chatType, and key prefixes. Use this to fence where session tools can deliver messages in complex environments.";
    };
    sharing = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      drafts = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows draft visibility, which hides sessions from non-owner, non-admin operators. Default: true.";
      };
      readOnly = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows sessions to be made read-only for non-participants. Default: true.";
      };
      suggest = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows suggest visibility. In this phase it enforces the same admission policy as read-only; suggestion queues are configured by a later feature. Default: true.";
      };
    }; });
      default = null;
      description = "Controls which collaboration modes session owners and administrators may select. Omitted booleans default to enabled; set a mode false to remove it from the picker and reject new selections.";
    };
    store = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Sets the session storage file path used to persist session records across restarts. Use an explicit path only when you need custom disk layout, backup routing, or mounted-volume storage.";
    };
    threadBindings = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      defaultSpawnContext = lib.mkOption {
        type = t.nullOr (t.enum [ "isolated" "fork" ]);
        default = null;
        description = "Default native subagent context for thread-bound spawns. Use \"fork\" to start from the requester transcript or \"isolated\" for a clean child. Default: \"fork\".";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Global master switch for thread-bound session routing features and focused thread delivery behavior. Keep enabled for modern thread workflows unless you need to disable thread binding globally.";
      };
      idleHours = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
        description = "Default inactivity window in hours for thread-bound sessions across providers/channels (0 disables idle auto-unfocus). Default: 24.";
      };
      maxAgeHours = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
        description = "Optional hard max age in hours for thread-bound sessions across providers/channels (0 disables hard cap). Default: 0.";
      };
      spawnSessions = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Global default gate for creating thread-bound work sessions from sessions_spawn and ACP thread spawns. Default: true when thread bindings are enabled.";
      };
    }; });
      default = null;
      description = "Shared defaults for thread-bound session routing behavior across providers that support thread focus workflows. Configure global defaults here and override per channel only when behavior differs.";
    };
  }; });
    default = null;
    description = "Global session routing, reset, delivery policy, and maintenance controls for conversation history behavior. Keep defaults unless you need stricter isolation, retention, or delivery constraints.";
  };

  skills = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    allowBundled = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
    };
    entries = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      apiKey = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
      };
      config = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.anything));
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      env = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.str));
        default = null;
      };
    }; }));
      default = null;
    };
    install = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowUploadedArchives = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      nodeManager = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "npm" ]) (t.enum [ "pnpm" ]) (t.enum [ "yarn" ]) (t.enum [ "bun" ]) ]);
        default = null;
      };
      preferBrew = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
    }; });
      default = null;
    };
    limits = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      maxCandidatesPerRoot = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      maxSkillFileBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      maxSkillsInPrompt = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      maxSkillsLoadedPerSource = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      maxSkillsPromptChars = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
    };
    load = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowSymlinkTargets = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Trusted real target roots that skill symlinks may resolve into when they sit outside their configured source root. Keep this narrow, such as a sibling repo skills directory.";
      };
      extraDirs = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Additional shared skill roots to scan at lowest precedence. Use this for sibling repos or shared skill packs that should be available without copying them into the OpenClaw workspace.";
      };
      watch = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable filesystem watching for skill-definition changes so updates can be applied without full process restart. Keep enabled in development workflows and disable in immutable production images.";
      };
    }; });
      default = null;
    };
    workshop = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowSymlinkTargetWrites = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Allows Skill Workshop apply to write through symlinked workspace skill paths whose real target is already trusted by skills.load.allowSymlinkTargets. Keep disabled unless operators intentionally want generated proposal applies to mutate those shared skill roots.";
      };
      approvalPolicy = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "pending" ]) (t.enum [ "auto" ]) ]);
        default = null;
      };
      autonomous = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        mode = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "off" ]) (t.enum [ "propose" ]) (t.enum [ "auto" ]) ]);
          default = null;
          description = "Controls background learning: \"off\" keeps only the suggestion nudge, \"propose\" creates pending proposals, and \"auto\" applies captured proposals and runs daily scanner-gated cleanup that can rewrite or drop eligible writable skills. Default: \"auto\".";
        };
      }; });
        default = null;
      };
      maxPending = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      maxSkillBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
    };
  }; });
    default = null;
  };

  surfaces = lib.mkOption {
    type = t.nullOr (t.attrsOf (t.submodule { options = {
    silentReply = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      group = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "disallow" ]) ]);
        default = null;
      };
      internal = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "disallow" ]) ]);
        default = null;
      };
    }; });
      default = null;
      description = "Overrides silent-reply policy for one resolved delivery surface. Unset fields inherit agents.defaults.silentReply; use narrow surface ids so internal or group-specific behavior does not spill into other destinations.";
    };
  }; }));
    default = null;
    description = "Per-surface message policy overrides keyed by the resolved delivery surface id. Use this only when one deployed surface needs stricter silent-reply handling than the agent default.";
  };

  talk = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    agentId = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Agent that owns Talk sessions created without an explicit agent-scoped session key.";
    };
    consultFastMode = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Use this to set true or false fast mode for the regular agent run behind Talk realtime consults.";
    };
    consultThinkingLevel = lib.mkOption {
      type = t.nullOr (t.enum [ "off" "minimal" "low" "medium" "high" "xhigh" "adaptive" "max" "ultra" ]);
      default = null;
      description = "Use this to override the thinking level for the regular agent run behind Talk realtime consults.";
    };
    interruptOnSpeech = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "If true (default), stop assistant speech when the user starts speaking in Talk mode. Keep enabled for conversational turn-taking.";
    };
    provider = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Active Talk provider id (for example \"acme-speech\").";
    };
    providers = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      apiKey = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Provider API key for Talk mode.";
      };
    }; }));
      default = null;
      description = "Provider-specific Talk settings keyed by provider id. During migration, prefer this over legacy talk.* keys.";
    };
    realtime = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      brain = lib.mkOption {
        type = t.nullOr (t.enum [ "agent-consult" "direct-tools" "none" ]);
        default = null;
        description = "Talk reasoning strategy: agent-consult for Gateway-mediated agent help, direct-tools for local tool calls, or none.";
      };
      consultRouting = lib.mkOption {
        type = t.nullOr (t.enum [ "provider-direct" "force-agent-consult" ]);
        default = null;
        description = "Gateway relay fallback for final user transcripts when the realtime provider skips openclaw_agent_consult. provider-direct preserves provider replies; force-agent-consult routes through OpenClaw.";
      };
      instructions = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Additional system instructions appended to OpenClaw's built-in realtime Talk prompt. Use this for voice style, tone, and other provider-facing realtime behavior while keeping agent-consult guidance intact.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "realtime" "stt-tts" "transcription" ]);
        default = null;
        description = "Talk execution mode: realtime, stt-tts, or transcription.";
      };
      model = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Realtime provider model id override for browser or Gateway-owned Talk sessions.";
      };
      prefixPaddingMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Milliseconds of audio retained before realtime voice activity is detected.";
      };
      provider = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Active realtime voice provider id, such as openai or google.";
      };
      providers = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        apiKey = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "file" "exec" "store" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
          description = "Provider API key for realtime Talk.";
        };
      }; }));
        default = null;
        description = "Provider-specific realtime voice settings keyed by provider id.";
      };
      reasoningEffort = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Provider-specific reasoning effort for realtime Talk sessions, such as minimal, low, medium, or high.";
      };
      silenceDurationMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Milliseconds of silence before a realtime Talk user turn is committed.";
      };
      speakerVoice = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Realtime provider speaker voice name override for browser or Gateway-owned Talk sessions.";
      };
      speakerVoiceId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Realtime provider speaker voice id override for browser or Gateway-owned Talk sessions.";
      };
      transport = lib.mkOption {
        type = t.nullOr (t.enum [ "webrtc" "provider-websocket" "gateway-relay" "managed-room" ]);
        default = null;
        description = "Talk byte/session transport: webrtc, provider-websocket, gateway-relay, or managed-room.";
      };
      vadThreshold = lib.mkOption {
        type = t.nullOr (t.number);
        default = null;
        description = "Realtime voice activity detection threshold from 0 (most sensitive) to 1 (least sensitive).";
      };
    }; });
      default = null;
      description = "Realtime Talk provider, model, voice, mode, transport, and brain strategy. Keep speech/TTS provider config in talk.provider and talk.providers.";
    };
    silenceTimeoutMs = lib.mkOption {
      type = t.nullOr (t.int);
      default = null;
      description = "Milliseconds of user silence before Talk mode finalizes and sends the current transcript. Leave unset to keep the platform default pause window (700 ms on macOS and Android, 900 ms on iOS).";
    };
    speechLocale = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "BCP 47 locale id for Talk speech recognition on device nodes and the iOS system-voice fallback, for example \"ru-RU\". Leave unset to use each device default.";
    };
  }; });
    default = null;
    description = "Talk-mode voice synthesis settings for voice identity, model selection, output format, and interruption behavior. Use this section to tune human-facing voice UX while controlling latency and cost.";
  };

  tools = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    agentToAgent = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allow = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Allowlist of target agent IDs permitted for agent_to_agent calls when orchestration is enabled. Use explicit allowlists to avoid uncontrolled cross-agent call graphs.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables the agent_to_agent tool surface so one agent can invoke another agent at runtime. Keep off in simple deployments and enable only when orchestration value outweighs complexity.";
      };
    }; });
      default = null;
      description = "Policy for allowing agent-to-agent tool calls and constraining which target agents can be reached. Keep disabled or tightly scoped unless cross-agent orchestration is intentionally enabled.";
    };
    allow = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Absolute tool allowlist that replaces profile-derived defaults for strict environments. Use this only when you intentionally run a tightly curated subset of tool capabilities.";
    };
    alsoAllow = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Extra tool allowlist entries merged on top of the selected tool profile and default policy. Keep this list small and explicit so audits can quickly identify intentional policy exceptions.";
    };
    byProvider = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      allow = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      alsoAllow = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      deny = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      profile = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "minimal" ]) (t.enum [ "coding" ]) (t.enum [ "messaging" ]) (t.enum [ "full" ]) ]);
        default = null;
      };
    }; }));
      default = null;
      description = "Per-provider tool allow/deny overrides keyed by channel/provider ID to tailor capabilities by surface. Use this when one provider needs stricter controls than global tool policy.";
    };
    codeMode = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.bool) (t.enum [ "auto" ]) ]);
        default = null;
        description = "Enables generic code mode. Default is `\"auto\"`, which engages only models whose catalog flags `compat.codeMode: \"preferred\"`. `true` engages every tool-capable run and fails closed if the runtime is unavailable instead of exposing the full tool list. `false` turns code mode off for every run.";
      };
      languages = lib.mkOption {
        type = t.nullOr (t.listOf (t.enum [ "javascript" "typescript" ]));
        default = null;
        description = "Accepted source languages for `exec`. Supported values are \"javascript\" and \"typescript\".";
      };
      maxOutputBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum serialized bytes returned through code-mode output.";
      };
      maxPendingToolCalls = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum concurrent nested tool calls a code-mode VM can start before it must resume later.";
      };
      maxSearchLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum number of hidden catalog search results a code-mode program can request.";
      };
      maxSnapshotBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum serialized bytes retained for one suspended QuickJS snapshot.";
      };
      memoryLimitBytes = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "QuickJS heap limit for one code-mode VM.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "only" ]);
        default = null;
        description = "Model-facing surface. Only \"only\" is supported: expose code-mode `exec` and `wait` and hide normal tools.";
      };
      runtime = lib.mkOption {
        type = t.nullOr (t.enum [ "quickjs-wasi" ]);
        default = null;
        description = "Guest JavaScript runtime. Only \"quickjs-wasi\" is supported.";
      };
      searchDefaultLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Default number of hidden catalog search results returned by `tools.search` inside code mode.";
      };
      snapshotTtlSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "How long suspended code-mode snapshots can be resumed with `wait` before they expire.";
      };
      timeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum milliseconds for one code-mode `exec` or `wait` call.";
      };
    }; }) ]);
      default = null;
      description = "Generic OpenClaw code mode. When enabled, agent runs expose only `exec` and `wait` to the model and hide normal tools behind a QuickJS-WASI catalog bridge.";
    };
    deny = lib.mkOption {
      type = t.nullOr (t.listOf (t.str));
      default = null;
      description = "Global tool denylist that blocks listed tools even when profile or provider rules would allow them. Use deny rules for emergency lockouts and long-term defense-in-depth.";
    };
    elevated = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowFrom = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.listOf (t.oneOf [ (t.str) (t.number) ])));
        default = null;
        description = "Sender allow rules for elevated tools, usually keyed by channel/provider identity formats. Use narrow, explicit identities so elevated commands cannot be triggered by unintended users.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables elevated tool execution path when sender and policy checks pass. Keep disabled in public/shared channels and enable only for trusted owner-operated contexts.";
      };
    }; });
      default = null;
      description = "Elevated tool access controls for privileged command surfaces that should only be reachable from trusted senders. Keep disabled unless operator workflows explicitly require elevated actions.";
    };
    exec = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      applyPatch = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowModels = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Optional allowlist of model ids (e.g. \"gpt-5.4\" or \"openai/gpt-5.4\").";
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable or disable apply_patch for OpenAI and OpenAI Codex models when allowed by tool policy (default: true).";
        };
        workspaceOnly = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Restrict apply_patch paths to the workspace directory (default: true). Set false to allow writing outside the workspace (dangerous).";
        };
      }; });
        default = null;
      };
      approvalRunningNoticeMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Delay in milliseconds before showing an in-progress notice after an exec approval is granted. Increase to reduce flicker for fast commands, or lower for quicker operator feedback.";
      };
      ask = lib.mkOption {
        type = t.nullOr (t.enum [ "off" "on-miss" "always" ]);
        default = null;
      };
      backgroundMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      cleanupMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
      commandHighlighting = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Show parser-derived command highlights in exec approval prompts (default: false). Enable this to render highlighted command text without changing exec approval policy.";
      };
      host = lib.mkOption {
        type = t.nullOr (t.enum [ "auto" "sandbox" "gateway" "node" ]);
        default = null;
        description = "Selects execution target strategy for shell commands. Use \"auto\" for runtime-aware behavior (sandbox when available, otherwise gateway), or pin sandbox/gateway/node explicitly when you need a fixed surface.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "deny" "allowlist" "ask" "auto" "full" ]);
        default = null;
        description = "Normalized exec policy selector. Use \"auto\" for classifier-reviewed approval misses, \"ask\" for human-reviewed misses, \"allowlist\" for deterministic safe commands only, or \"full\" for trusted local operation.";
      };
      node = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Node binding configuration for exec tooling when command execution is delegated through connected nodes. Use explicit node binding only when multi-node routing is required.";
      };
      notifyOnExit = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "When true (default), backgrounded exec sessions on exit and node exec lifecycle events enqueue a system event and request a heartbeat.";
      };
      notifyOnExitEmptySuccess = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "When true, successful backgrounded exec exits with empty output still enqueue a completion system event (default: false).";
      };
      pathPrepend = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Directories to prepend to PATH for exec runs (gateway/sandbox).";
      };
      reviewer = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        model = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          fallbacks = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
          };
          primary = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
          };
        }; }) ]);
          default = null;
          description = "Optional provider/model override for the exec reviewer agent. Omit to reuse the configured primary model for the target agent.";
        };
        timeoutMs = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Per-stage exec reviewer timeout in milliseconds for model preparation and completion before falling back to human approval (default: 30000).";
        };
      }; });
        default = null;
        description = "Model-backed exec reviewer used by auto mode before human approval fallback. Configure a narrow model override here when you want exec review isolated from the main agent model.";
      };
      safeBinProfiles = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        allowedValueFlags = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        deniedFlags = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        maxPositional = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        minPositional = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
      }; }));
        default = null;
        description = "Optional per-binary safe-bin profiles (positional limits + allowed/denied flags).";
      };
      safeBinTrustedDirs = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Additional explicit directories trusted for safe-bin path checks (PATH entries are never auto-trusted).";
      };
      safeBins = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
        description = "Allow stdin-only safe binaries to run without explicit allowlist entries.";
      };
      security = lib.mkOption {
        type = t.nullOr (t.enum [ "deny" "allowlist" "full" ]);
        default = null;
      };
      strictInlineEval = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Require explicit approval for interpreter inline-eval forms such as `python -c`, `node -e`, `ruby -e`, or `osascript -e`. Prevents silent allowlist reuse and downgrades allow-always to ask-each-time for those forms.";
      };
      timeoutSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
      };
    }; });
      default = null;
      description = "Exec-tool policy grouping for shell execution host, security mode, approval behavior, and runtime bindings. Keep conservative defaults in production and tighten elevated execution paths.";
    };
    fs = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      workspaceOnly = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Restrict filesystem tools (read/write/edit/apply_patch) to the workspace directory (default: false).";
      };
    }; });
      default = null;
    };
    links = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable automatic link understanding pre-processing so URLs can be summarized before agent reasoning. Keep enabled for richer context, and disable when strict minimal processing is required.";
      };
      maxLinks = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum number of links expanded per turn during link understanding. Use lower values to control latency/cost in chatty threads and higher values when multi-link context is critical.";
      };
      models = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        args = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        command = lib.mkOption {
          type = t.str;
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        type = lib.mkOption {
          type = t.nullOr (t.enum [ "cli" ]);
          default = null;
        };
      }; }));
        default = null;
        description = "Preferred model list for link understanding tasks, evaluated in order as fallbacks when supported. Use lightweight models first for routine summarization and heavier models only when needed.";
      };
      scope = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        default = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
          default = null;
        };
        rules = lib.mkOption {
          type = t.nullOr (t.listOf (t.submodule { options = {
          action = lib.mkOption {
            type = t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ];
          };
          match = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            channel = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            chatType = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.enum [ "direct" ]) (t.enum [ "group" ]) (t.enum [ "channel" ]) ]);
              default = null;
            };
            keyPrefix = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            rawKeyPrefix = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; });
            default = null;
          };
        }; }));
          default = null;
        };
      }; });
        default = null;
        description = "Controls when link understanding runs relative to conversation context and message type. Keep scope conservative to avoid unnecessary fetches on messages where links are not actionable.";
      };
      timeoutSeconds = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Per-link understanding timeout budget in seconds before unresolved links are skipped. Keep this bounded to avoid long stalls when external sites are slow or unreachable.";
      };
    }; });
      default = null;
    };
    loopDetection = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable repetitive tool-call loop detection and backoff safety checks (default: false).";
      };
    }; });
      default = null;
    };
    media = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      audio = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        attachments = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          maxAttachments = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "first" ]) (t.enum [ "all" ]) ]);
            default = null;
          };
          prefer = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "first" ]) (t.enum [ "last" ]) (t.enum [ "path" ]) (t.enum [ "url" ]) ]);
            default = null;
          };
        }; });
          default = null;
          description = "Choose which matching audio attachments are processed. Use first-only handling unless multi-attachment transcription is intentional.";
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        echoFormat = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Format the echoed transcript with a {transcript} placeholder. Keep the placeholder intact so delivery includes the transcript.";
        };
        echoTranscript = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Echo the audio transcript to the originating chat before agent processing. Enable this when users need to verify what the system heard.";
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable audio understanding so voice notes or audio clips can be transcribed for agent context.";
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        language = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Default language hint for audio transcription providers. Set it when the primary spoken language is known and provider detection is unreliable.";
        };
        maxBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default audio input size limit for configured and auto-detected models. Set this to the largest recording your providers and network should accept.";
        };
        maxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default maximum transcript length for configured and auto-detected models. Use a lower value to keep long voice notes from expanding agent context.";
        };
        preferredModel = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Prefer one capability-tagged tools.media.models entry for audio transcription before the remaining compatible fallbacks.";
        };
        prompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Default audio transcription prompt when a model entry does not override it. Keep the instruction stable when downstream workflows rely on transcript style.";
        };
        providerOptions = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ])));
          default = null;
        };
        request = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          auth = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "provider-default" ];
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "authorization-bearer" ];
            };
            token = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) (t.submodule { options = {
            headerName = lib.mkOption {
              type = t.str;
            };
            mode = lib.mkOption {
              type = t.enum [ "header" ];
            };
            prefix = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            value = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) ]);
            default = null;
          };
          headers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]));
            default = null;
          };
          proxy = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "env-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "explicit-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
            url = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          tls = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            ca = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            cert = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            insecureSkipVerify = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            key = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            passphrase = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            serverName = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        scope = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          default = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
            default = null;
          };
          rules = lib.mkOption {
            type = t.nullOr (t.listOf (t.submodule { options = {
            action = lib.mkOption {
              type = t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ];
            };
            match = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              channel = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              chatType = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "direct" ]) (t.enum [ "group" ]) (t.enum [ "channel" ]) ]);
                default = null;
              };
              keyPrefix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              rawKeyPrefix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; }));
            default = null;
          };
        }; });
          default = null;
          description = "Restrict audio understanding by channel, chat type, or source key. Keep this narrow where automatic transcription is sensitive or expensive.";
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default timeout for audio understanding requests. Increase it for long recordings or slower local transcription models.";
        };
      }; });
        default = null;
      };
      concurrency = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum number of concurrent media understanding operations per turn across image, audio, and video tasks. Lower this in resource-constrained deployments to prevent CPU/network saturation.";
      };
      image = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        attachments = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          maxAttachments = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "first" ]) (t.enum [ "all" ]) ]);
            default = null;
          };
          prefer = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "first" ]) (t.enum [ "last" ]) (t.enum [ "path" ]) (t.enum [ "url" ]) ]);
            default = null;
          };
        }; });
          default = null;
          description = "Choose which matching image attachments are processed. Use first-only handling unless multi-image analysis is intentional.";
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable image understanding so attached or referenced images can be interpreted into textual context. Disable if you need text-only operation or want to avoid image-processing cost.";
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        language = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        maxBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default image input size limit for configured and auto-detected models. Set this to match provider payload limits and deployment bandwidth.";
        };
        maxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default maximum image description length. Use a lower value for compact context or a higher value for detailed OCR and scene analysis.";
        };
        preferredModel = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Prefer one capability-tagged tools.media.models entry for image understanding before the remaining compatible fallbacks.";
        };
        prompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Default image-understanding prompt when an entry does not override it. Keep this deterministic when consumers rely on stable descriptions.";
        };
        providerOptions = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ])));
          default = null;
        };
        request = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          auth = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "provider-default" ];
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "authorization-bearer" ];
            };
            token = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) (t.submodule { options = {
            headerName = lib.mkOption {
              type = t.str;
            };
            mode = lib.mkOption {
              type = t.enum [ "header" ];
            };
            prefix = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            value = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) ]);
            default = null;
          };
          headers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]));
            default = null;
          };
          proxy = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "env-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "explicit-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
            url = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          tls = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            ca = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            cert = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            insecureSkipVerify = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            key = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            passphrase = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            serverName = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        scope = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          default = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
            default = null;
          };
          rules = lib.mkOption {
            type = t.nullOr (t.listOf (t.submodule { options = {
            action = lib.mkOption {
              type = t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ];
            };
            match = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              channel = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              chatType = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "direct" ]) (t.enum [ "group" ]) (t.enum [ "channel" ]) ]);
                default = null;
              };
              keyPrefix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              rawKeyPrefix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; }));
            default = null;
          };
        }; });
          default = null;
          description = "Restrict image understanding by channel, chat type, or source key. Keep this narrow in busy or untrusted channels to control processing.";
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default timeout for image-understanding requests. Increase it for large images or slower local vision models.";
        };
      }; });
        default = null;
      };
      models = lib.mkOption {
        type = t.nullOr (t.listOf (t.submodule { options = {
        args = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        capabilities = lib.mkOption {
          type = t.nullOr (t.listOf (t.oneOf [ (t.enum [ "image" ]) (t.enum [ "audio" ]) (t.enum [ "video" ]) ]));
          default = null;
        };
        command = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        language = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        maxBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        maxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        model = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        preferredProfile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        profile = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        prompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        provider = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        providerOptions = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ])));
          default = null;
        };
        request = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          auth = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "provider-default" ];
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "authorization-bearer" ];
            };
            token = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) (t.submodule { options = {
            headerName = lib.mkOption {
              type = t.str;
            };
            mode = lib.mkOption {
              type = t.enum [ "header" ];
            };
            prefix = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            value = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) ]);
            default = null;
          };
          headers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]));
            default = null;
          };
          proxy = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "env-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "explicit-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
            url = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          tls = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            ca = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            cert = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            insecureSkipVerify = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            key = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            passphrase = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            serverName = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
        };
        type = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.enum [ "provider" ]) (t.enum [ "cli" ]) ]);
          default = null;
        };
      }; }));
        default = null;
        description = "Canonical media-understanding model list. Use image, audio, or video capability tags on every entry so each pipeline selects only compatible fallbacks.";
      };
      video = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        attachments = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          maxAttachments = lib.mkOption {
            type = t.nullOr (t.int);
            default = null;
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "first" ]) (t.enum [ "all" ]) ]);
            default = null;
          };
          prefer = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "first" ]) (t.enum [ "last" ]) (t.enum [ "path" ]) (t.enum [ "url" ]) ]);
            default = null;
          };
        }; });
          default = null;
          description = "Choose which matching video attachments are processed. Use first-only handling unless multi-video analysis is intentional.";
        };
        baseUrl = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable video understanding so clips can be summarized into text for downstream reasoning and responses. Disable when processing video is out of policy or too expensive for your deployment.";
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
        };
        language = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
        };
        maxBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default video input size limit for configured and auto-detected models. Set this to match provider payload limits and deployment bandwidth.";
        };
        maxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default maximum video description length. Use a lower value for compact context or a higher value for detailed scene summaries.";
        };
        preferredModel = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Prefer one capability-tagged tools.media.models entry for video understanding before the remaining compatible fallbacks.";
        };
        prompt = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Default video-understanding prompt when an entry does not override it. Keep this deterministic when consumers rely on stable summaries.";
        };
        providerOptions = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.attrsOf (t.oneOf [ (t.str) (t.number) (t.bool) ])));
          default = null;
        };
        request = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          auth = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "provider-default" ];
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "authorization-bearer" ];
            };
            token = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) (t.submodule { options = {
            headerName = lib.mkOption {
              type = t.str;
            };
            mode = lib.mkOption {
              type = t.enum [ "header" ];
            };
            prefix = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
            value = lib.mkOption {
              type = t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ];
            };
          }; }) ]);
            default = null;
          };
          headers = lib.mkOption {
            type = t.nullOr (t.attrsOf (t.oneOf [ (t.str) (t.submodule { options = {
            source = lib.mkOption {
              type = t.enum [ "env" "file" "exec" "store" ];
            };
            id = lib.mkOption {
              type = t.str;
            };
            provider = lib.mkOption {
              type = t.str;
            };
          }; }) ]));
            default = null;
          };
          proxy = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "env-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; }) (t.submodule { options = {
            mode = lib.mkOption {
              type = t.enum [ "explicit-proxy" ];
            };
            tls = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              ca = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              cert = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              insecureSkipVerify = lib.mkOption {
                type = t.nullOr (t.bool);
                default = null;
              };
              key = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              passphrase = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
                source = lib.mkOption {
                  type = t.enum [ "env" "file" "exec" "store" ];
                };
                id = lib.mkOption {
                  type = t.str;
                };
                provider = lib.mkOption {
                  type = t.str;
                };
              }; }) ]);
                default = null;
              };
              serverName = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
            url = lib.mkOption {
              type = t.str;
            };
          }; }) ]);
            default = null;
          };
          tls = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            ca = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            cert = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            insecureSkipVerify = lib.mkOption {
              type = t.nullOr (t.bool);
              default = null;
            };
            key = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            passphrase = lib.mkOption {
              type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
              source = lib.mkOption {
                type = t.enum [ "env" "file" "exec" "store" ];
              };
              id = lib.mkOption {
                type = t.str;
              };
              provider = lib.mkOption {
                type = t.str;
              };
            }; }) ]);
              default = null;
            };
            serverName = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        scope = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          default = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ]);
            default = null;
          };
          rules = lib.mkOption {
            type = t.nullOr (t.listOf (t.submodule { options = {
            action = lib.mkOption {
              type = t.oneOf [ (t.enum [ "allow" ]) (t.enum [ "deny" ]) ];
            };
            match = lib.mkOption {
              type = t.nullOr (t.submodule { options = {
              channel = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              chatType = lib.mkOption {
                type = t.nullOr (t.oneOf [ (t.enum [ "direct" ]) (t.enum [ "group" ]) (t.enum [ "channel" ]) ]);
                default = null;
              };
              keyPrefix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
              rawKeyPrefix = lib.mkOption {
                type = t.nullOr (t.str);
                default = null;
              };
            }; });
              default = null;
            };
          }; }));
            default = null;
          };
        }; });
          default = null;
          description = "Restrict video understanding by channel, chat type, or source key. Keep this narrow in busy or untrusted channels to control processing.";
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Default timeout for video-understanding requests. Increase it for longer clips or slower local analysis models.";
        };
      }; });
        default = null;
      };
    }; });
      default = null;
    };
    message = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      actions = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
          description = "Global message action allowlist for the message tool. Use only when the whole runtime should expose and accept a reduced action set; prefer per-agent allowlists for public or sandboxed agents.";
        };
      }; });
        default = null;
      };
      broadcast = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable broadcast action (default: true).";
        };
      }; });
        default = null;
      };
      crossContext = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allowAcrossProviders = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Allow sends across different providers (default: false).";
        };
        allowWithinProvider = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Allow sends to other channels within the same provider (default: true).";
        };
        marker = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Add a visible origin marker when sending cross-context (default: true).";
          };
          prefix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Text prefix for cross-context markers (supports \"{channel}\").";
          };
          suffix = lib.mkOption {
            type = t.nullOr (t.str);
            default = null;
            description = "Text suffix for cross-context markers (supports \"{channel}\").";
          };
        }; });
          default = null;
        };
      }; });
        default = null;
      };
    }; });
      default = null;
    };
    profile = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "minimal" ]) (t.enum [ "coding" ]) (t.enum [ "messaging" ]) (t.enum [ "full" ]) ]);
      default = null;
      description = "Global tool profile name used to select a predefined tool policy baseline before applying allow/deny overrides. Use this for consistent environment posture across agents and keep profile names stable.";
    };
    sandbox = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      tools = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        alsoAllow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        deny = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
      }; });
        default = null;
        description = "Allow/deny tool policy applied when agents run in sandboxed execution environments. Keep policies minimal so sandbox tasks cannot escalate into unnecessary external actions.";
      };
    }; });
      default = null;
      description = "Tool policy wrapper for sandboxed agent executions so sandbox runs can have distinct capability boundaries. Use this to enforce stronger safety in sandbox contexts.";
    };
    sessions = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      visibility = lib.mkOption {
        type = t.nullOr (t.enum [ "self" "tree" "agent" "all" ]);
        default = null;
        description = "Controls which sessions can be targeted by sessions_list/sessions_history/sessions_search/sessions_send. (\"tree\" default = current session + spawned subagent sessions; \"self\" = only current; \"agent\" = any session in the current agent id; \"all\" = any session; cross-agent still requires tools.agentToAgent).";
      };
    }; });
      default = null;
    };
    sessions_spawn = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      attachments = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
        maxFileBytes = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        maxFiles = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        maxTotalBytes = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
        };
        retainOnSessionKeep = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
        };
      }; });
        default = null;
      };
    }; });
      default = null;
    };
    subagents = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      tools = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        allow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        alsoAllow = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
        deny = lib.mkOption {
          type = t.nullOr (t.listOf (t.str));
          default = null;
        };
      }; });
        default = null;
        description = "Allow/deny tool policy applied to spawned subagent runtimes for per-subagent hardening. Keep this narrower than parent scope when subagents run semi-autonomous workflows.";
      };
    }; });
      default = null;
      description = "Tool policy wrapper for spawned subagents to restrict or expand tool availability compared to parent defaults. Use this to keep delegated agent capabilities scoped to task intent.";
    };
    swarm = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
      defaultAgentId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Default target agent for swarm spawns that omit agentId. The subagent allowlist still applies.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables collector-mode subagents and agents_wait. Default is off.";
      };
      maxChildrenPerGroup = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum live collector children per swarm group.";
      };
      maxConcurrent = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum concurrently running collector children per swarm group.";
      };
      maxTotalPerGroup = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum lifetime collector spawns per swarm group.";
      };
      waitTimeoutSecondsMax = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum timeout accepted by agents_wait, in seconds.";
      };
    }; }) ]);
      default = null;
      description = "Collector-mode subagent orchestration. Default is off; enable it to expose agents_wait and swarm spawn options.";
    };
    toolSearch = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.bool) (t.submodule { options = {
      codeTimeoutMs = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum milliseconds for one `tool_search_code` execution. Runtime clamps values to the supported 1s..60s range.";
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enables Tool Search. When on, OpenClaw hides large tool catalogs behind `tool_search_code` or structured search/describe/call tools during embedded runtime runs.";
      };
      maxSearchLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Maximum number of Tool Search results a model can request. Runtime clamps values to the supported 1..50 range.";
      };
      mode = lib.mkOption {
        type = t.nullOr (t.enum [ "code" "tools" "directory" ]);
        default = null;
        description = "Choose the model-facing surface: \"code\" exposes `tool_search_code`; \"tools\" exposes structured search/describe/call fallback tools; \"directory\" keeps a bounded tool directory visible, exposes a bounded set of likely or required schemas, and defers the rest behind search/describe/call.";
      };
      searchDefaultLimit = lib.mkOption {
        type = t.nullOr (t.int);
        default = null;
        description = "Default number of Tool Search results returned when the model omits a limit. Runtime clamps this to `maxSearchLimit`.";
      };
    }; }) ]);
      default = null;
      description = "Compact large OpenClaw, MCP, and client tool catalogs. Set to true for the default code bridge or use the object form to choose structured controls or a compact visible tool directory.";
    };
    toolsBySender = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      allow = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      alsoAllow = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      deny = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
    }; }));
      default = null;
    };
    updatePlan = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Structured `update_plan` checklist tool for non-trivial multi-step work. Enabled by default; set false to opt out.";
    };
    web = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      fetch = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        cacheTtlMinutes = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
          description = "Cache TTL in minutes for web_fetch results.";
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable the web_fetch tool (lightweight HTTP fetch).";
        };
        headers = lib.mkOption {
          type = t.nullOr (t.attrsOf (t.str));
          default = null;
          description = "Extra request headers sent with direct web_fetch requests, for example gateway routing or authentication headers. Every configured value is treated as sensitive and redacted from exposed config and debug captures. Values are plain strings, support \${VAR} substitution and the global $\${VAR} literal escape, and are sent to model-chosen URLs. Entries are validated when the request is built rather than at config load, so a bad name or unsendable value is dropped and logged instead of disabling the surface; Accept, Accept-Language, User-Agent, and framing headers such as Transfer-Encoding are dropped too. Use tools.web.fetch.userAgent to change the user agent. Cross-origin redirects retain only the guarded-fetch safe header allowlist, and changing the headers actually sent partitions the fetch cache.";
        };
        maxChars = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Max characters returned by web_fetch (truncated).";
        };
        maxCharsCap = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Hard cap for web_fetch maxChars (applies to config and tool calls).";
        };
        maxRedirects = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Maximum redirects allowed for web_fetch (default: 3).";
        };
        maxResponseBytes = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Max download size before truncation.";
        };
        provider = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Web fetch fallback provider id.";
        };
        readability = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Use Readability to extract main content from HTML (fallbacks to basic HTML cleanup).";
        };
        ssrfPolicy = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowIpv6UniqueLocalRange = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Allow IPv6 Unique Local Addresses (fc00::/7) for trusted fake-IP proxy compatibility such as sing-box, Clash, or Surge.";
          };
          allowRfc2544BenchmarkRange = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Allow RFC 2544 benchmark-range IPs (198.18.0.0/15) for fake-IP proxy compatibility such as Clash or Surge.";
          };
          allowedHostnames = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
            description = "Exact hostnames or IP literals allowed for web_fetch, including otherwise blocked targets. Keep the list minimal.";
          };
          dangerouslyAllowPrivateNetwork = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Allows web_fetch access to private and internal network targets. Keep disabled unless model-selected URLs are trusted in this deployment.";
          };
        }; });
          default = null;
          description = "Scoped SSRF policy overrides for web_fetch. Keep this narrow and opt in only for known local-network proxy environments.";
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Timeout in seconds for web_fetch requests.";
        };
        useTrustedEnvProxy = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Route web_fetch through a trusted HTTP(S) env proxy and let the proxy resolve DNS. Enable only when that proxy is operator-controlled and enforces outbound policy after DNS resolution.";
        };
        userAgent = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Override User-Agent header for web_fetch requests.";
        };
      }; });
        default = null;
      };
      search = lib.mkOption {
        type = t.nullOr (t.submodule { options = {
        cacheTtlMinutes = lib.mkOption {
          type = t.nullOr (t.number);
          default = null;
          description = "Cache TTL in minutes for web_search results.";
        };
        enabled = lib.mkOption {
          type = t.nullOr (t.bool);
          default = null;
          description = "Enable managed web_search and optional Codex-native search for eligible models.";
        };
        maxResults = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Number of results to return (1-10).";
        };
        openaiCodex = lib.mkOption {
          type = t.nullOr (t.submodule { options = {
          allowedDomains = lib.mkOption {
            type = t.nullOr (t.listOf (t.str));
            default = null;
            description = "Optional domain allowlist passed to the native Codex web_search tool.";
          };
          contextSize = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "low" ]) (t.enum [ "medium" ]) (t.enum [ "high" ]) ]);
            default = null;
            description = "Native Codex search context size hint: \"low\", \"medium\", or \"high\".";
          };
          enabled = lib.mkOption {
            type = t.nullOr (t.bool);
            default = null;
            description = "Enable native Codex web search for Codex-capable models.";
          };
          mode = lib.mkOption {
            type = t.nullOr (t.oneOf [ (t.enum [ "cached" ]) (t.enum [ "live" ]) ]);
            default = null;
            description = "Native Codex web search preference: \"cached\" (default; unrestricted Codex turns resolve it to live) or \"live\".";
          };
          userLocation = lib.mkOption {
            type = t.nullOr (t.submodule { options = {
            city = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
              description = "Approximate city sent to native Codex web search.";
            };
            country = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
              description = "Approximate country sent to native Codex web search.";
            };
            region = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
              description = "Approximate region/state sent to native Codex web search.";
            };
            timezone = lib.mkOption {
              type = t.nullOr (t.str);
              default = null;
              description = "Approximate timezone sent to native Codex web search.";
            };
          }; });
            default = null;
          };
        }; });
          default = null;
        };
        provider = lib.mkOption {
          type = t.nullOr (t.str);
          default = null;
          description = "Search provider id. Auto-detected from available API keys if omitted.";
        };
        timeoutSeconds = lib.mkOption {
          type = t.nullOr (t.int);
          default = null;
          description = "Timeout in seconds for web_search requests.";
        };
      }; });
        default = null;
      };
    }; });
      default = null;
      description = "Web-tool policy grouping for search/fetch providers, limits, and fallback behavior tuning. Keep enabled settings aligned with API key availability and outbound networking policy.";
    };
  }; });
    default = null;
    description = "Tool infrastructure and cross-agent defaults. Root siblings own infrastructure and cross-agent defaults; agents.defaults owns agent-loop behavior; agent entries may override either where supported.";
  };

  transcripts = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    autoStart = lib.mkOption {
      type = t.nullOr (t.listOf (t.submodule { options = {
      accountId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional provider account or workspace identifier for transcript sources that need account disambiguation. Use the provider's documented account id format.";
      };
      channelId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Provider channel id for the live transcript source, such as a Discord voice channel or Slack huddle channel. Verify provider-specific id semantics before enabling auto-start.";
      };
      guildId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional Discord guild id for Discord voice transcript sources. Configure this with the matching channelId when the provider needs guild-scoped voice channel lookup.";
      };
      meetingUrl = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional meeting URL for providers that join by URL instead of channel id. Use only trusted meeting links because auto-start may join and capture that meeting.";
      };
      providerId = lib.mkOption {
        type = t.str;
        description = "Transcript source provider id, such as a Discord voice or future Slack huddle provider. Use the exact id exposed by the provider plugin.";
      };
      sessionId = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional fixed transcript session id for this auto-start source. Leave unset for generated ids unless you need a stable daily selector and can avoid same-day collisions.";
      };
      title = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Optional human-readable title stored with the transcript session and shown in transcript listings. Use concise meeting names that help operators identify the captured source.";
      };
    }; }));
      default = null;
      description = "Live transcript sources started automatically when the gateway starts. Each entry is enabled by being present; remove an entry to disable that source.";
    };
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Enables durable automatic meeting notes, the transcripts agent tool, and configured auto-start sources. Default: true. Set false to disable persistence and the tool; explicit meeting transcribe mode retains its bounded live tail.";
    };
  }; });
    default = null;
    description = "Core transcript capture settings for meeting notes, recording-capable agent tools, and configured live meeting auto-start sources. Meeting plugins capture durable notes by default; set enabled to false to opt out globally.";
  };

  tts = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    auto = lib.mkOption {
      type = t.nullOr (t.enum [ "off" "always" "inbound" "tagged" ]);
      default = null;
    };
    enabled = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
    };
    maxTextLength = lib.mkOption {
      type = t.nullOr (t.int);
      default = null;
    };
    mode = lib.mkOption {
      type = t.nullOr (t.enum [ "final" "all" ]);
      default = null;
    };
    modelOverrides = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      allowModelId = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowNormalization = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowProvider = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowSeed = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowText = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowVoice = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      allowVoiceSettings = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
    }; });
      default = null;
    };
    persona = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Default TTS persona id. Local TTS persona preferences can override this per host.";
    };
    personas = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      description = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      fallbackPolicy = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "preserve-persona" ]) (t.enum [ "provider-defaults" ]) (t.enum [ "fail" ]) ]);
        default = null;
      };
      label = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      provider = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      providers = lib.mkOption {
        type = t.nullOr (t.attrsOf (t.submodule { options = {
        apiKey = lib.mkOption {
          type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
          source = lib.mkOption {
            type = t.enum [ "env" "file" "exec" "store" ];
          };
          id = lib.mkOption {
            type = t.str;
          };
          provider = lib.mkOption {
            type = t.str;
          };
        }; }) ]);
          default = null;
        };
      }; }));
        default = null;
        description = "Provider-specific TTS persona bindings keyed by speech provider id. These merge over tts.providers for the active persona.";
      };
    }; }));
      default = null;
      description = "Named TTS personas that define stable spoken identity plus provider-specific speech bindings.";
    };
    provider = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
    };
    providers = lib.mkOption {
      type = t.nullOr (t.attrsOf (t.submodule { options = {
      apiKey = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.str) (t.submodule { options = {
        source = lib.mkOption {
          type = t.enum [ "env" "file" "exec" "store" ];
        };
        id = lib.mkOption {
          type = t.str;
        };
        provider = lib.mkOption {
          type = t.str;
        };
      }; }) ]);
        default = null;
        description = "Provider API key used by that speech provider when its plugin requires authenticated TTS access.";
      };
    }; }));
      default = null;
      description = "Provider-specific TTS settings keyed by speech provider id. Use this instead of bundled provider-specific top-level keys so speech plugins stay decoupled from core config schema.";
    };
    summaryModel = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
    };
    timeoutMs = lib.mkOption {
      type = t.nullOr (t.int);
      default = null;
    };
  }; });
    default = null;
    description = "Text-to-speech policy for reading agent replies aloud on supported voice or audio surfaces. Keep disabled unless voice playback is part of your operator/user workflow.";
  };

  ui = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    assistant = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      avatar = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Assistant avatar image source used in UI surfaces (URL, path, or data URI depending on runtime support). Use trusted assets and consistent branding dimensions for clean rendering.";
      };
      name = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
        description = "Display name shown for the assistant in UI views, chat chrome, and status contexts. Keep this stable so operators can reliably identify which assistant persona is active.";
      };
    }; });
      default = null;
      description = "Assistant display identity settings for name and avatar shown in UI surfaces. Keep these values aligned with your operator-facing persona and support expectations.";
    };
    prefs = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      chatFollowUpMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "steer" ]) (t.enum [ "queue" ]) ]);
        default = null;
      };
      chatPersistCommentary = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      chatSendShortcut = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "enter" ]) (t.enum [ "modifier-enter" ]) ]);
        default = null;
      };
      chatShowThinking = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      chatShowToolCalls = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
      };
      locale = lib.mkOption {
        type = t.nullOr (t.str);
        default = null;
      };
      sidebarEntries = lib.mkOption {
        type = t.nullOr (t.listOf (t.str));
        default = null;
      };
      theme = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "claw" ]) (t.enum [ "knot" ]) (t.enum [ "dash" ]) (t.enum [ "custom" ]) ]);
        default = null;
      };
      themeMode = lib.mkOption {
        type = t.nullOr (t.oneOf [ (t.enum [ "light" ]) (t.enum [ "dark" ]) (t.enum [ "system" ]) ]);
        default = null;
      };
    }; });
      default = null;
    };
    seamColor = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Primary accent color used by UI surfaces for emphasis, badges, and visual identity cues. Use high-contrast values that remain readable across light/dark themes.";
    };
  }; });
    default = null;
    description = "UI presentation settings for accenting and assistant identity shown in control surfaces. Use this for branding and readability customization without changing runtime behavior.";
  };

  update = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    auto = lib.mkOption {
      type = t.nullOr (t.submodule { options = {
      enabled = lib.mkOption {
        type = t.nullOr (t.bool);
        default = null;
        description = "Enable background auto-update for stable and beta package installs; extended-stable never auto-applies (default: false).";
      };
    }; });
      default = null;
    };
    channel = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "stable" ]) (t.enum [ "extended-stable" ]) (t.enum [ "beta" ]) (t.enum [ "dev" ]) ]);
      default = null;
      description = "Update channel for git + npm installs (\"stable\", \"extended-stable\", \"beta\", or \"dev\"). Extended-stable is package-only: installation is foreground-only, with optional read-only startup hints.";
    };
    checkOnStart = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Check for npm updates when the gateway starts, including read-only extended-stable hints (default: true).";
    };
  }; });
    default = null;
    description = "Update-channel and startup-check behavior for keeping OpenClaw runtime versions current. Use conservative channels in production and more experimental channels only in controlled environments.";
  };

  wizard = lib.mkOption {
    type = t.nullOr (t.submodule { options = {
    accessMode = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "full" ]) (t.enum [ "guarded" ]) ]);
      default = null;
      description = "Discovery consent for guided setup: \"full\" scans silently while \"guarded\" asks before inspecting local applications.";
    };
    appRecommendations = lib.mkOption {
      type = t.nullOr (t.bool);
      default = null;
      description = "Controls whether guided setup may use installed-application labels to recommend relevant plugins and skills.";
    };
    lastRunAt = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Timestamp of the last successfully committed wizard run.";
    };
    lastRunCommand = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Command that invoked the last wizard run.";
    };
    lastRunCommit = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Source commit used by the last development wizard run.";
    };
    lastRunMode = lib.mkOption {
      type = t.nullOr (t.oneOf [ (t.enum [ "local" ]) (t.enum [ "remote" ]) ]);
      default = null;
      description = "Whether the last wizard run targeted \"local\" or \"remote\" setup.";
    };
    lastRunVersion = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "OpenClaw version used by the last wizard run.";
    };
    localModelLeanAutoModel = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Model reference whose lean-mode setting remains owned by onboarding.";
    };
    securityAcknowledgedAt = lib.mkOption {
      type = t.nullOr (t.str);
      default = null;
      description = "Timestamp of the setup security acknowledgement, committed with the target config.";
    };
  }; });
    default = null;
    description = "User-owned setup preferences. Machine-owned wizard history and acknowledgement state live in the shared state database.";
  };
}
