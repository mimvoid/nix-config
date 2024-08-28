{
	programs.nixvim.plugins.treesitter = {
	  enable = true;
	  indent = true;
    folding = true;

	  nixGrammars = true;
    nixvimInjections = true;
  };
}
