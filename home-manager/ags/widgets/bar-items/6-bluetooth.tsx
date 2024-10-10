import { Gtk, exec, bind } from "astal"
import Bluetooth from "gi://AstalBluetooth"

const bluetooth = Bluetooth.get_default()

const Indicator = <button
  onClicked={() => bluetooth.bluetooth.isPowered = !bluetooth.bluetooth.isPowered}
  cursor="pointer" >
    <icon icon={bind(bluetooth.bluetooth, "isPowered")} />
</button>

const Devices = <box

</box>

const Revealer = <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} >
      <Devices />
  </revealer>

const BluetoothBox = <eventbox
  onHover={() => Revealer.revealChild = true}
  onHoverLost={() => Revealer.revealChild = false} >
    <box>
      {Indicator}
      {Revealer}
    </box>
  </eventbox>

export default function Bluetooth() {
  return <box
    className="bluetooth" >
    {BluetoothBox}
  </box>
}
