const calendar = Widget.Calendar({
  show_day_names: true,
  //show_details: true,
  show_heading: true,
  show_week_numbers: true,
  //detail: (self, y, m, d) => {
  //  return `<span color="white">${y}. ${m}. ${d}.</span>`
  //},
  on_day_selected: ({ date: [y, m, d] }) => {
    print(`${y}. ${m}. ${d}.`)
  },
})

// FIX: toggling with reveal_child: false doesn't show the calendar

const calendar_box = Widget.Revealer({
  child: calendar,
  reveal_child: true,
  transition: "slide_down",
  transition_duration: 200,
  //setup: self => self.hook(App, (_, wname, visible) => {
  //  if (wname === name)
  //    self.reveal_child = true
  //}),
})

export default (monitor: number) => Widget.Window({
  monitor,
  name: "calendar",
  class_name: "calendar",
  anchor: ["top"],
  exclusivity: "normal",
  layer: "overlay",
  margins: [6, 0],
  child: calendar_box,
})
