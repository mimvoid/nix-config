{ config, lib, pkgs, ... }:

# WIP

with lib;

let

  cfg = config.programs.wacomtablet;

in
{
  options = {
    programs.wacomtablet = {
      enable = mkEnableOption ''
        Whether to enable wacomtablet, a GUI for Wacom Tablet drivers that supports different button/pen layout profiles.
      '';

      package = mkOption {
        type = types.package;
        default = pkgs.kdePackages.wacomtablet;
        description = "The wacomtablet package to use.";
        example = literalExpression ''
          pkgs.wacomtablet
        '';
      };
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "programs.wacomtablet" pkgs
        lib.platforms.linux)
    ];

    home.packages = [ cfg.package ];
  };
}
