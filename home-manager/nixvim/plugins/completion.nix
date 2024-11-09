{ pkgs, ... }:

{
  programs.nixvim.plugins.cmp = {
    enable = true;
    package = pkgs.unstable.vimPlugins.nvim-cmp;
    autoEnableSources = true;

    settings = {
      mapping = {
        "<C-y>" = "cmp.mapping.confirm({ select = true })";
        "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<C-e>" = "cmp.mapping.abort()";
      };

      sources = [
        { name = "path"; }
        { name = "nvim_lsp"; keyword_length = 1; }
        { name = "luasnip"; keyword_length = 2; }
        { name = "buffer"; keyword_length = 3; }
      ];

      snippet.expand = # lua
        ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';

      window =
        let
          border.__raw = "vim.g.borderStyle";
        in
        {
          completion = {
            inherit border;
            scrollbar = false;
          };

          documentation = {
            inherit border;
          };
        };

      formatting = {
        fields = [ "kind" "abbr" "menu" ];
        format = # lua
          ''
            function(entry, vim_item)
              local kind_icons = {
                Text = "",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰇽",
                Variable = "󰂡",
                Class = "󰠱",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "󰅲",
              }

              -- Kind text
              vim_item.menu = string.format(' %s', vim_item.kind)
              -- Kind icons
              vim_item.kind = kind_icons[vim_item.kind]

              return vim_item
            end
          '';
      };
    };
  };
}
