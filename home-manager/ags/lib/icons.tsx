import { App } from "astal";

const Icon = {
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
  overview: "nix-snowflake-symbolic",

  powermenu: {
    indicator: "system-shutdown-symbolic",
    lock: "system-lock-screen-symbolic",
    logout: "system-log-out-symbolic",
    restart: "view-refresh-symbolic",
    shutdown: "system-shutdown-symbolic",
  },

  wlsunset: "display-brightness-symbolic",
};

export default Icon;

App.add_icons(`${SRC}/assets`);
