{
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  programs.nixvim.keymaps =
  # TODO: what is the syntax for a default value?

  let
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
  in
  [
    # Insert mode
    (sil "Move down"  "i" "<A-J>" "<Down>")
    (sil "Move up"    "i" "<A-k>" "<Up>")
    (sil "Move left"  "i" "<A-h>" "<Left>")
    (sil "Move right" "i" "<A-l>" "<Right>")
    
    # Tabs
    (sil "New tab"      "n" "<leader>b" "<cmd>tabnew<cr>")
    (sil "Close tab"    "n" "<leader>x" "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>")
    (sil "Next tab"     "n" "<Tab>"     "<cmd>BufferLineCycleNext<cr>")
    (sil "Previous tab" "n" "<S-Tab>"   "<cmd>BufferLineCyclePrev<cr>")

    # Windows
    (sil "Split window below" "n" "<leader>j" "<C-W>s")
    (sil "Split window right" "n" "<leader>l" "<C-W>v")

    (sil "Go to window left"  "n" "<C-h>"     "<C-W>h")
    (sil "Go to window right" "n" "<C-l>"     "<C-W>l")
    (sil "Go to window above" "n" "<C-k>"     "<C-W>k")
    (sil "Go to window below" "n" "<C-j>"     "<C-W>j")

    (map "Open terminal"      "n" "<leader>t" "<cmd>vsplit<bar>terminal<cr>")


    # Plugins
    
    # Neotree
    (map "Focus Neotree" "n" "<leader>e" "<cmd>Neotree focus<cr>")
    
    #WhichKey
    (map "Open WhichKey" "n" "<leader>wk" "<cmd>WhichKey<cr>")

    # Git
    (map "Open Lazygit"  "n" "<leader>g" "<cmd>LazyGit<cr>")
  
    # Telescope
    (map "Telescope find files"   "n" "<leader>ff" "<cmd>Telescope find_files<cr>")
    (map "Telescope recent files" "n" "<leader>fr" "<cmd>Telescope oldfiles<cr>")
    (map "Telescope find word"    "n" "<leader>fw" "<cmd>Telescope live_grep<cr>")
  ];
}
