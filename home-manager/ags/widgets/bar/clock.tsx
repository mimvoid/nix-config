import { Variable, Gtk } from "astal"
import Icon from "../../lib/icons"

const time = Variable<string>("").poll(1000, "date '+%A %b %d / %H:%M'")

export default function Clock() {
  return <button
    className="clock"
    //onClicked=
    cursor="pointer"
    halign={Gtk.Align.CENTER} >
      <box>
        <icon icon={Icon.calendar} />
        <label label={time()} />
      </box>
  </button>
}
