let
  homescreen-1 = "${../../wallpapers/bakairis_rainy-world.png}";
  homescreen-2 = "${../../wallpapers/alena-aenami_endless.jpg}";
in
{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;

      preload = [
        "${homescreen-1}"
        "${homescreen-2}"
      ];
      wallpaper = [
        "monitor,${homescreen-1}"
        "monitor,${homescreen-2}"
      ];
    };
  };
}
