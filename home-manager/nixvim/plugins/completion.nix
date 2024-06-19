{
  programs.nixvim.plugins.cmp = {
   enable = true;
   autoEnableSources = true;
   settings = {
     performance = {
       throttle = 100;
       max_view_entries = 8;
     };
      mapping = {
        "<S><CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<A-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };
      sources = [
        {name = "nvim_lsp";}
        {name = "luasnip";}
        {name = "buffer";}
        {name = "cmdline";}
        {name = "path";}
        {name = "git";}
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
