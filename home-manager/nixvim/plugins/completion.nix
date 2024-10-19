{
  programs.nixvim.plugins.cmp = {
    enable = true;
    autoEnableSources = true;

    settings = {
      mapping = {
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        # "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<C-e>" = "cmp.mapping.abort()";
      };

      sources = [
        { name = "path"; }
        { name = "nvim_lsp"; keyword_length = 1; }
        { name = "luasnip"; keyword_length = 2; }
        { name = "buffer"; keyword_length = 3; }
      ];

      window = {
        completion = {
          border = "rounded";
          side_padding = 2;
        };

        documentation.border = "rounded";
      };

      performance = {
        throttle = 100;
        max_view_entries = 6;
      };
    };
  };
}
