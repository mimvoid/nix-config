{ pkgs, ... }:

# Note: XFCE is not my main driver, but
# I keep it around as a light just-works
# environment for edge cases and when
# xwayland scaling is just, really bad.

{
  imports = [
    ./thunar.nix
    ./picom.nix
    ./cortile.nix
    ./appfinder.nix
    ./xfce-desktop.nix
    ./xfce-keymaps.nix
    ./xfce-panels.nix
    ./xfwm.nix
  ];

  home.packages = with pkgs; [ xclip ];

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';
}
