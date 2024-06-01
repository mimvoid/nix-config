{ pkgs, lib, allowed-unfree-packages, ... }:

{
    home.packages = with pkgs; [
        # Thunar
        xfce.thunar
        xfce.thunar-archive-plugin
        xfce.thunar-media-tags-plugin
        gvfs

        # Art & design
        #krita Seems to be broken right now

        # Documents
        pdfarranger
        zotero_7
        zathura

        # Misc
        anki
        bottles
        zoom-us
        vesktop
        freetube
    ];

    imports = [
        ./freetube.nix
    ];

    programs.zathura.enable = true;

    # There seems to be a bug with flatpak
    # that prevents nix-flatpak from working
    # so this will be commented for now

    #services.flatpak.packages = [ "" ];

    #services.flatpak.update.auto = {
    #    enable = true;
    #    onCalendar = "weekly";
    #};

    # Imports list of allowed unfree packages from flake.nix
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages; 
}
