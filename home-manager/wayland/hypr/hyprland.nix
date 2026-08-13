{ pkgs, config, ... }:

{
  xdg.configFile."hypr/mimconf.lua" = config.voids.lib.symlink "wayland/hypr/mimconf.lua";

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = [ "--all" ];

    # Already handled with NixOS
    package = null;
    portalPackage = null;

    configType = "lua";
    extraConfig =
      let
        inherit (pkgs.palettes.macchi-nightlight.hexRgbWrap) primary alpha;
        inherit (pkgs.theme) cursor;
      in
      # lua
      ''
        require("mimconf").setup({
          col = {
            active_border = "${primary}",
            inactive_border = "${alpha.primary-dim}",
            shadow = "${alpha.shadow}",
          },
          cursor = {
            theme = "${cursor.name}",
            size = "${toString cursor.size}",
          },
        })
      '';
  };
}
