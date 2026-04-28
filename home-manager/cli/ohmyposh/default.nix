{ pkgs, ... }:
let
  initConfig =
    shell:
    pkgs.lib.mkAfter ''
      eval "$(oh-my-posh init ${shell} --config '${./config.yaml}')"
    '';
in
{
  home.packages = [ pkgs.unstable.oh-my-posh ];

  programs.bash.initExtra = initConfig "bash";
  programs.zsh.initContent = initConfig "zsh";
}
