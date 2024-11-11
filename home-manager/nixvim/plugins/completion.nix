{ pkgs, lib, ... }:
let
  blink-compat = pkgs.vimUtils.buildVimPlugin {
    name = "blink.compat";
    src = pkgs.fetchFromGitHub {
      owner = "Saghen";
      repo = "blink.compat";
      rev = "a951034404c14051129b47e09cfed83f7a306898";
      hash = "sha256-/2fGykyb8gmAdchCf96udZLuBxN8feWkQ1BlCl5LsIw=";
    };
  };

  # FIX: cmp_r causes an error with blink
  # cmp-r = pkgs.vimUtils.buildVimPlugin {
  #   name = "cmp-r";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "R-nvim";
  #     repo = "cmp-r";
  #     rev = "18b88eeb7e47996623b9aa0a763677ac00a16221";
  #     hash = "sha256-3h+7q/x5xST50b9MdjR+9JULTwgn6kAyyrL5qhCtta0=";
  #   };
  # };
in
{
  programs.nixvim = {
    extraPlugins = lib.mkAfter [
      pkgs.unstable.vimPlugins.blink-cmp
      blink-compat
      # cmp-r
    ];

    highlightOverride = {
      BlinkCmpMenu.link = "NormalFloat";
      BlinkCmpMenuBorder.link = "FloatBorder";
      BlinkCmpLabel.link = "Normal";
      BlinkCmpMenuSelection.link = "Visual";
    };

    extraConfigLua =
      lib.mkAfter # lua
      ''
        require("blink-cmp").setup({
          sources = {
            completion = {
              enabled_providers = { 'path', 'lsp', 'snippets', 'buffer' },
            },

            providers = {
              path = {
                name = 'Path',
                module = 'blink.cmp.sources.path',
                score_offset = 3,
                opts = {
                  trailing_slash = false,
                  label_trailing_slash = true,
                  get_cwd = function(context) return vim.fn.expand(('#%d:p:h'):format(context.bufnr)) end,
                  show_hidden_files_by_default = false,
                }
              },
              lsp = {
                name = 'LSP',
                module = 'blink.cmp.sources.lsp',
                enabled = true,
                should_show_items = true,
                min_keyword_length = 1,
              },
              snippets = {
                name = 'Snippets',
                module = 'blink.cmp.sources.snippets',
                score_offset = -3,
                min_keyword_length = 2;
                opts = {
                  friendly_snippets = true,
                  search_paths = { vim.fn.stdpath('config') .. '/snippets' },
                  global_snippets = { 'all' },
                  extended_filetypes = {},
                  ignored_filetypes = {},
                }
              },
              buffer = {
                name = 'Buffer',
                module = 'blink.cmp.sources.buffer',
                min_keyword_length = 3;
                fallback_for = { 'lsp' },
              },

              -- cmp_r = {
              --   name = 'cmp_r',
              --   module = 'blink.compat.source',
              --   opts = { impersonate_nvim_cmp = true, },
              -- },
            },
          },

          accept = { auto_brackets = { enabled = true } },
          highlight = { use_nvim_cmp_as_default = true },
          nerd_font_variant = "mono",
          triggers = { signature_help = { enabled = true } },

          windows = {
            autocomplete = {
              border = vim.g.borderStyle,
            },
            documentation = {
              border = vim.g.borderStyle,
              auto_show = true,
            },
            signature_help = {
              border = vim.g.borderStyle,
            },
          }
        })
      '';
  };


  # programs.nixvim.plugins.cmp = {
  #   enable = true;
  #   package = pkgs.unstable.vimPlugins.nvim-cmp;
  #   autoEnableSources = true;
  #
  #   cmdline =
  #     let
  #       mapping.__raw = "cmp.mapping.preset.cmdline()";
  #     in
  #     {
  #       "/" = {
  #         inherit mapping;
  #         sources = [ { name = "buffer"; } ];
  #       };
  #       ":" = {
  #         inherit mapping;
  #         sources = [ { name = "cmdline"; keyword_length = 3; } ];
  #       };
  #     };
  #
  #   settings = {
  #     sources = [
  #       { name = "path"; }
  #       { name = "nvim_lsp"; keyword_length = 1; }
  #       { name = "nvim_lsp_signature_help"; }
  #       { name = "luasnip"; keyword_length = 2; }
  #       { name = "buffer"; keyword_length = 3; }
  #     ];
  #
  #     mapping = {
  #       "<C-y>" = "cmp.mapping.confirm({ select = true })";
  #       "<C-n>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
  #       "<C-p>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
  #       "<C-e>" = "cmp.mapping.abort()";
  #     };
  #
  #     snippet.expand = # lua
  #       ''
  #         function(args)
  #           require('luasnip').lsp_expand(args.body)
  #         end
  #       '';
  #
  #     window =
  #       let
  #         border.__raw = "vim.g.borderStyle";
  #       in
  #       {
  #         completion = {
  #           inherit border;
  #           scrollbar = false;
  #         };
  #
  #         documentation = {
  #           inherit border;
  #         };
  #       };
  #
  #     formatting = {
  #       fields = [ "kind" "abbr" "menu" ];
  #       format = # lua
  #         ''
  #           function(entry, vim_item)
  #             local kind_icons = {
  #               Text = "",
  #               Method = "󰆧",
  #               Function = "󰊕",
  #               Constructor = "",
  #               Field = "󰇽",
  #               Variable = "󰂡",
  #               Class = "󰠱",
  #               Interface = "",
  #               Module = "",
  #               Property = "󰜢",
  #               Unit = "",
  #               Value = "󰎠",
  #               Enum = "",
  #               Keyword = "󰌋",
  #               Snippet = "",
  #               Color = "󰏘",
  #               File = "󰈙",
  #               Reference = "",
  #               Folder = "󰉋",
  #               EnumMember = "",
  #               Constant = "󰏿",
  #               Struct = "",
  #               Event = "",
  #               Operator = "󰆕",
  #               TypeParameter = "󰅲",
  #             }
  #
  #             -- Kind text
  #             vim_item.menu = string.format(' %s', vim_item.kind)
  #             -- Kind icons
  #             vim_item.kind = kind_icons[vim_item.kind]
  #
  #             return vim_item
  #           end
  #         '';
  #     };
  #   };
  # };
}
