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
}
