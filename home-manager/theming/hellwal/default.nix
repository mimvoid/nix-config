{ pkgs, config, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "hellwal" ''
      ${pkgs.unstable.hellwal}/bin/hellwal \
        --static-foreground "#e8dfdd" \
        "$@"
    '')
  ];

  home.file.".cache/wal/colors.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.cache/hellwal/colors.json";
}
