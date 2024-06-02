{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [(
        catppuccin-sddm.override {
            flavor = "macchiato";
            font = "SauceCodePro Nerd Font";
            fontSize = "11";
            background = "${../wallpapers/gracile_jellyfish.jpg}";
            loginBackground = true;
        }
    )];

    services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
        theme = "catppuccin-macchiato";
    };
}
