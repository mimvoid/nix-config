{
	programs.nixvim.plugins.treesitter = {
	  enable = true;
	  indent = true;
    folding = true;

	  nixGrammars = true;
    nixvimInjections = true;
  };

  programs.nixvim.plugins.rainbow-delimiters.enable = true;
}
