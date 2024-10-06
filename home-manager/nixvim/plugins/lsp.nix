{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      bashls.enable = true;
      # basedpyright.enable = true;
      cssls.enable = true;
      html.enable = true;
      marksman.enable = true;
      nil_ls.enable = true;
      # rust-analyzer = {
      #   enable = true;
      #   installCargo = true;
      #   installRustc = true;
      # };
      # texlab.enable = true;
      # tsserver.enable = true;
      typos-lsp.enable = true;
    };
  };
}
