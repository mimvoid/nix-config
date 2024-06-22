const month = Variable("", {
  poll: [1000, 'date "+%b"'],
})

const clock = Variable("", {
  poll: [1000, 'date "+%H:%M"'],
})

const week_day = Variable("", {
  poll: [1000, 'date "+%A"'],
})

const day = Variable("", {
  poll: [1000, 'date "+%d'],
})

function Clock() {
  return Widget.Overlay ({
    child: Widget.Label({
      class_name: "day",
      label: day,
    }),
    overlays: [
      Widget.Label({
        class_name: "clock",
        label: clock,
      }),
      Widget.Label({
        class_name: "month",
        label: month
      }),
      Widget.Label({
        class_name: "week-day",
        label: week_day,
      }),
    ],
  })
}

export default (monitor: number) => Widget.Window({
  monitor,
  name: "ageo-style-clock",
  class_name: "ageo",
  exclusivity: "ignore",
  child: Clock(),
})
