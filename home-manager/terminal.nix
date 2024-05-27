{ config, pkgs, inputs, ... }:

{
    home.packages = with pkgs; [
        # Terminal
        foot

        # Shell tools
        bash
        bash-completion
        autojump
        bat
        eza
        fastfetch
        fzf
        git
        nh
        nix-bash-completions
        ripgrep
        thefuck
        tlrc

        # CLIs
        yazi

        ffmpegthumbnailer
        poppler
        unar
        wl-clipboard
    ];

    programs.foot = {
        enable = true;
    };

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

    programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        settings.manager = {
            show_hidden = true;
            sort_by = "natural";
            sort_dir_first = true;
        };
    };

    programs.nixvim = {
        enable = true;
        defaultEditor = true;
    
    	plugins = {
	        lazy.enable = true;
                   
            bufferline = {
                enable = true;
                alwaysShowBufferline = false;
            };

	        ccc.enable = true;
	        cmp.enable = true;

	        dashboard = {
		        enable = true;
		        hideStatusline = false;
		        hideTabline = true;
            };

            indent-o-matic.enable = true;
	        lint.enable = true;
	        lsp.enable = true;
	        markdown-preview.enable = true;
	        nix.enable = true;
	        nvim-autopairs.enable = true;

	        nvim-tree = {
		        enable = true;
		        hijackCursor = true;
		        hijackUnnamedBufferWhenOpening = true;
		        openOnSetup = true;
	        };

	        telescope = {
	            enable = true;
		        extensions = {
		            file-browser.enable = true;
		            fzf-native.enable = true;
		            media-files.enable = true;
		        };
	        };

	        treesitter = {
	            enable = true;
		        indent = true;
		        nixGrammars = true;
            };

	        trouble = {
	            enable = true;
		        settings.auto_open = true;
	        };

            which-key.enable = true;
        };
	};
}
