{
  programs.nixvim.plugins.alpha = {
    enable = true;
    iconsEnabled = true;
    
    layout = 
    let
      padding = val: { type = "padding"; inherit val; };
      button = val: cmd-raw: cmd: shortcut: {
        type = "button";
        inherit val;

        on_press.raw = cmd-raw;
        opts = {
          inherit shortcut;
          keymap = [
            "n"
            "${shortcut}"
            "${cmd}"
            {
              noremap = true;
              silent = true;
              nowait = true;
            }
          ];
    
          position = "center";
          cursor = 3;
          width = 20;
          align_shortcut = "right";
          hl_shortcut = "Keyword";
        };
      };
    in
    [
      (padding 4)

      {
        type = "text";
        val = [
          "███╗   ██╗███████╗ ███████╗ ██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██╔════╝██╔════██╗██║   ██║██║████╗ ████║"
          "██╔██╗ ██║█████╗  ██║  ♥ ██║██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██╔══╝  ██║    ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║███████╗╚███████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚══════╝ ╚══════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
        ];
        opts = {
          hl = "Type";
          position = "center";
        };
      }

      (padding 3)
      
      {
        type = "group";
        opts.spacing = 1;
        val = [
          (button
            "  Find File"
            "require('telescope.builtin').find_files"
            ":Telescope find_files<CR>"
            "f"
          )
          (button
            "  New File"
            "function() vim.cmd[[ene]] end"
            ":ene <BAR> startinsert <CR>"
            "n"
          )
          (button
            "󰈚  Recent Files"
            "require('telescope.builtin').oldfiles"
            ":Telescope oldfiles <CR>"
            "r"
          )
          (button
            "󰈭  Find Word"
            "require('telescope.builtin').live_grep"
            ":Telescope live_grep <CR>"
            "w"
          )
          (button
            "  Restore Session"
            "require('persistence').load()"
            ":lua require('persistence').load()<cr>"
            "s"
          )
          (button
            "  Quit Neovim"
            "function() vim.cmd[[qa]] end"
            ":qa<CR>"
            "q"
          )
        ];
      }
    ];
  };
}
