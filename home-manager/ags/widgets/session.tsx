import { exec } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import Icon from "@lib/icons";

function Session() {
  const { START, END, FILL } = Gtk.Align;

  const ButtonGrid = new Gtk.Grid({
    halign: FILL,
    valign: FILL,
    hexpand: true,
    vexpand: true,
    visible: true,
  });

  const actions = {
    lock: {
      command: "hyprlock",
      halign: END,
      valign: END,
    },
    logout: {
      command: "hyprctl dispatch exit",
      halign: END,
      valign: START,
    },
    reboot: {
      command: "systemctl reboot",
      halign: START,
      valign: END,
    },
    shutdown: {
      command: "systemctl poweroff",
      halign: START,
      valign: START,
    },
  };

  for (const action of ["lock", "logout", "reboot", "shutdown"]) {
    const row = actions[action].halign === END ? 1 : 2;
    const column = actions[action].valign === END ? 1 : 2;

    const Button = (
      <button
        halign={actions[action].halign}
        valign={actions[action].valign}
        name={action}
        className="box"
        cursor="pointer"
        onClicked={() => exec(actions[action].command)}
      >
        <icon icon={Icon.powermenu[action]} />
      </button>
    );

    ButtonGrid.attach(Button, row, column, 1, 1);
  }

  return ButtonGrid;
}

export default function SessionMenu() {
  return (
    <window
      name="session"
      className="session"
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
      application={App}
    >
      <Session />
    </window>
  );
}
