import { App } from "astal/gtk3";

// Get root stylesheet
import style from "./style/style.scss";

// Get windows
import Bar from "./widgets/bar/bar";
import Calendar from "./widgets/menus/calendar";
import MediaBox from "./widgets/menus/media";
import Dashboard from "./widgets/dashboard/dashboard";
import NotificationPopups from "./widgets/notifications/notificationPopups";
import SessionMenu from "./widgets/session";

App.start({
  css: style,

  requestHandler(request, res) {
    print(request);
    res("ok");
  },

  main() {
    // Map to every monitor
    for (const monitor of App.get_monitors()) {
      Bar(monitor);
      NotificationPopups(monitor);
    }

    Calendar();
    Dashboard();
    MediaBox();
    SessionMenu();
  },
});
