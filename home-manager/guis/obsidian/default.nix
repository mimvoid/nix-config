{ flakePath, pkgs, config, ... }:

{
  home.packages = [ pkgs.unstable.obsidian ];

  home.file =
    let
      vault-dir = "Documents/Zettelkasten";
      symlink = src: {
        source = config.lib.file.mkOutOfStoreSymlink "${flakePath}/home-manager/guis/obsidian/${src}";
      };
    in
    {
      # CSS snippets
      "${vault-dir}/.obsidian/snippets" = symlink "css";
      "${vault-dir}/.obsidian.vimrc" = symlink ".obsidian.vimrc";
    };
}
