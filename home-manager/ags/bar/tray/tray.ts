const systemtray = await Service.import("systemtray")

// TODO: It's able to open a networkmanager menu, but how to theme it?
// TODO: Replace systray nm-applet with network widget

const items = systemtray.bind("items")
  .as(items => items.map(item => Widget.Button({
    child: Widget.Icon({ icon: item.bind("icon") }),
    on_primary_click: (_, event) => item.activate(event),
    on_secondary_click: (_, event) => item.openMenu(event),
    tooltip_markup: item.bind("tooltip_markup"),
    cursor: "pointer",
  })))

export default () => Widget.Box({
  class_name: "system-tray",
  children: items,
})
