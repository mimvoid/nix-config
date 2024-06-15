{ config, lib, pkgs, ... }:

# WIP

with lib;

let

  cfg = config.programs.krita;

  pluginOptions = {
    options = {
      gmic = mkOption {
        description = "Submodule for the Krita GMIC plugin.";
        type = types.submodule gmicOptions;
      };
    };
  };

  gmicOptions = {
    options = {
      enable = mkEnableOption ''
        Whether to enable the Krita GMIC plugin.
      '';

      package = {
        type = types.package;
        default = pkgs.krita-plugin-gmic;
        description = "The Krita GMIC plugin package to use.";
      };
    };
  };

in
{
  meta.maintainers = with maintainers; [ mimvoid ];

  options = {
    programs.krita = {
      enable = mkEnableOption ''
        Whether to enable Krita, a free and open source painting application.
      '';

      package = mkOption {
        type = types.package;
        default = pkgs.krita;
        description = "The Krita package to use.";
      };

      theme = mkOption {
        type = types.str;
        default = "";
        description = "The theme for Krita.";
        example = literalExpression ''
          "Catppuccin Mocha"
        '';
      };

      plugins = mkOption { 
        type = types.submodule pluginOptions;
        description = "Submodule for Krita plugins.";
        example = literalExpression ''
          {
            gmic = {
              enable = true;
              package = pkgs.krita-plugin-gmic;
            };
          }
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "programs.krita" pkgs
        lib.platforms.linux)
    ];

    home.packages = [ cfg.package ];
  };
}
