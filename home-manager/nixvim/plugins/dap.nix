{
  programs.nixvim.plugins.dap = {
    enable = true;

    extensions = {
      dap-python.enable = true;
      dap-ui.enable = true;
    };
  };
}
