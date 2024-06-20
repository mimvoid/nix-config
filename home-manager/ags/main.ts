import Bar from "./bar/main.ts";

// TODO: modularize everything

App.config({
  style: "./style.scss",
  windows: [
    Bar(),
  ],
})

export {};
