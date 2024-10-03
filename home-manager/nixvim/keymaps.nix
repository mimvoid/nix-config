{
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  programs.nixvim.keymaps = let
    map = desc: mode: key: action: {
      inherit mode;
      inherit key;
      inherit action;
      options = {
        inherit desc;
      };
    };
    sil = desc: mode: key: action: {
      inherit mode;
      inherit key;
      inherit action;
      options = {
        silent = true;
        inherit desc;
      };
    };

    ts-repeat-move = ''require("nvim-treesitter.textobjects.repeatable_move")'';
  in
  [
    # Insert mode
    (sil "Move down"  "i" "<A-J>" "<Down>")
    (sil "Move up"    "i" "<A-k>" "<Up>")
    (sil "Move left"  "i" "<A-h>" "<Left>")
    (sil "Move right" "i" "<A-l>" "<Right>")
    
    # Buffers
    (sil "Close buffer"    "n" "<leader>x" "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>")
    (sil "Next buffer"     "n" "<Tab>"     "<cmd>bn<cr>")
    (sil "Previous buffer" "n" "<S-Tab>"   "<cmd>bp<cr>")

    # Windows
    (sil "Split window below" "n" "<leader>j" "<C-W>s")
    (sil "Split window right" "n" "<leader>l" "<C-W>v")

    (sil "Go to window left"  "n" "<C-h>"     "<C-W>h")
    (sil "Go to window right" "n" "<C-l>"     "<C-W>l")
    (sil "Go to window above" "n" "<C-k>"     "<C-W>k")
    (sil "Go to window below" "n" "<C-j>"     "<C-W>j")

    (map "Open terminal"      "n" "<leader>t" "<cmd>vsplit<bar>terminal<cr>")

    # Replace placeholder text
    (sil "Replaces placeholder '<++>'" "n" "<leader><Space>" "/<++><Enter>\"_c4l")


    # Plugins

    # Mini.files
    (map "Open mini.files" "n" "<leader>e" "<cmd>lua MiniFiles.open()<cr>")

    # Git
    (map "Open Lazygit"  "n" "<leader>g" "<cmd>LazyGit<cr>")
  
    # Telescope
    (map "Telescope find files"   "n" "<leader>ff" "<cmd>Telescope find_files<cr>")
    (map "Telescope recent files" "n" "<leader>fr" "<cmd>Telescope frecency<cr>")
    (map "Telescope find word"    "n" "<leader>fw" "<cmd>Telescope live_grep<cr>")

    # Treesitter
    (map "Repeat last move" [ "n" "x" "o" ] "n" "${ts-repeat-move}.repeat_last_move")
    (map "Repeat opposite move" [ "n" "x" "o" ] "," "${ts-repeat-move}.repeat_last_move_opposite")
  ];
}
