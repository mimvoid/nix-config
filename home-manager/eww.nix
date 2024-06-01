{ pkgs, ... }:

{
    programs.eww = {
        enable = true;
        package = pkgs.eww;
        configDir = ./eww
    };
}
