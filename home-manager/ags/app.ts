import { App } from "astal/gtk3";
import style from "./style/style.scss";
import Bar from "./widgets/bar/Bar";
import Calendar from "./widgets/menus/calendar";
import SessionMenu from "./widgets/session";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Calendar);
    App.get_monitors().map(SessionMenu);
  },
});
