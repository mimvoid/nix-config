{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        # zsh
        zsh
        zsh-z
        zsh-autopair
        zsh-syntax-highlighting
        pure-prompt

        # Nix integrations
        zsh-nix-shell
        nix-zsh-completions
        nh

        # misc
        eza
        disfetch
        fzf
        tlrc
    ];

    programs.bash = {
        enable = true;
        #enableCompletion = true;
        historyControl = [ "erasedups" "ignoredups" ];
        historyIgnore = [ "ls" "cd" "exit" "ya" ];
    };

    programs.zsh = {
        enable = true;
        dotDir = "zsh";
        history = {
            path = "$HOME/zsh/.zsh_history";
            ignoreDups = true;
            ignorePatterns = [ "ls" "eza" "exit" "ya" ];
            ignoreSpace = true;
        };
        shellAliases = {
            gco = "git checkout";
            gpull = "git pull";
            gpush = "git push";
            ga = "git add";

            nhh = "nh home switch ~/NixOS";
            nhos = "nh os switch ~/NixOS";

            fuck = "thefuck";
            oof = "thefuck";
            oops = "thefuck";
        };
        syntaxHighlighting = {
            enable = true;
        };
        completionInit = " autoload -U compinit && compinit";
        initExtra = "
            # Changes the prompt
             prompt pure

            # Adds plugins
             source $HOME/zsh/plugins/zsh-autopair/share/zsh/zsh-autopair/autopair.zsh
             source $HOME/zsh/plugins/zsh-z/share/zsh-z/zsh-z.plugin.zsh
             zstyle ':completion:*' menu select
        ";
        plugins = [
            {
                name = "zsh-z";
                src = pkgs.zsh-z;
            }
            {
                name = "zsh-autopair";
                src = pkgs.zsh-autopair;
            }
        ];
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
        bat.enable = true;
        ripgrep.enable = true;
        thefuck.enable = true;
        thefuck.enableZshIntegration = true;
    };
}
