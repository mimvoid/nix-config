{
  programs.nixvim.globals = {
    mapleader = " ";
    maplocalleader = " ";
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>g";
      action = "<cmd>Lazygit<CR>";
    }
    # Telescope
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<cr>";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>Telescope oldfiles<cr>";
    }
    {
      mode = "n";
      key = "<leader>fw";
      action = "<cmd>Telescope live_grep<cr>";
    }

    # Insert mode
    {
      mode = "i";
      key = "<C-j>";
      action = "<Down>";
    }
    {
      mode = "i";
      key = "<C-k>";
      action = "<Up>";
    }
    {
      mode = "i";
      key = "<C-h>";
      action = "<Left>";
    }
    {
      mode = "i";
      key = "<C-l>";
      action = "<Right>";
    }
    # Tabs
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>tabnew<CR>";
      options = {
        silent = true;
        desc = "New Tab";
      };
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>bp<bar>sp<bar>bn<bar>bd<CR>";
      options = {
        silent = true;
        desc = "Close Tab";
      };
    }
    {
      mode = "n";
      key = "<Tab>";
      action = "<cmd>BufferLineCycleNext<CR>";
      options = {
        silent = true;
        desc = "Move to next tab";
      };
    }
    {
      mode = "n";
      key = "<S-Tab>";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options = {
        silent = true;
        desc = "Move to the previous tab";
      };
    }

    # Windows
    {
      mode = "n";
      key = "<leader>j";
      action = "<C-W>s";
      options = {
        silent = true;
        desc = "Split window below";
      };
    }
    {
      mode = "n";
      key = "<leader>l";
      action = "<C-W>v";
      options = {
        silent = true;
        desc = "Split window right";
      };
    }
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-W>h";
      options = {
        silent = true;
        desc = "Move to window left";
      };
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-W>l";
      options = {
        silent = true;
        desc = "Move to window right";
      };
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-W>k";
      options = {
        silent = true;
        desc = "Move to window above";
      };
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-W>j";
      options = {
        silent = true;
        desc = "Move to window below";
      };
    }
    {
      mode = "n";
      key = "<leader>t";
      action = "<cmd>vsplit<bar>terminal<CR>";
      options.desc = "Open terminal";
    }

    # Neo-tree
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Neotree focus<CR>";
    }
    {
      mode = "n";
      key = "<leader>wk";
      action = "<cmd>WhichKey <CR>";
    }
  ];
}
