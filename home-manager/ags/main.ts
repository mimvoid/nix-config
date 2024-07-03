import Bar from "./widgets/bar";
import Calendar from "./widgets/calendar";
import Notifications from "./widgets/notifications";

App.config({
  style: `/tmp/ags/style/style.css`,
  windows: [
    Bar(),
    Calendar(),
    Notifications(),
  ],
})

export {};
