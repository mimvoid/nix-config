import Bar from "./widgets/bar";
import Calendar from "./widgets/calendar";

App.config({
  style: `/tmp/style/style.css`,
  windows: [
    Bar(),
    Calendar(),
  ],
})

export {};
