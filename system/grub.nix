{ config, pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = false;
  };
    
  boot.loader.grub = {
    enable = true;
    device = ''${config.fileSystems."/boot".device}'';
    efiSupport = true;
    useOSProber = true;

    # Default GRUB has such small text
    # This makes it more readable for me
    font = "${pkgs.fira-code}/share/fonts/truetype/FiraCode-VF.ttf";
    fontSize = 16; # Only works with ttf or otf fonts

    #splashImage = 
    #splashMode = "normal";
    backgroundColor = "#1e1e2e"; # Goes behind the splash image
    timeoutStyle = "menu";
  };
}
