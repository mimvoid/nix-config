import GLib from "gi://GLib";

function inPath(program: string) {
  return GLib.find_program_in_path(program) !== null;
}

export default {
  hyprpicker: inPath("hyprpicker"),
  nm_dmenu: inPath("networkmanager_dmenu"),
  notify_send: inPath("notify-send"),
  wl_clipboard: inPath("wl-copy"),
  swww: inPath("swww"),
};
