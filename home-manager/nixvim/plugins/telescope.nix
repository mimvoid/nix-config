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
        "-L"
        "--color=never"
        "--no-heading"
        "--with-filename"
        "--line-number"
        "--column"
        "--smart-case"
      ];

      # Previews
      previewer = true;
      file_previewer.__raw = "require('telescope.previewers').vim_buffer_cat.new";
      grep_previewer.__raw = "require('telescope.previewers').vim_buffer_vimgrep.new";
      qflist_previewer.__raw = "require('telescope.previewers').vim_buffer_qflist.new";
      buffer_preview_maker.__raw = "require('telescope.previewers').buffer_previewer_maker";

      # Layout
      selection_strategy = "reset";
      sorting_strategy = "descending";
      layout_strategy = "horizontal";
      layout_config = {
        horizontal = {
          prompt_position = "bottom";
          preview_width = 0.4;
        };
        vertical.mirror = false;
        width = 0.8;
        height = 0.8;
        preview_cutoff = 1;
      };

      file_sorter.__raw = "require'telescope.sorters'.get_fuzzy_file";
      generic_sorter.__raw = "require'telescope.sorters'.get_generic_fuzzy_sorter";

      # Prefixes
      prompt_prefix = "> ";
      selection_caret = "> ";
      entry_prefix = "  ";

      # Titles
      prompt_title = "";
      results_title = "";
      dynamic_preview_title = true;

      set_env.COLORTERM = "truecolor";
      disable_devicons = false;
      color_devicons = true;
      use_less = true;
      path_display = ["truncate"];

      # Border
      border.__raw = "{}";
      borderchars = ["─" "│" "─" "│" "╭" "╮" "╯" "╰"];

      mappings = {
        i = {
          "<A-j>".__raw = "require('telescope.actions').move_selection_next";
          "<A-k>".__raw = "require('telescope.actions').move_selection_previous";
        };
      };
      settings.pickers =
      let
        borderchars = ["─" "│" "─" "│" "╭" "╮" "╯" "╰"];
      in
      {
        find_files = { inherit borderchars; };
        live_grep = { inherit borderchars; };
      };
    };
	};
}
