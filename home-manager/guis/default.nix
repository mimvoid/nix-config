{ pkgs, inputs, ... }:

{
    home.packages = with pkgs; [
        # Thunar
        xfce.thunar
        xfce.thunar-archive-plugin
        gvfs
    ];

    # There seems to be a bug with flatpak
    # that prevents nix-flatpak from working
    # so this will be commented for now

    #services.flatpak.packages = [ "" ];

    #services.flatpak.update.auto = {
    #    enable = true;
    #    onCalendar = "weekly";
    #};

    # Imports list of allowed unfree packages from flake.nix
    #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) allowed-unfree-packages; 
}
