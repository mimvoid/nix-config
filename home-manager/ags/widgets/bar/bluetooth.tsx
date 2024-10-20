import { execAsync, bind } from "astal"
import { Gtk } from "astal/gtk3"
import Bluetooth from "gi://AstalBluetooth"
import Icon from "../../lib/icons"

const bluetooth = Bluetooth.get_default()

const Indicator = <button
  onClicked={(_, event) => {
    execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`)
  }}
  tooltipText={(bind(bluetooth, "isPowered").as((i) => `Bluetooth ${i ? "on" : "off"}`))}
  cursor="pointer" >
    <icon icon={
      bind(bluetooth, "isPowered")
        .as((i) => (i ? Icon.bluetooth.enabled : Icon.bluetooth.disabled))
    } />
</button>

// TODO: re-implement Bluetooth active device

//const Devices = <box
//
//</box>

//const Revealer = <revealer
//    transitionDuration={250}
//    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} >
//      <Devices />
//  </revealer>
//
//const BluetoothBox = <eventbox
//  onHover={() => Revealer.revealChild = true}
//  onHoverLost={() => Revealer.revealChild = false} >
//    <box>
//      {Indicator}
//      {Revealer}
//    </box>
//  </eventbox>

export default function BluetoothWidget() {
  return <box
    className="bluetooth" >
    {Indicator}
  </box>
}
