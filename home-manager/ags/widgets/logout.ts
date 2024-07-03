// TODO: set default visibility off
// FIX: importing this causes actions to be executed right after

const MenuButton = (cls: string, icon: string, action: string) => Widget.Button({
  class_name: `${cls}`,
  cursor: "pointer", 
  on_clicked: Utils.exec(`${action}`),
  child: Widget.Icon(`${icon}-symbolic`),
})

const lock = MenuButton('lock', 'system-lock-screen', 'hyprlock')
const logout = MenuButton('logout', 'system-log-out', 'hyprctl dispatch exit 0')
const reboot = MenuButton('reboot', 'view-refresh', 'systemctl reboot')
const shutdown = MenuButton('shutdown', 'system-shutdown', 'systemctl poweroff')

const menu_left = Widget.CenterBox({
  vertical: true,
  start_widget: lock,
  end_widget: logout,
})

const menu_right = Widget.CenterBox({
  vertical: true,
  start_widget: reboot,
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
