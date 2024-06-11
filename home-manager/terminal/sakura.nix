{
  xdg.configFile."sakura/sakura.conf" = {
    enable = true;
    text = '' # conf
      [sakura]

      # Colors
      colorset1_fore=rgb(202,211,245)
      colorset1_curs=rgb(202,211,245)
      colorset2_back=rgba(36,39,58,1)
      colorset1_scheme=1
      colorset1_key=F1
      last_colorset=1

      palette=1

      # Font
      font=SauceCodePro Nerd Font,monospace 14
      bold_is_bright=false
      scroll_lines=4096
      cursor_type=VTE_CURSOR_SHAPE_BLOCK

      # Tabs
      show_tab_bar=multiple
      tabs_on_bottom=false
      disable_numbered_tabswitch=true
      scrollable_tabs=false

      #Bell
      urgent_bell=No
      audible_bell=No

      scrollbar=false
      closebutton=true
      less_questions=false
      copy_on_select=false
      use_fading=false
      word_chars=-,./?%&#_~:

      # Accelerators?
      add_tab_accelerator=5
      del_tab_accelerator=5
      switch_tab_accelerator=8
      move_tab_accelerator=9
      copy_accelerator=5
      scrollbar_accelerator=5
      open_url_accelerator=5
      font_size_accelerator=4
      set_tab_name_accelerator=5
      search_accelerator=5
      set_colorset_accelerator=5

      # Keymaps
      add_tab_key=T
      del_tab_key=W
      prev_tab_key=Left
      next_tab_key=Right
      
      copy_key=C
      paste_key=V
      
      scrollbar_key=S
      set_tab_name_key=N
      search_key=F
      
      increase_font_size_key=plus
      decrease_font_size_key=minus
      
      fullscreen_key=F11

      icon_file=terminal-tango.svg
      
      # Buttons?
      paste_button=2
      menu_button=3

      window_columns=80
      window_rows=24
    '';
  };
}
