{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ qemu_kvm ];

  virtualisation = {
    libvirtd.enable = true;
    kvmgt.enable = true;
  };
}
