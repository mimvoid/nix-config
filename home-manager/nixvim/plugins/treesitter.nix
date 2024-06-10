{
	programs.nixvim.plugins = {
    treesitter = {
	    enable = true;
	    indent = true;
	    nixGrammars = true;
      nixvimInjections = true;

      ensureInstalled = [
        "bash"
        "c"
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
        "javascript"
        "latex"
        "lua"
        "markdown"
        "markdown_inline"
        "nix"
        "scss"
        "typescript"
        "yaml"
        "yuck"
      ];
    };
    treesitter-textobjects = {
      enable = true;
    };
  };
}
