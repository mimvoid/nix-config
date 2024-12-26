import { App } from "astal/gtk3";

App.add_icons(`${SRC}/assets`);

export default {
  bluetooth: {
    enabled: "bluetooth-active-symbolic",
    disabled: "bluetooth-disabled-symbolic",
  },

  brightness: {
    levels: {
      low: 'brightness-low-symbolic',
      medium: 'brightness-medium-symbolic',
      high: 'brightness-high-symbolic',
    }
  },

  calendar: "x-office-calendar",
  colorpicker: "color-select-symbolic",

  cpu: "cpu-symbolic",
  disk: "drive-harddisk-symbolic",
  memory: "memory-symbolic",

  hider: "pan-start-symbolic",

  music: "audio-x-generic-symbolic",
  mpris: {
    start: "media-playback-start-symbolic",
    stop: "media-playback-stop-symbolic",
    pause: "media-playback-pause-symbolic",
    forward: "media-seek-forward-symbolic",
    backward: "media-seek-backward-symbolic",
    shuffle: "media-playlist-shuffle-symbolic",
    repeat: "media-playlist-repeat-symbolic",
    repeatSong: "media-playlist-repeat-song-symbolic",
  },

  overview: "emblem-favorite-symbolic",

  powermenu: {
    indicator: "system-shutdown-symbolic",
    lock: "system-lock-screen-symbolic",
    logout: "system-log-out-symbolic",
    reboot: "view-refresh-symbolic",
    shutdown: "system-shutdown-symbolic",
  },

  wlsunset: {
    on: "display-brightness-symbolic",
    off: "weather-few-clouds-night-symbolic"
  },
};
