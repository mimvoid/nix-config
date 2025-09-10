{ pkgs, config, ... }:

{
  home.packages = [ pkgs.unstable.rmpc ];

  services.mpd = {
    enable = true;
    musicDirectory = config.xdg.userDirs.music;
    network.startWhenNeeded = true;
    extraConfig = ''
      audio_output {
        type "pipewire"
        name "My PipeWire Output"
      }
    '';
  };

  services.mpd-mpris.enable = true;

  xdg.configFile =
    let
      inherit (config.voids.lib) symlink;
    in
    {
      "rmpc/config.ron" = symlink "terminal/rmpc/config.ron";
      "rmpc/themes/theme.ron" = symlink "terminal/rmpc/theme.ron";
    };
}
