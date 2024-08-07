{ config, ... }:

{
  programs.ncmpcpp = {
    enable = true;

    settings = {
      lyrics_directory = "~/.config/ncmpcpp/lyrics";

      user_interface = "alternative";

      # Song list:    cyan time  title  artist
      song_list_format = "{$7%l$9}{%t}$R{%a}";
      # Song status:  bold cyan title or filename - artist
      song_status_format = "{$b$7%t$9$/b - }|{$7%f$9 - }{%a}";
      # Song columns: cyan time | white title or filename | right-aligned yellow artist
      song_columns_list_format = "(30)[yellow]{ar} (50)[white]{t|f:Title} (20)[cyan]{l}";

      now_playing_prefix = "$b$5";
      now_playing_suffix = "$/b$9";

      current_item_prefix = "$b>\ ";
      current_item_suffix = "$/b";

      progressbar_look = "━━";

      autocenter_mode = "yes";
      centered_cursor = "yes";

      header_text_scrolling = "no";
      cyclic_scrolling = "yes";

      external_editor = "nvim";

      titles_visibility = "no";
      playlist_shorten_total_times = "yes";
      statusbar_time_color = "default";
      player_state_color = "default";
    };

    bindings = let
      bind = key: command: {
        inherit key;
        inherit command;
      };
    in [
      # Navigation
      (bind "k"     "scroll_up")
      (bind "j"     "scroll_down")
      (bind "h"     "previous_column")
      (bind "l"     "next_column")

      (bind "up"    "scroll_up")
      (bind "down"  "scroll_down")
      (bind "left"  "previous_column")
      (bind "right" "next_column")

      # Pages
      (bind "?"     "show_help")
    ];
  };

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";

    network = {
      startWhenNeeded = true;
      listenAddress = "any";
    };

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }
    '';
  };
}
