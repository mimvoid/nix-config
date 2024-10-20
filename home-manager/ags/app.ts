import { App } from "astal/gtk3";
import style from "./style/style.scss";
import Bar from "./widgets/bar/Bar";
import Calendar from "./widgets/calendar";

App.start({
  css: style,
  main() {
    App.get_monitors().map(Bar);
    App.get_monitors().map(Calendar);
  },
});
