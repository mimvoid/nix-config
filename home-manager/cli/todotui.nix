{ config, pkgs, ... }:
let
  config-file = pkgs.writeText "todotui-config.yaml" /* yaml */ ''
    default_todo_file: ${config.xdg.userDirs.documents}/todo.txt
    ui:
      left_pane_ratio: 0.25
      vertical_padding: 3
  '';

  todotui = pkgs.writeShellScriptBin "todotui" ''
    ${pkgs.lib.getExe pkgs.voids.todotui} --config ${config-file} "$@"
  '';
in
{
  home.packages = [ todotui ];
}
