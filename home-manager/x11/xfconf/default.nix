# Note: XFCE is not my main driver, but
# I keep it around as a light just-works
# environment for edge cases and when
# xwayland scaling is just, really bad.

{
  imports = [
    ./desktop.nix
    ./keymaps.nix
    ./panels.nix
    ./xfwm.nix
    ./appfinder.nix
  ];

  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';
}
