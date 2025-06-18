import { exec } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk4";

import Icon from "@lib/icons";
import { setLayerrules } from "@lib/utils";
import { Grid } from "@lib/astalified";

interface Action {
  name: string;
  command: string;
  halign: Gtk.Align;
  valign: Gtk.Align;
}

function Session() {
  const { START, END } = Gtk.Align;

  const ButtonGrid = (
    <Grid
      rowHomogeneous={true}
      columnHomogeneous={true}
      columnSpacing={2}
      rowSpacing={2}
    />
  ) as Gtk.Grid;

  const actions: Action[] = [
    {
      name: "lock",
      command: "hyprlock",
      halign: END,
      valign: END,
    },
    {
      name: "logout",
      command: "hyprctl dispatch exit",
      halign: END,
      valign: START,
    },
    {
      name: "reboot",
      command: "systemctl reboot",
      halign: START,
      valign: END,
    },
    {
      name: "shutdown",
      command: "systemctl poweroff",
      halign: START,
      valign: START,
    },
  ];

  for (const { name, command, halign, valign } of actions) {
    const Button = (
      <button
        setup={(self) => self.set_cursor_from_name("pointer")}
        name={name}
        cssClasses={["box"]}
        halign={halign}
        valign={valign}
        onClicked={() => exec(command)}
        iconName={Icon.powermenu[name]}
      />
    );

    const cell = (align: Gtk.Align) => (align === END ? 1 : 2);

    ButtonGrid.attach(Button, cell(halign), cell(valign), 1, 1);
  }

  return ButtonGrid;
}

export default () => (
  <window
    setup={(self) =>
      setLayerrules(self.namespace, [
        "animation popin 75%",
        "blur",
        "ignorezero",
        "xray 0",
      ])
    }
    name="session"
    namespace="session"
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
