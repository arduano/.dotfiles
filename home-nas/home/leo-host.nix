{ config, inputs, pkgs, ... }:
let
  # The ordinary NAS Codex uses default OpenAI auth. Select its existing named
  # command-auth provider for this isolated host only; never edit the original
  # or evaluate credential-bearing TOML into the Nix store.
  sourceDirectory = "${config.xdg.stateHome}/leo-host-input";
  prepareSource = pkgs.writeText "leo-host-prepare-source.py" ''
    import os, pathlib, tempfile, tomllib
    source = pathlib.Path.home() / ".codex/config.toml"
    text = source.read_text()
    parsed = tomllib.loads(text)
    provider = parsed.get("model_provider", "codex-lb")
    selected = parsed.get("model_providers", {}).get(provider, {})
    assert isinstance(selected.get("auth", {}).get("command"), str), "Command auth required"
    assert not selected.get("requires_openai_auth", False), "Command auth required"
    if "model_provider" not in parsed:
        text = 'model_provider = "codex-lb"\n' + text
    target = pathlib.Path("${sourceDirectory}")
    target.mkdir(mode=0o700, parents=True, exist_ok=True)
    assert not target.is_symlink()
    os.chmod(target, 0o700)
    fd, name = tempfile.mkstemp(dir=target)
    with os.fdopen(fd, "w") as output:
        output.write(text)
        output.flush()
        os.fsync(output.fileno())
    os.replace(name, target / "config.toml")
  '';
in
{
  imports = [ inputs.leo-multiplex.homeManagerModules.default ];

  services.leo-host = {
    enable = true;
    # Published runtime 0.2.0 has no bind option and exceeds p2prpc's 32-address
    # limit on this Docker-heavy NAS. Scope this fail-closed compatibility patch
    # to the NAS package, preserving the published dependency pins and policies.
    package = inputs.leo-multiplex.packages.${pkgs.stdenv.hostPlatform.system}.host.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        substituteInPlace "$out/lib/leo-multiplex/node_modules/@arduano/agent-multiplex-runtime-node/dist/main.js" \
          --replace-fail 'secretKey: identity.irohSecretKey,' \
          'secretKey: identity.irohSecretKey, bindAddress: "100.82.173.47:0",'
      '';
    });
    hostName = "home-nas";
    stateDirectory = "${config.xdg.stateHome}/leo-multiplex";
    codexConfigFile = "${sourceDirectory}/config.toml";
    controlPort = 4327;
    # Avoid advertising the NAS's many Docker bridge interfaces.
    p2pBind = "100.82.173.47:49117";
    enrollGateways = false;
    enrollRuntimes = false;
  };

  systemd.user.services.leo-control.Service.ExecStartPre =
    "${pkgs.python3}/bin/python3 ${prepareSource}";
}
