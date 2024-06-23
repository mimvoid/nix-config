// TODO: fix repetitive code
// TODO: set default visibility off before importing

const lock = Widget.Button({
  child: Widget.Icon("system-lock-screen-symbolic"),
  cursor: "pointer",
  on_clicked: Utils.exec('hyprlock'),
})

const logout = Widget.Button({
  child: Widget.Icon("system-log-out-symbolic"),
  cursor: "pointer",
  on_clicked: Utils.exec('hyprctl dispatch exit 0'),
})

// Icon can also be system-restart-symbolic
const restart = Widget.Button({
  child: Widget.Icon("view-refresh-symbolic"),
  cursor: "pointer",
  on_clicked: Utils.exec('systemctl rebott'),
})

const shutdown = ({
  child: Widget.Icon("system-shutdown-symbolic"),
  cursor: "pointer",
  on_clicked: Utils.exec('systemctl poweroff'),
})


const menu_left = Widget.CenterBox({
  class_name: "logout-left",
  vertical: true,
  start_widget: lock,
  end_widget: logout,
})

const menu_right = Widget.CenterBox({
  class_name: "logout-right".
  vertical: true,
  start_widget: restart,
  end_widget: shutdown,
})


export default (monitor: number) => Widget.Window({
  monitor,
  name: "logout-menu",
  class_name: "logout",
  anchor: [], // let it be centered
  exclusivity: "normal",
  layer: "overlay",
  children: [ menu_left, menu_right ],
})
