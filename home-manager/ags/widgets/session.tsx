import { exec } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import Icon from "@lib/icons";
import { pointer } from "@lib/utils";

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
        setup={pointer}
        halign={actions[action].halign}
        valign={actions[action].valign}
        name={action}
        cssClasses={["box"]}
        onClicked={() => exec(actions[action].command)}
      >
        <image iconName={Icon.powermenu[action]} />
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
      cssClasses={["session"]}
      visible={false}
      anchor={Astal.WindowAnchor.NONE}
      exclusivity={Astal.Exclusivity.NORMAL}
      layer={Astal.Layer.OVERLAY}
      keymode={Astal.Keymode.EXCLUSIVE}
      onKeyPressed={(_, keyval) => {
        if (keyval === Gdk.KEY_Escape) {
          App.toggle_window("session");
        }
      }}
      application={App}
    >
      {Session()}
    </window>
  );
}
