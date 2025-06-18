import { bind } from "astal";
import { Gtk } from "astal/gtk4";

import Calendar from "../popovers/calendar";
import { time } from "@lib/variables";
import Icon from "@lib/icons";
import { pointer } from "@lib/utils";

export default () => (
  <menubutton setup={pointer}>
    <box cssClasses={["clock"]} halign={Gtk.Align.CENTER}>
      <image iconName={Icon.calendar} />
      <label
        label={bind(time).as((t) => t.format("%a · %b %d · %H:%M") || "")}
      />
    </box>
    {Calendar}
  </menubutton>
);
