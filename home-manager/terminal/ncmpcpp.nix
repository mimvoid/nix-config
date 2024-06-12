{ config, pkgs, ... }:

{
  services.mpd = {
    enable = true;
    musicDirectory = config.xdg.UserDirs.music;
    network.startWhenNeeded = true;
  };
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {
      outputsSupport = true;
      visualizerSupport = true;
      clockSupport = true;
      taglibSupport = true;
    };
    settings = {
      browser_sort_mode = "name";

      mouse_list_scroll_whole_page = "yes";
      lines_scrolled = "1";

      playlist_shorten_total_times = "yes";
      
      playlist_display_mode = "classic";
      browser_display_mode = "columns";
      search_engine_display_mode = "columns";
      playlist_editor_display_mode = "columns";

      autocenter_mode = "yes";
      centered_cursor = "yes";

      user_interface = "classic";

      follow_now_playing_lyrics = "yes";

      locked_screen_width_part = "60";
      display_bitrate = "no";

      external_editor = "nvim";

      # Colors
      main_window_highlight_color = "white";
      progressbar_elapsed_color = "white";
      progressbar_color = "black";
      statusbar_color = "white";
      visualizer_color = "white";

      progressbar_look = "▃▃▃";

      visualizer_in_stereo = "no";
      visualizer_fifo_path = "/tmp/mpd.fifo";
      visualizer_output_name = "my_fifo";
      visualizer_sync_interval = "10";
      visualizer_type = "spectrum";
      visualizer_look = "▋▋";

      mouse_support = "yes";
      header_visibility = "no";
      statusbar_visibility = "no";

      titles_visibility = "no";
      enable_window_title = "yes";

      now_playing_prefix = "$b";
      now_playing_suffix = "$8$/b";

      #now_playing_prefix = "$u$2"
      #now_playing_suffix = "$2$/u$2"

      song_columns_list_format = "(6)[]{} (23)[red]{a} (26)[yellow]{t|f} (40)[green]{b} (4)[blue]{l}";

      color1 = "white";
      color2 = "black";

      # Album art
      execute_on_song_change="~/.ncmpcpp/art.sh";
      song_list_format = "                       $2%t $R$5%a ";

      song_status_format = "$b$7♫ $2%a $4⟫$3⟫ $8%t $4⟫$3⟫ $5%b ";
      song_window_title_format = " {%a} - {%t}";
    };
  };
}
