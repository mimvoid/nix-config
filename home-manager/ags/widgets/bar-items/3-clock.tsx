import { Variable, Gtk } from "astal"

const time = Variable<string>("").poll(1000, "date '+%A %b %d / %H:%M'")

export default function Clock() {
  return <button
    className="clock"
    //onClicked=
    cursor="pointer"
    halign={Gtk.Align.CENTER} >
      <box>
        <icon icon="x-office-calendar" />
        <label label={time()} />
      </box>
  </button>
}
