import Bar from "./bar/main.ts";

App.config({
  style: `/tmp/style.css`,
  windows: [
    Bar(),
  ],
})

export {};
