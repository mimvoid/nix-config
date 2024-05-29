{ config, pkgs, ... }:

{
     home.packages = with pkgs; [
        bash-completion
        eza
        disfetch
        fzf
        nh
        nix-bash-completions
        tlrc
    ];

    programs.bash = {
        enable = true;
        enableCompletion = true;
        historyControl = [ "erasedups" "ignoredups" ];
        historyIgnore = [ "ls" "cd" "exit" "yy" ];
        shellAliases = {
            "fuck" = "thefuck";
            "oof" = "thefuck";
            "oops" = "thefuck";
        };
    };

    programs.git = {
        enable = true;
        userName = "mimvoid";
        userEmail = "mimvoid@proton.me";
        extraConfig = {
            init.defaultBranch = "main";
            core.editor = "nvim";
        };
    };

    programs = {
        autojump.enable = true;
        bat.enable = true;
        ripgrep.enable = true;
        thefuck.enable = true;
    };
}
