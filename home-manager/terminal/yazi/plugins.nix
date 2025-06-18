{ pkgs, ... }:

{
  programs.yazi = {
    settings.plugin = {
      prepend_previewers = [ { mime = "audio/*"; run = "exifaudio"; } ];
      prepend_fetchers = [
        { id = "git"; name = "*"; run = "git"; }
        { id = "git"; name = "*/"; run = "git"; }
      ];
    };

    keymap.manager.prepend_keymap = [
      # Smart paste plugin
      { on = "p"; run = "plugin smart-paste"; }

      # File navigation wraparound plugin
      { on = "k"; run = "plugin arrow -1"; }
      { on = "j"; run = "plugin arrow 1"; }

      # Max preview
      { on = "T"; run = "plugin toggle-pane max-preview"; }

      # Bookmarks
      { on = "m"; run = "plugin bookmarks save"; }
      { on = "'"; run = "plugin bookmarks jump"; }
      { on = "`"; run = "plugin bookmarks jump"; }
      { on = [ "b" "d" ]; run = "plugin bookmarks delete"; }
      { on = [ "b" "D" ]; run = "plugin bookmarks delete_all"; }
    ];

    initLua = /* lua */ ''
      require("git"):setup()
      require("full-border"):setup()
      require("bookmarks"):setup({
        persist = "vim",
        desc_format = "parent",
        file_pick_mode = "parent",
      })
    '';
  };

  xdg.configFile = pkgs.voids.lib.prependAttrs "yazi/plugins/" {
    "bookmarks.yazi".source = pkgs.voids.yaziPlugins.bookmarks;
    "exifaudio.yazi".source = pkgs.voids.yaziPlugins.exifaudio;

    "git.yazi".source = pkgs.yaziPlugins.git;
    "full-border.yazi".source = pkgs.yaziPlugins.full-border;
    "smart-paste.yazi".source = pkgs.yaziPlugins.smart-paste;
    "toggle-pane.yazi".source = pkgs.yaziPlugins.toggle-pane;

    # Arrow: file navigation wraparound
    "arrow.yazi/main.lua".text = /* lua */ ''
      --- @sync entry
      return {
        entry = function(_, job)
          local current = cx.active.current
          local new = (current.cursor + job.args[1]) % #current.files
          ya.mgr_emit("arrow", { new - current.cursor })
        end,
      }
    '';
  };
}
