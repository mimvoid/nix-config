{
  programs.nixvim.plugins.which-key = {
    enable = true;

    showHelp = false;
    showKeys = true;
    
    plugins = {
      marks = true;
      registers = true;
      spelling.enabled = false;
    };

    layout = {
      spacing = 2;
      align = "left";
    };

    window = {
      border = "rounded";
      winblend = 5;
    };

    popupMappings = {
      scrollDown = "<s-j>";
      scrollUp = "<s-k";
    };
  };
}
