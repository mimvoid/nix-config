import { App } from "astal/gtk3";
import style from "./style/style.scss";
import Bar from "./widgets/bar/bar";
import SessionMenu from "./widgets/session";
import Calendar from "./widgets/menus/calendar";
import Dashboard from "./widgets/menus/dashboard";
import MediaBox from "./widgets/menus/media";
import NotificationPopups from "./widgets/notifications/notification-popups"

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Dashboard);
    App.get_monitors().map(Calendar);
    App.get_monitors().map(SessionMenu);
    App.get_monitors().map(MediaBox);
    App.get_monitors().map(NotificationPopups);
  },
});
