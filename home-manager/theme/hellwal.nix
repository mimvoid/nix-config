{ pkgs, config, ... }:

{
  home.packages = [
    (pkgs.writeShellScriptBin "hellwal" ''
      ${pkgs.lib.getExe pkgs.unstable.hellwal} \
        --static-foreground "#e8dfdd" \
        "$@"
    '')
  ];

  home.file.".cache/wal/colors.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.cacheHome}/hellwal/colors.json";
}
