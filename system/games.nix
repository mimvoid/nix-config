{ inputs, pkgs, ... }:

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

  # AAGL
  imports = [
    "${inputs.aagl.outPath}/module/hosts.nix"
  ];

  networking.mihoyo-telemetry.block = true;
  programs.steam.enable = true;
}
