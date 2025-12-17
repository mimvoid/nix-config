{ pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
