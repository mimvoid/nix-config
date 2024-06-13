{ pkgs, ... }:

{
  home.packages = [ pkgs.git-secret ];

  programs.git = {
    enable = true;
    userName = "mimvoid";
    userEmail = "mimvoid@proton.me";
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };
}
