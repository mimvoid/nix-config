{ ... }:

{
  programs.xwayland.enable = false;

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
