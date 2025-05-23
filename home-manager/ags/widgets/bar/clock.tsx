import { bind } from "astal";
import { Gtk } from "astal/gtk4";

import Calendar from "../popovers/calendar";
import { time } from "@lib/variables";
import { pointer } from "@lib/utils";
import Icon from "@lib/icons";

// Format the date & time
const timeFmt = bind(time).as((t) => t.format("%a · %b %d · %H:%M") || "");

export default () => (
  <menubutton>
    <button
      setup={pointer}
      cssClasses={["clock"]}
      onClicked={() => (Calendar.visible = true)}
      halign={Gtk.Align.CENTER}
    >
      <box>
        <image iconName={Icon.calendar} />
        {timeFmt}
      </box>
    </button>
    {Calendar}
  </menubutton>
);
