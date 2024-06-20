const battery = await Service.import("battery")

const icon = battery.bind("percent").as(p =>
  `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

const get_value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)

const value = Widget.Revealer({
  child: Widget.Label(` ${get_value}`),

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
})

// FIX: battery percentage label does't show up right.

export default () => Widget.Box({
  class_name: "battery",
  visible: battery.bind("available"),
  child: eventbox,
})
