{ pkgs, config, ... }:
let
  configPath = "${config.voids.lib.flakePath}/home-manager/cli/ohmyposh/config.yaml";

  initConfig =
    shell:
    pkgs.lib.mkAfter ''
      eval "$(oh-my-posh init ${shell} --config '${configPath}')"
    '';
in
{
  home.packages = [ pkgs.unstable.oh-my-posh ];

  programs.bash.initExtra = initConfig "bash";
  programs.zsh.initContent = initConfig "zsh";
}
