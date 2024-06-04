{
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    settings = {
      auto_close = true;
      auto_start = true;
      browser = "firefox";
      preview_options = {
        editable = true;
      };
    };
  };
}
