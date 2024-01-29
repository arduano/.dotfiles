{ ... }: {
  services.arduano.sunshine.enable = true;
  arduano.syncNixChannel.enable = true;
  arduano.vscode-server.enable = true;
  services.tailscale.enable = true;
}
