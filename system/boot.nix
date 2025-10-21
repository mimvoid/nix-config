{ pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = true;
  };

  # See: https://github.com/NixOS/nixpkgs/issues/449939
  boot.kernelPackages = pkgs.linuxPackages_6_16;
}
