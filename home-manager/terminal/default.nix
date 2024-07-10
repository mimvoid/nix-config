{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./foot.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    xterm
    bluetuith
    rclone
    distrobox
    gotop
    unstable.dooit
    imagemagick
  ];

  # Theming-specific config is in ../theming.nix
  xresources.properties = {
    "XTerm.termName" = "xterm-256color";
    "XTerm*locale" = true;
    "XTerm*saveLines" = 2048;
    "XTerm*metaSendsEscape" = true;
    "XTerm*selectToClipboard" = true;
    "XTerm*translations" = ''#override \n\
      Ctrl Shift <Key>C: copy-selection(CLIPBOARD) \n\
      Ctrl Shift <Key>V: insert-selection(CLIPBOARD)
    '';
  };
}
