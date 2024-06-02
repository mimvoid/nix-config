{ config, ... }:

{
    boot.loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = false;
    };
    
    boot.loader.grub = {
        enable = true;
        device = ''${config.fileSystems."/boot}".device}'';
        efiSupport = true;
        useOSProber = true;

        theme = ;
        splashImage = 
        backgroundColor = "#24273A";
    };
}
