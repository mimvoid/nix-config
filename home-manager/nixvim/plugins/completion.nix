let
  # blink = pkgs.unstable.callPackage ../../../packages/blink-cmp/default.nix {};
  #
  # blink-compat = pkgs.vimUtils.buildVimPlugin {
  #   name = "blink.compat";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Saghen";
  #     repo = "blink.compat";
  #     rev = "747262967a419b040ca20302594b1fa343e0f01a";
  #     hash = "sha256-q2NYQP2IZR0EaIL6KxFeWzMKCVi8tt9Ztpqhf3XfAps=";
  #   };
  # };
in
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

  # programs.nixvim = {
  #   extraPlugins = lib.mkAfter [
  #     blink
  #     blink-compat
  #   ];
  #
  #   extraConfigLua = lib.mkAfter # lua
  #   ''
  #     require("blink-cmp").setup({
  #       sources = {
  #         completion = {
  #           enabled_providers = { 'path', 'lsp', 'snippets', 'buffer', 'cmp_r' },
  #         },
  #
  #         providers = {
  #           cmp_r = {
  #             name = 'cmp_r',
  #             module = 'blink.compat.source',
  #           },
  #         },
  #       },
  #
  #       accept = { auto_brackets = { enabled = true } },
  #       highlight = { use_nvim_cmp_as_default = true },
  #       nerd_font_variant = "mono",
  #       triggers = { signature_help = { enabled = true } },
  #
  #       windows = {
  #         autocomplete = {
  #           border = vim.g.borderStyle,
  #         },
  #         documentation = {
  #           border = vim.g.borderStyle,
  #           auto_show = true,
  #         },
  #         signature_help = {
  #           border = vim.g.borderStyle,
  #         },
  #       }
  #     })
  #   '';
  # };
}
