{ pkgs, ... }:

{
  home.packages = [ pkgs.lazygit ];

  programs.git = {
    enable = true;
    ignores = [ "__pycache__/" ];
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "mimvoid";
        email = "mimvoid@proton.me";
      };
    };
  };

  programs.diff-so-fancy = {
    enable = true;
    enableGitIntegration = true;
    settings = {
      stripLeadingSymbols = false;
      markEmptyLines = false;
    };
  };

  xdg.configFile."lazygit/config.yml".text = # yaml
    ''
      gui:
        scrollPastBottom: false
        showRandomTip: false
        showListFooter: false
        showPanelJumps: false
        filterMode: fuzzy
        showDivergenceFromBaseBranch: onlyArrow
        statusPanelView: allBranchesLog
      git:
        pagers:
          - pager: diff-so-fancy
      notARepository: quit
    '';
}
