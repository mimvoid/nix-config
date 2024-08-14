{
  programs.navi = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      style = {
        tag = {
          color = "green";
          width_percentage = 5;
          min_width = 5;
        };
        comment = {
          color = "yellow";
          width_percentage = 30;
        };
        snippet = {
          color = "grey";
          width_percentage = 65;
          min_width = 55;
        };
      };

      finder = {
        command = "fzf";
        overrides = "--no-select-1";
      };

      shell = {
        command = "zsh";
        finder_command = "zsh";
      };
    };
  };
}
