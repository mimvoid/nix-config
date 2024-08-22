{ pkgs, ... }:

{
  home.packages = [ pkgs.xterm ];

  # Theming-specific config is in ../theming.nix
  xresources.properties = {
    "XTerm.termName" = "xterm-256color";
    "XTerm*locale" = true;
    "XTerm*loginshell" = true; # include environment variables
    "XTerm*saveLines" = 2048;
    "XTerm*metaSendsEscape" = true;

    # Enable Sixel
    "XTerm*decTerminalID" = "vt340";
    "XTerm*numColorRegisters" = 256;
    "XTerm*sixelScrolling" = 1;
    "XTerm*sixelScrollsRight" = 1;
    # Query screen size to calculate character cell size, to align sixel graphics with text
    "XTerm*disallowedWindowOps" = [ 1 2 3 4 5 6 7 8 9 11 13 19 20 21 "GetSelection" "SetSelection" "SetWinLines" "SetXprop" ];
    
    # Clipboard
    "XTerm*selectToClipboard" = true;
    "XTerm*translations" = ''#override \n\
      Ctrl Shift <Key>C: copy-selection(CLIPBOARD) \n\
      Ctrl Shift <Key>V: insert-selection(CLIPBOARD)
    '';

    "XTerm*internalBorder" = 16; # padding
  };
}
