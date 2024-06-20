const battery = await Service.import("battery")

const icon = battery.bind("percent").as(p =>
  `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

const value = Widget.Revealer({
  child: Widget.Label({
    label: battery.bind("percent").as(p => ` ${p}%`),
  }),

  revealChild: false,
  transitionDuration: 250,
  transition: 'slide_left',
})

const eventbox = Widget.EventBox({
  on_hover: () => {
    value.reveal_child = true;
    Utils.timeout(duration, () => open = true);
  },
  on_hover_lost: () => {
    value.reveal_child = false;
    open = false;
  },
  child: Widget.Box({
    children: [
      Widget.Icon({ icon }),
      value,
    ],
  }),

  // FIXME: Displays the wrong value
  tooltip_text: `Time left: ${battery.time_remaining}`,
})

export default () => Widget.Box({
  class_name: "battery",
  visible: battery.bind("available"),
  child: eventbox,
})
