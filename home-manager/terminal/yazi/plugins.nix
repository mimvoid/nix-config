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
      { on = "k"; run = "plugin arrow --args=-1"; }
      { on = "j"; run = "plugin arrow --args=1"; }

      # Max preview
      { on = "T"; run = "plugin max-preview"; }

      # Bookmarks
      { on = "m"; run = "plugin bookmarks --args=save"; }
      { on = "'"; run = "plugin bookmarks --args=jump"; }
      { on = "`"; run = "plugin bookmarks --args=jump"; }
      { on = [ "b" "d" ]; run = "plugin bookmarks --args=delete"; }
    ];

    plugins = {
      inherit (pkgs.voids.yaziPlugins)
        full-border
        git
        max-preview
        bookmarks
        exifaudio;
    };

    initLua = /* lua */ ''
      require("git"):setup()

      THEME.git = THEME.git or {}
      THEME.git.modified = ui.Style():fg("blue")
      THEME.git.modified_sign = "M"

      THEME.git.added = ui.Style():fg("green")
      THEME.git.added_sign = "A"

      THEME.git.deleted = ui.Style():fg("red")
      THEME.git.deleted_sign = "D"

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
    "yazi/plugins/smart-paste.yazi/init.lua".text = /* lua */ ''
      --- @sync entry
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

    # Arrow: file navigation wraparound
    "yazi/plugins/arrow.yazi/init.lua".text = /* lua */ ''
      --- @sync entry
      return {
        entry = function(_, job)
          local current = cx.active.current
          local new = (current.cursor + job.args[1]) % #current.files
          ya.manager_emit("arrow", { new - current.cursor })
        end,
      }
    '';
  };
}
