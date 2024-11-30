import { App } from "astal/gtk3";

// Get root stylesheet
import style from "./style/style.scss";

// Get windows
import Bar from "./widgets/bar/bar";
import Calendar from "./widgets/menus/calendar";
import Dashboard from "./widgets/menus/dashboard";
import MediaBox from "./widgets/menus/media";
import NotificationPopups from "./widgets/notifications/notification-popups"
import SessionMenu from "./widgets/session";


App.start({
  css: style,

  requestHandler: (request, res) => {
    print(request)
    res("ok")
  },

  main: () => {
    // Map to every monitor
    for (const monitor of App.get_monitors()) {
      Bar(monitor)
      NotificationPopups(monitor)
    }

    Calendar()
    Dashboard()
    MediaBox()
    SessionMenu()
  },
})
