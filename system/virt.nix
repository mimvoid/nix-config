{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ qemu_kvm ];

  virtualisation = {
    #podman = {
    #  enable = true;
    #  autoPrune = {
    #    enable = true;
    #    dates = "weekly";
    #  };
    #};

    libvirtd.enable = true;
    kvmgt.enable = true;
  };
}
