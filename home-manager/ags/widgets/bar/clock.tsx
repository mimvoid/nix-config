import { bind } from "astal";
import { Gtk } from "astal/gtk3";

import Calendar from "../popovers/calendar";
import { time } from "@lib/variables";
import Icon from "@lib/icons";

export default function Clock() {
  // Format the date & time
  const timeFmt = bind(time).as((t) => t?.format("%a · %b %d · %H:%M") || "")

  return (
    <button
      className="clock"
      onClicked={() => Calendar.visible.set(true)}
      cursor="pointer"
      halign={Gtk.Align.CENTER}
    >
      <box>
        <icon icon={Icon.calendar} />
        {timeFmt}
      </box>
    </button>
  );
}
