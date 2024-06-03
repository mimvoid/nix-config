{ ... }:

{
    programs.nixvim.plugins = {
        lazy.enable = true;
                   
        bufferline = {
            enable = true;
            alwaysShowBufferline = true;
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
    };
}
