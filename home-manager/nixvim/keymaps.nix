{
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  programs.nixvim.keymaps = let
    key = { silent ? false, mode ? "n" }: desc: key: action: {
      inherit mode key action;
      options = {
        inherit desc silent;
      };
    };

    s = { silent = true; };
    si = { silent = true; mode = "i"; };
  in
  [
    # Don't yank empty lines with dd
    {
      mode = "n";
      key = "dd";
      action.__raw = # lua
      ''
        function()
          if vim.fn.getline('.'):match('^%s*$') then
            return '"_dd'
          end
          return 'dd'
        end
      '';

      options = {
        expr = true;
        silent = true;
        desc = "Delete line";
      };
    }

    # Insert mode navigation
    (key si "Move down"  "<A-J>" "<Down>")
    (key si "Move up"    "<A-k>" "<Up>")
    (key si "Move left"  "<A-h>" "<Left>")
    (key si "Move right" "<A-l>" "<Right>")

    # Buffers
    (key s "Close buffer"    "<leader>x" "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>")
    (key s "Next buffer"     "<Tab>"     "<cmd>bn<cr>")
    (key s "Previous buffer" "<S-Tab>"   "<cmd>bp<cr>")

    # Windows
    (key s "Split window below" "<leader>j" "<C-W>s")
    (key s "Split window right" "<leader>l" "<C-W>v")

    (key s "Go to window left"  "<C-h>" "<C-W>h")
    (key s "Go to window right" "<C-l>" "<C-W>l")
    (key s "Go to window above" "<C-k>" "<C-W>k")
    (key s "Go to window below" "<C-j>" "<C-W>j")

    (key {} "Open terminal" "<leader>t" "<cmd>vsplit<bar>terminal<cr>")

    # Replace placeholder text
    (key s
      "Replaces placeholder '<++>'"
      "<leader><Space>"
      "/<++><Enter>\"_c4l")

    # Telescope
    (key {}
      "Telescope find files"
      "<leader>ff"
      "<cmd>Telescope find_files<cr>")
    (key {}
      "Telescope recent files"
      "<leader>fr"
      "<cmd>Telescope frecency<cr>")
    (key {}
      "Telescope find word"
      "<leader>fw"
      "<cmd>Telescope live_grep<cr>")
  ];
}
