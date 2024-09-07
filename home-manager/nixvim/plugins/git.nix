{
  programs.nixvim.plugins = {
    fugitive.enable = true;
    gitsigns.enable = true;

    lazygit = {
      enable = true;
      settings = {
        config_file_path = [ ];
        use_custom_config_file_path = false;
        use_neovim_remote = true;

        floating_window_border_chars = [ "╭" "─" "╮" "│" "╯" "─" "╰" "│" ];
        floating_window_scaling_factor = 0.9;
        floating_window_use_plenary = false;
        floating_window_winblend = 0;
      };
    };
  };
}
