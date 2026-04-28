{ pkgs, lib, ... }:

{
  programs.gamemode = {
    enable = true;
    settings.custom =
      let
        notify-send = lib.getExe pkgs.libnotify;
      in
      {
        start = "${notify-send} 'GameMode started'";
        end = "${notify-send} 'GameMode ended'";
      };
  };

  programs.steam.enable = true;
}
