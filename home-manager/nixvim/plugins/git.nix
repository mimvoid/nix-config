{
  programs.nixvim.plugins = {
    gitsigns.enable = true;
    neogit = {
      enable = true;
      settings = {
        fetch_after_checkout = true;
        graph_style = "unicode";
        kind = "vsplit";
        integrations.telescope = true;
      };
    };
  };
}
