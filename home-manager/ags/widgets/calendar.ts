const calendar = Widget.Calendar({
  show_day_names: true,
  show_heading: true,
  show_week_numbers: true,
});

const calendar_box = Widget.Box({
  class_name: "calendar",
  child: calendar,
});

// FIX: toggling with reveal_child: false doesn't show the calendar

const calendar_revealer = Widget.Revealer({
  child: calendar_box,
  reveal_child: true,
  transition: "slide_down",
  transition_duration: 200,
  //setup: self => self.hook(App, (_, wname, visible) => {
  //  if (wname === name)
  //    self.reveal_child = true
  //}),
});

export default (monitor: number) =>
  Widget.Window({
    monitor,
    name: "calendar",
    class_name: "calendar-window",
    anchor: ["top"],
    exclusivity: "normal",
    layer: "overlay",
    margins: [2, 0],
    child: calendar_revealer,
  });
