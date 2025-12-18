{ pkgs, ... }:

{
  home.packages = [ pkgs.voids.fontpreview ];

  # Environment variable settings
  home.sessionVariables = {
    FONTPREVIEW_SIZE = "650x700";
    FONTPREVIEW_PREVIEW_TEXT = builtins.concatStringsSep "\n" [
      "SPHINX OF BLACK QUARTZ,"
      "JUDGE MY VOW."
      "" # extra line break
      "Sphinx of Black Quartz,"
      "Judge My Vow."
      ""
      "sphinx of black quartz,"
      "judge my vow."
      ""
      "1234567890"
      ''!@$\%(){}[];:\'\"''
    ];
  };
}
