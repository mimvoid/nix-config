{
  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings = {
      performance = {
        throttle = 100;
        max_view_entries = 6;
      };
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
      sources = [
        {name = "path";}
        {name = "nvim_lsp"; keyword_length = 1; }
        {name = "buffer"; keyword_length = 3; }
      ];
      window.completion = {
        border = "rounded";
        scrollbar = true;
        side_padding = 2;
      };
      window.documentation.border = "rounded";
    };
  };
}
