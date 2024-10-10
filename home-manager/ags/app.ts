import { App } from "astal";
import style from "./style/style.scss";
import Bar from "./widgets/bar";

App.start({
  css: style,
  main: () => App.get_monitors().map(Bar),
});
