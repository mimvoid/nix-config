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
      { on = "T"; run = "plugin max-preview"; }

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

  xdg.configFile =
    let
      inherit (pkgs.voids.yaziPlugins)
        plugins
        bookmarks
        exifaudio;
    in
    pkgs.voids.lib.prependAttrs "yazi/plugins/"
    {
      "bookmarks.yazi".source = bookmarks;
      "exifaudio.yazi".source = exifaudio;

      # Smart paste: paste files without entering directory
      "smart-paste.yazi/main.lua".text = /* lua */ ''
        --- @sync entry
        return {
          entry = function()
            local h = cx.active.current.hovered
            if h and h.cha.is_dir then
              ya.mgr_emit("enter", {})
              ya.mgr_emit("paste", {})
              ya.mgr_emit("leave", {})
            else
              ya.mgr_emit("paste", {})
            end
          end,
        }
      '';

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
    }
    // {
      "yazi/plugins" = {
        source = plugins;
        recursive = true;
      };
    };
}
