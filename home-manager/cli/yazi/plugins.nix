{ pkgs, ... }:

{
  programs.yazi = {
    settings.plugin = {
      prepend_previewers = [ { mime = "audio/*"; run = "exifaudio"; } ];
    };

    keymap.mgr.prepend_keymap = [
      # Smart paste plugin
      { on = "p"; run = "plugin smart-paste"; }

      # Max preview
      { on = "T"; run = "plugin toggle-pane max-preview"; }

      # Bookmarks
      { on = "m"; run = "plugin bookmarks save"; }
      { on = "'"; run = "plugin bookmarks jump"; }
      { on = "`"; run = "plugin bookmarks jump"; }
      { on = [ "b" "d" ]; run = "plugin bookmarks delete"; }
      { on = [ "b" "D" ]; run = "plugin bookmarks delete_all"; }
    ];

    initLua = # lua
      ''
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
      inherit (pkgs.yaziPlugins)
        git full-border smart-paste toggle-pane;
    in
    pkgs.voids.lib.prependAttrs "yazi/plugins/" {
      "bookmarks.yazi".source = pkgs.voids.yaziPlugins.bookmarks;
      "exifaudio.yazi".source = pkgs.voids.yaziPlugins.exifaudio;

      "git.yazi".source = git;
      "full-border.yazi".source = full-border;
      "smart-paste.yazi".source = smart-paste;
      "toggle-pane.yazi".source = toggle-pane;
    };
}
