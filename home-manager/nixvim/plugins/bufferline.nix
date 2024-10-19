{
  programs.nixvim.plugins.bufferline = {
    enable = true;

    settings.options = {
      always_show_bufferline = true;
      diagnostics = "nvim_lsp";
      tab_size = 16;
      hover.enabled = true;
    };
  };
}
