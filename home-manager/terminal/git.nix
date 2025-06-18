{
  programs.git = {
    enable = true;
    userName = "mimvoid";
    userEmail = "mimvoid@proton.me";
    ignores = [ "__pycache__/" ];
    extraConfig.init.defaultBranch = "main";

    diff-so-fancy = {
      enable = true;
      stripLeadingSymbols = false;
      markEmptyLines = false;
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        scrollPastBottom = false;
        showRandomTip = false;
        showListFooter = false;
        showPanelJumps = false;
        filterMode = "fuzzy";
        showDivergenceFromBaseBranch = "onlyArrow";
        statusPanelView = "allBranchesLog";
      };
      git.paging.pager = "diff-so-fancy";
      notARepository = "quit";
    };
  };
}
