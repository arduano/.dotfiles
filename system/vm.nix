{ config, pkgs, inputs, ... }:

{
  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    win-virtio
    win-spice
    looking-glass-client
    gnome.adwaita-icon-theme
  ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  boot.initrd.availableKernelModules = [ "vfio-pci" ];
  boot.initrd.preDeviceCommands =
    let
      gpu = "0a:00.0";
      gpuAudio = "0a:00.1";
    in
    ''
      DEVS="0000:${gpu} 0000:${gpuAudio}"
      for DEV in $DEVS; do
        echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
      done
      modprobe -i vfio-pci
    '';

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "amd_iommu=on" "pcie_aspm=off" ];
  boot.kernelModules = [ "kvm-amd" ];

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 alex qemu-libvirtd -" # Looking glass
    # "f /dev/shm/scream 0660 alex qemu-libvirtd -" # Scream
  ];

  # systemd.user.services.scream-ivshmem = {
  #   enable = true;
  #   description = "Scream IVSHMEM";
  #   serviceConfig = {
  #     ExecStart = "${pkgs.scream-receivers}/bin/scream-ivshmem-pulse /dev/shm/scream";
  #     Restart = "always";
  #   };
  #   wantedBy = [ "multi-user.target" ];
  #   requires = [ "pipewire.service" ];
  # };


  users.users.arduano.extraGroups = [ "libvirtd" ];
}
