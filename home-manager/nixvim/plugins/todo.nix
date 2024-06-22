{
  programs.nixvim.plugins.todo-comments = {
    enable = true;
    colors = {
      error = [ "DiagnosticError" "ErrorMsg" "#DC2626" ];
      warning = [ "DiagnosticWarn" "WarningMsg" "#FBBF24" ];
      info = [ "DiagnosticInfo" "#2563EB" ];
      hint = [ "DiagnosticHint" "#10B981" ];
      default = [ "Identifier" "#7C3AED" ];
      test = [ "Identifier" "#FF00FF" ];
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
    search.args = [
      "--color=never"
      "--no-heading"
      "--with-filename"
      "--line-number"
      #"--column"
    ];
  };
}
