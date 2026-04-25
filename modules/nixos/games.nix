{ pkgs, ... }:

{
  programs.gamemode = {
    enable = true;
    settings.custom =
      let
        notify-send = "${pkgs.libnotify}/bin/notify-send";
      in
      {
        start = "${notify-send} 'GameMode started'";
        end = "${notify-send} 'GameMode ended'";
      };
  };

  programs.steam.enable = true;
}
