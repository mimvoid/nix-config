{
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions = {
      file-browser = {
        enable = true;
        settings.hidden = {file_browser = true; folder_browser = true;};
      };
      fzf-native.enable = true;
		  media-files.enable = true;
	  };
    settings.defaults = {
      initial_mode = "insert";
      file_ignore_patterns = [
        "^.git/"
        "^.mypy_cache/"
        "^__pycache__/"
        "^output/"
        "^data/"
        "%.ipynb"
      ];
      vimgrep_arguments = [
        "rg"
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
      ];

      # Previews
      file_previewer.__raw = "require'telescope.previewers'.vim_buffer_cat.new";
      grep_previewer.__raw = "require'telescope.previewers'.vim_buffer_vimgrep.new";
      qflist_previewer.__raw = "require'telescope.previewers'.vim_buffer_qflist.new";

      # Layout
      sorting_strategy = "descending";
      layout_strategy = "horizontal";
      layout_config = {
        prompt_position = "bottom";
        preview_width = 0.2;
      };

      file_sorter.__raw = "require'telescope.sorters'.get_fuzzy_file";
      generic_sorter.__raw = "require'telescope.sorters'.get_generic_fuzzy_sorter";

      # Prefixes
      prompt_prefix = "> ";
      selection_caret = "> ";
      entry_prefix = "  ";

      set_env.COLORTERM = "truecolor";
      color_devicons = true;

      # Border
      border = {};
      borderchars = [ "─" "│" "─" "│" "╭" "╮" "╯" "╰" ];

      mappings = {
        i = {
          "<A-j>".__raw = "require('telescope.actions').move_selection_next";
          "<A-k>".__raw = "require('telescope.actions').move_selection_previous";
        };
      };
    };
	};
}
