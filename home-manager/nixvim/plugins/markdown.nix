{
  programs.nixvim.plugins.markdown-preview = {
    enable = true;
    settings = {
      auto_close = true;
      auto_start = false;
      browser = "firefox";
    };
  };
}
