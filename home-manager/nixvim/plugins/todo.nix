{ config, ... }:

{
  programs.nixvim.plugins.todo-comments = {
    enable = true;

    colors = let
      c = config.lib.stylix.colors.withHashtag;
    in {
      error = [ "DiagnosticError" "ErrorMsg" c.red ];
      warning = [ "DiagnosticWarn" "WarningMsg" c.yellow ];
      info = [ "DiagnosticInfo" c.blue ];
      hint = [ "DiagnosticHint" c.green ];
      default = [ "Identifier" c.magenta ];
      test = [ "Identifier" c.magenta ];
    };

    highlight = {
      keyword = "wide_fg";
      after = "";
      before = "";
      commentsOnly = true;
      multiline = true;
    };

    keywords = {

      # icon = Icon used for the sign and in search results.
      # color = Can be a hex color or a named color.
      # alt = A set of other keywords that all map to this keyword.

      FIX = { icon = " "; color = "error"; alt = [ "FIXME" "BUG" "ISSUE" ]; };
      TODO = { icon = " "; color = "info"; alt = [ "WIP" ]; };
      HACK = { icon = " "; color = "warning"; };
      WARN = { icon = " "; color = "warning"; alt = [ "WARNING" ]; };
      PERF = { icon = "󰥔 "; alt = [ "OPTIM" "PERFORMANCE" "OPTIMIZE" ]; };
      NOTE = { icon = " "; color = "hint"; alt = [ "INFO" "Note" ]; };
      TEST = { icon = " "; color = "test"; alt = [ "TESTING" "PASSED" "FAILED" ]; };
    };

    search = {
      command = "rg";
      args = [
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
        "--hidden"
        "--glob"
        "!**/.git/*"
      ];
      pattern = ''\b(KEYWORDS):'';
    };
  };
}
