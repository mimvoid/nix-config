{ ... }:

{
  programs.nixvim.plugins.alpha = {
    enable = true;
    layout = [
      {
        type = "padding";
        val = 4;
      }
      {
        opts = {
          hl = "Type";
          position = "center";
        };
        type = "text";
        val = [
          "███╗   ██╗███████╗ ███████╗ ██╗   ██╗██╗███╗   ███╗"
          "████╗  ██║██╔════╝██╔════██╗██║   ██║██║████╗ ████║"
          "██╔██╗ ██║█████╗  ██║  ♥ ██║██║   ██║██║██╔████╔██║"
          "██║╚██╗██║██╔══╝  ██║    ██║╚██╗ ██╔╝██║██║╚██╔╝██║"
          "██║ ╚████║███████╗╚███████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║"
          "╚═╝  ╚═══╝╚══════╝ ╚══════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝"
        ];
      }
      {
        type = "padding";
        val = 3;
      }
        #{
        #  type = "group";
        #  val =
        #}

      {
        type = "group";
        opts.spacing = 1;
        val = [
            #{ "  Find File", "Spc f f", "Telescope find_files" }
            #{ "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" }
            #{ "󰈭  Find Word", "Spc f w", "Telescope live_grep" }
            #{ "  Bookmarks", "Spc m a", "Telescope marks" }
            #{ "  Themes", "Spc t h", "Telescope themes" }
            #{ "  Mappings", "Spc c h", "NvCheatsheet" }

          {
            on_press = {
              __raw = "function() vim.cmd[[ene]] end";
            };
            opts = {
              shortcut = "n";
              position = "center";
            };
            type = "button";
            val = "  New file";
          }
          {
            opts = {
              shortcut = "SPC f h";
              position = "center";
            };
            type = "button";
            val = " 󰥔 Recently opened files";
          }
          {
            opts = {
              shortcut = "SPC f f";
              position = "center";
            };
            type = "button";
            val = " 󰈞 Search files";
          }
          {
            on_press = {
              __raw = "function() vim.cmd[[qa]] end";
            };
            opts = {
              shortcut = "q";
              position = "center";
            };
            type = "button";
            val = " 󰅗 Quit Neovim";
          }
        ];
      }
    ];
  };
}
