{
	programs.nixvim.plugins = {
    treesitter = {
	    enable = true;
	    indent = true;
	    nixGrammars = true;
      nixvimInjections = true;

      ensureInstalled = [
        "bash"
        "comment"
        "css"
        "git_config"
        "git_rebase"
        "gitattributes"
        "gitcommit"
        "gitignore"
        "html"
        "hyprlang"
        "ini"
        "latex"
        "lua"
        "markdown"
        "markdown_inline"
        "nix"
        "scss"
        "yaml"
        "yuck"
      ];
    };
    treesitter-textobjects = {
      enable = true;
    };
  };
}
