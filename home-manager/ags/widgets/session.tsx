import { exec } from "astal"
import { App, Astal, Gtk, Gdk } from "astal/gtk3"
import Icon from "../lib/icons"

const Button = (action: string) => {
  const command = (() => {
    switch (action) {
      case "lock":
        return "hyprlock";
      case "logout":
        return "hyprctl dispatch exit";
      case "reboot":
        return "systemctl reboot";
      case "shutdown":
        return "systemctl poweroff";
      default:
        return "";
    }
  })();

  const halign = (() => {
    switch (action) {
      case "lock":
        return "END";
      case "logout":
        return "END";
      case "reboot":
        return "START";
      case "shutdown":
        return "START";
      default:
        return "";
    }
  })();

  const valign = (() => {
    switch (action) {
      case "lock":
        return "END";
      case "logout":
        return "START";
      case "reboot":
        return "END";
      case "shutdown":
        return "START";
      default:
        return "";
    }
  })();

  return <button
    halign={Gtk.Align[halign]}
    valign={Gtk.Align[valign]}
    className={`${action} box`}
    cursor="pointer"
    onClicked={() => exec(command)} >
      <icon icon={`${Icon.powermenu[action]}`} />
  </button>
}

const Session = new Gtk.Grid({
  halign: Gtk.Align.FILL,
  valign: Gtk.Align.FILL,
  hexpand: true,
  vexpand: true,
  visible: true,
})

Session.attach(Button("lock"), 1, 1, 1, 1)
Session.attach(Button("logout"), 1, 2, 1, 1)
Session.attach(Button("reboot"), 2, 1, 1, 1)
Session.attach(Button("shutdown"), 2, 2, 1, 1)

export default function SessionMenu(monitor: Gdk.Monitor) {
  return <window
    name="session"
    className="session"
    gdkmonitor={monitor}
    visible={false}
    anchor={Astal.WindowAnchor.NONE}
    exclusivity={Astal.Exclusivity.NORMAL}
    layer={Astal.Layer.OVERLAY}

    keymode={Astal.Keymode.ON_DEMAND}
    onKeyPressEvent={(_, event) => {
      if (event.get_keyval()[1] === Gdk.KEY_Escape) {
        App.toggle_window("session");
      }
    }}

    application={App} >
      {Session}
  </window>
}
