{ ... }:

{
  programs.nixvim.plugins.bufferline = {
    enable = true;
    alwaysShowBufferline = true;
    diagnostics = "nvim_lsp";
    tabSize = 16;
    offsets = [
      {
        filetype = "neo-tree";
        text = "Neo-tree";
        text_align = "left";
        highlight = "Directory";
        separator = true;
      }
    ];
    hover.enabled = true;
  };
}
