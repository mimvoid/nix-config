import Bar from "./widgets/bar";
import Calendar from "./widgets/calendar";
import Notifications from "./widgets/notifications";

App.config({
  style: `/tmp/ags/style/style.css`,
  // HACK: close windows other than bar and notifications
  onConfigParsed: () => {
    App.closeWindow("calendar");
  },
  windows: [Bar(), Calendar(), Notifications()],
});

export {};
