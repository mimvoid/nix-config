{
  programs.nixvim.plugins.trouble = {
    enable = true;
    settings = {
      position = "right";
      auto_close = true;
      auto_fold = false;
      auto_preview = true;
      cycle_results = true;
      group = true;

      border = "single";
      icons = true;
      fold_closed = "";
      fold_open = "";
      width = 40;
      padding = false;
      use_diagnostic_signs = true;
    };
  };
}
