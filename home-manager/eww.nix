{ pkgs, ... }:

{
    home.packages = [ pkgs.eww ];

    programs.eww = {
        enable = true;
        package = pkgs.eww;
        configDir = ./eww;
    };
}
