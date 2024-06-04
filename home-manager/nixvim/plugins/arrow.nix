{
  programs.nixvim.plugins.arrow = {
    enable = true;
    settings = {
      leader_key = ";";
      save_key = "git_root";
      show_icons = true;
      window = {
        relative = "editor";
        width = "auto";
        height = "auto";
        row = "auto";
        col = "auto";
        style = "minimal";
        border = "rounded";
      };
    };
  };
}
