{ ... }:

{
    programs.eww = {
        enable = true;
        package = pkgs.eww;
        configDir = ./eww
    };
}
