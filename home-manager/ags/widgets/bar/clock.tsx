import { bind } from "astal";
import { Gtk } from "astal/gtk4";

import Calendar from "../popovers/calendar";
import { time } from "@lib/variables";
import Icon from "@lib/icons";

export default () => (
  <menubutton>
    <button
      setup={(self) => self.set_cursor_from_name("pointer")}
      cssClasses={["clock"]}
      onClicked={() => (Calendar.visible = true)}
      halign={Gtk.Align.CENTER}
    >
      <box>
        <image iconName={Icon.calendar} />
        <label
          label={bind(time).as((t) => t.format("%a · %b %d · %H:%M") || "")}
        />
      </box>
    </button>
    {Calendar}
  </menubutton>
);
