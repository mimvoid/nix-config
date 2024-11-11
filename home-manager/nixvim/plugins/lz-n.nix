{ pkgs, lib, ... }:
let
  # Replace __unkeyed-1 to look prettier
  plugin = { name, event ? null, ft ? null, cmd ? null, keys ? null }: {
    __unkeyed-1 = name;
    inherit keys cmd event ft;
  };

  key = { desc, key, action }: {
    __unkeyed-1 = key;
    __unkeyed-2 = action;
    inherit desc;
  };
in
{
  programs.nixvim.plugins.lz-n = {
    enable = true;
    package = pkgs.unstable.vimPlugins.lz-n;

    plugins = lib.lists.map (i: plugin i) [
      {
        name = "telescope.nvim";
        cmd = "Telescope";
      }
      {
        name = "marks.nvim";
        event = "DeferredUIEnter";
      }

      # typing
      {
        name = "ultimate-autopair.nvim";
        event = [ "InsertEnter" "CmdlineEnter" ];
      }
      {
        name = "neotab.nvim";
        event = "InsertEnter";
      }

      # ide-ish features
      {
        name = "nvim-lspconfig";
        event = [ "BufNewFile" "BufReadPost" ];
        cmd = "LspInfo";
      }
      {
        name = "luasnip";
        event = "InsertEnter";
      }
      {
        name = "friendly-snippets";
        event = "InsertEnter";
      }
      {
        name = "conform.nvim";
        event = "BufWritePre";
        cmd = "ConformInfo";
        keys = [
          {
            desc = "Format buffer";
            __unkeyed-1 = "<leader>bf";
            __unkeyed-2.__raw = ''
              require("conform").format({ async = true })
            '';
            mode = "";
          }
        ];
      }

      # mini
      {
        name = "mini.move";
        event = "DeferredUIEnter";
      }
      {
        name = "mini.surround";
        event = "DeferredUIEnter";
      }
      {
        name = "mini.trailspace";
        event = "DeferredUIEnter";
        keys = lib.lists.map (i: key i) [
          {
            desc = "Trim trailing whitespace";
            key = "<leader>ww";
            action = "<cmd>lua MiniTrailspace.trim()<cr>";
          }
          {
            desc = "Trim trailing lines";
            key = "<leader>wl";
            action = "<cmd>lua MiniTrailspace.trim_last_lines()<cr>";
          }
        ];
      }
      {
        name = "mini.files";
        keys = lib.lists.map (i: key i) [
          {
            desc = "Open mini.files";
            key = "<leader>e";
            action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<cr>";
          }
        ];
      }
      {
        name = "mini.clue";
        event = "DeferredUIEnter";
      }

      # misc
      {
        name = "persistence.nvim";
        event = "BufReadPre";
      }
      {
        name = "fcitx.vim";
        event = "InsertEnter";
      }
    ];
  };
}
