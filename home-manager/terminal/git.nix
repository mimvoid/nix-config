{
  programs.git = {
    enable = true;
    userName = "mimvoid";
    userEmail = "mimvoid@proton.me";
    ignores = [
      "result/"
      "__pycache__/"
    ];
    extraConfig = {
      init.defaultBranch = "main";
      core.editor = "nvim";
    };
  };

  programs.lazygit.enable = true;
}
