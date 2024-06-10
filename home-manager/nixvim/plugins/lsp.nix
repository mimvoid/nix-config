{
  programs.nixvim.plugins.lsp = {
    enable = true;
    servers = {
      bashls.enable = true;
      ccls.enable = true;
      cssls.enable = true;
      #html.enable = true;
      #java-language-server.enable = true;
      #jsonls.enable = true;
      lua-ls.enable = true;
      marksman.enable = true;
      nil_ls.enable = true;
      #rust-analyzer = {
      #  enable = true;
      #  installCargo = true;
      #  installRustc = true;
      #};
      #tailwindcss.enable = true;
      tsserver.enable = true;
      typos-lsp.enable = true;
      yamlls.enable = true;
    };
  };

  #programs.nixvim.plugins.lsp-lines.enable = true;
}
