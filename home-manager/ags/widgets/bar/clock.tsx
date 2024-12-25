import { Variable } from "astal";
import { App, Gtk } from "astal/gtk3";
import Icon from "../../lib/icons";

export default function Clock() {
  // Format the date & time
  const time = Variable<string>("").poll(1000, "date '+%a · %b %d · %H:%M'");

  return (
    <button
      className="clock"
      onClicked={() => App.toggle_window("calendar")}
      cursor="pointer"
      halign={Gtk.Align.CENTER}
    >
      <box>
        <icon icon={Icon.calendar} />
        {time()}
      </box>
    </button>
  );
}
