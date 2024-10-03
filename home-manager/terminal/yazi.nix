{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    package = pkgs.unstable.yazi;
    enableZshIntegration = true;
    shellWrapperName = "yy";

    theme.status = {
      separator_open = "";
      separator_close = "";
    };

    settings = {
      manager = {
        ratio = [1 4 3];
        show_hidden = true;
        show_symlink = true;
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        sort_translit = true;
        linemode = "none";
      };
      preview = {
        tab_size = 2;
      };

      plugin.prepend_previewers = [
        { mime = "audio/*"; run = "exifaudio"; }
      ];
    };

    keymap = {
      manager.prepend_keymap = [
        # Smart paste plugin
        { on = "p"; run = "plugin --sync smart-paste"; }

        # File navigation wraparound plugin
        { on = "k"; run = "plugin --sync arrow --args=-1"; }
        { on = "j"; run = "plugin --sync arrow --args=1"; }

        # Max preview
        { on = "T"; run = "plugin --sync max-preview"; }

        # Bookmarks
        { on = "m"; run = "plugin bookmarks --args=save"; }
        { on = "'"; run = "plugin bookmarks --args=jump"; }
        { on = "`"; run = "plugin bookmarks --args=jump"; }
        { on = [ "b" "d" ]; run = "plugin bookmarks --args=delete"; }
      ];
    };

    plugins = {
      full-border = pkgs.callPackage ../../packages/yazi/full-border.nix {};
      max-preview = pkgs.callPackage ../../packages/yazi/max-preview.nix {};
      bookmarks = pkgs.callPackage ../../packages/yazi/bookmarks.nix {};
      exifaudio = pkgs.callPackage ../../packages/yazi/exifaudio.nix {};
    };

    initLua = # lua
    ''
      require("full-border"):setup()
      require("bookmarks"):setup({
        persist = "vim",
        desc_format = "parent",
        file_pick_mode = "parent",
      })
    '';
  };

  xdg.configFile = {
    # Smart paste: paste files without entering directory
    "yazi/plugins/smart-paste.yazi/init.lua" = {
      enable = true;
      text = # lua
      ''
        return {
	        entry = function()
		        local h = cx.active.current.hovered
		        if h and h.cha.is_dir then
			        ya.manager_emit("enter", {})
			        ya.manager_emit("paste", {})
			        ya.manager_emit("leave", {})
		        else
			        ya.manager_emit("paste", {})
		        end
	        end,
        }
      '';
    };

    # Arrow: file navigation wraparound
    "yazi/plugins/arrow.yazi/init.lua" = {
      enable = true;
      text = # lua
      ''
        return {
        	entry = function(_, args)
        		local current = cx.active.current
        		local new = (current.cursor + args[1]) % #current.files
        		ya.manager_emit("arrow", { new - current.cursor })
        	end,
        }
      '';
    };
  };
}
