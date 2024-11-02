{ pkgs, config, ... }:

{
  programs.nixvim.plugins.lsp = {
    enable = true;
    inlayHints = true;

    keymaps = {
      diagnostic = {
        "<leader>j" = "goto_next";
        "<leader>k" = "goto_prev";
      };
      lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };
    };

    servers = {
      bashls = {
        enable = true;
        package = pkgs.unstable.bash-language-server;
      };

      basedpyright = {
        enable = true;
        package = pkgs.unstable.basedpyright;
        settings.basedpyright.analysis.typeCheckingMode = "off";
      };

      marksman.enable = true;

      nixd = {
        enable = true;
        package = pkgs.unstable.nixd;
        settings = {
          formatting.command = null;
          options = let
            flake-path = "(builtins.getFlake \"${config.home.sessionVariables.FLAKE}\")";
          in {
            nixos.expr = "${flake-path}.nixosConfigurations.sirru.options";
            home_manager.expr = "${flake-path}.homeConfigurations.\"zinnia\".options";
          };
        };
      };

      # rust-analyzer = {
      #   enable = true;
      #   installCargo = true;
      #   installRustc = true;
      # };

      texlab = {
        enable = true;
        settings.texlab.chktex.onOpenAndSave = true;
      };

      # ts_ls = {
      #   enable = true;
      #   package = pkgs.unstable.typescript-language-server;
      # };
    };
  };
}
