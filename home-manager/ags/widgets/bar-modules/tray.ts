const systemtray = await Service.import("systemtray")

// Contains the system tray applets to ignore
const ignore = [
  "nm-applet", // there's already network module
];

// Makes a button for each system tray item
const tray_items = (item: TrayItem) => Widget.Button({
  class_name: "system-tray",
  child: Widget.Icon({ icon: item.bind("icon") }),

  cursor: "pointer",
  on_primary_click: (_, event) => item.activate(event),
  on_secondary_click: (_, event) => item.openMenu(event),
  
  tooltip_markup: item.bind("tooltip_markup"),

  // Shows what the item is called
  tooltip_text: item.bind('title'),
})

export default () => Widget.Box()
  .bind("children", systemtray, "items", i => i
    .filter(({ id }) => !ignore.includes(id))
    .map(tray_items))
