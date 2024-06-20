export default () => Widget.Button({
  class_name: "power-actions",
  child: Widget.Icon("system-shutdown-symbolic"),
  cursor: "pointer",

  // TODO: replace wlogout with an AGS widget at some point

  on_clicked: () => { Utils.execAsync('wlogout -b 2') },
})
