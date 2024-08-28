const battery = await Service.import("battery");

const icon = Widget.Icon({
  icon: battery
    .bind("percent")
    .as((p) => `battery-level-${Math.floor(p / 10) * 10}-symbolic`),

  // Sets a class name to a charging battery for styling
  class_name: battery.bind("charging").as((ch) => (ch ? "charging" : "")),

  // Makes it sideways
  css: "-gtk-icon-transform: rotate(90deg);",
});

const value = Widget.Label({
  label: battery.bind("percent").as((p) => `${p}%`),
});

const battery_widget = Widget.Box({
  children: [icon, value],

  // TODO: this displays an absurdly high number of hours when
  // when discharging with a nearly full battery,
  // is it because of upower or something else?

  tooltip_text: battery
    .bind("time-remaining")
    .as((t) => `Time left: ${Math.floor(t / 60)}h ${t % 60}m`),
});

// Uncomment to reveal percentage on hover

//const value = Widget.Revealer({
//  child: Widget.Label({
//    label: battery.bind("percent").as(p => ` ${p}%`),
//  }),
//
//  revealChild: false,
//  transitionDuration: 250,
//  transition: 'slide_left',
//})
//
//const battery_widget = Widget.EventBox({
//  on_hover: () => {
//    value.reveal_child = true;
//    open = true;
//  },
//  on_hover_lost: () => {
//    value.reveal_child = false;
//    open = false;
//  },
//  child: Widget.Box({
//    children: [
//      Widget.Icon({
//        icon,
//        // Sets a class name to a charging battery, for styling
//        class_name: battery.bind('charging').as(ch => ch ? 'charging' : '')
//      }),
//      value,
//    ],
//  }),
//
//  tooltip_text: `Time left: ${battery.time_remaining}`,
//})

export default () =>
  Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    child: battery_widget,
  });
