import { bind } from "astal";
import { App, Gtk } from "astal/gtk3";
import { time } from "../../lib/variables";
import Icon from "../../lib/icons";

export default function Clock() {
  // Format the date & time
  const timeFmt = bind(time).as((t) => t?.format("%a · %b %d · %H:%M") || "")

  return (
    <button
      className="clock"
      onClicked={() => App.toggle_window("calendar")}
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
