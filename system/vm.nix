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
    virtiofsd
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

  # environment.etc = {
  #   "ovmf/edk2-x86_64-secure-code.fd" = {
  #     source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
  #   };

  #   "ovmf/edk2-i386-vars.fd" = {
  #     source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
  #   };
  # };

  boot =
    with pkgs;
    let
      gpuIDs = [
        "10de:1b06" # Graphics
        "10de:10ef" # Audio
      ];
    in
    {
      initrd.kernelModules = [
        "vfio_pci"
        "vfio"
        "vfio_iommu_type1"

        "nvidia"
        "nvidia_modeset"
        "nvidia_uvm"
        "nvidia_drm"
      ];

      kernelModules = [ "kvm-amd" ];

      kernelParams = [
        # enable IOMMU
        "amd_iommu=on"
        # Virtualize GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)
      ];
    };

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 arduano qemu-libvirtd -" # Looking glass
  ];

  users.users.arduano.extraGroups = [ "libvirtd" ];
}
