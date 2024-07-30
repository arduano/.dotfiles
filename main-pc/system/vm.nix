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
    adwaita-icon-theme
    virtiofsd
    xorriso
  ];
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        verbatimConfig = ''
          namespaces = []
          cgroup_device_acl = [
             "/dev/null", "/dev/full", "/dev/zero",
             "/dev/random", "/dev/urandom",
             "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
             "/dev/rtc","/dev/hpet", "/dev/vfio/vfio",
             "/dev/kvmfr0"
          ]
        '';
      };
      onBoot = "ignore";
      onShutdown = "shutdown";
    };
    spiceUSBRedirection.enable = true;
  };
  services.spice-vdagentd.enable = true;

  # set /etc/looking-glass-client.ini
  environment.etc."looking-glass-client.ini".text = ''
    [app]
    shmFile=/dev/kvmfr0

    [win]
    fullscreen=yes
  '';

  services.nfs.server.enable = true;
  services.nfs.server.exports = ''
    /home/arduano         192.168.122.0/24(rw,sync,no_subtree_check,anonuid=1000,anongid=1000)
  '';

  # virtualisation.vmware.host.enable = true;

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

        "kvmfr"
      ];

      kernelModules = [ "kvm-amd" ];

      kernelParams = [
        # enable IOMMU
        "amd_iommu=on"
        # Virtualize GPU
        ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs)

        # Enable kvmfr
        "kvmfr.static_size_mb=64"
      ];

      # Enable kvmfr
      extraModulePackages = [
        config.boot.kernelPackages.kvmfr
      ];
    };

  services.udev.extraRules = ''
    SUBSYSTEM=="kvmfr", OWNER="arduano", GROUP="libvirtd", MODE="0660"
  '';

  systemd.tmpfiles.rules = [
    "f /dev/shm/looking-glass 0660 arduano qemu-libvirtd -" # Looking glass
  ];

  users.users.arduano.extraGroups = [ "libvirtd" ];

  virtualisation.docker.enable = true;
  # services.qemuGuest.enable = true;
  # boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # environment.systemPackages = with pkgs; [
  #   # Ceph was failing to build
  #   (qemu_full.override { cephSupport = false; })
  # ];
}
