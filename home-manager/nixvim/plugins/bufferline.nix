{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    alwaysShowBufferline = true;
    diagnostics = "nvim_lsp";
    tabSize = 16;
    hover.enabled = true;
  };
}
