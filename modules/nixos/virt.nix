{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.qemu_kvm ];

  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
  };
}
