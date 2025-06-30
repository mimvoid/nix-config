{ flakePath, config, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${flakePath}/home-manager/terminal/starship/starship.toml";
}
