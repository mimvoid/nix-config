import Bar from "./widgets/bar";
import Calendar from "./widgets/calendar";
import Notifications from "./widgets/notifications.ts";

App.config({
  style: `/tmp/style/style.css`,
  windows: [
    Bar(),
    Calendar(),
    Notifications(),
  ],
})

export {};
