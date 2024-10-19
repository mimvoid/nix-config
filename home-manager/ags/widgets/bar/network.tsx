import { exec, bind } from "astal"
import { Gtk } from "astal/gtk3"
import Network from "gi://AstalNetwork"

const network = Network.get_default()

const Icon = <button
  cursor="pointer"
  onClicked={() => exec("networkmanager_dmenu")} >
    <icon
      className="wifi"
      cursor="pointer"
      icon={bind(network.wifi, "iconName")}
    />
  </button>

function Label() {
//  state = bind(network.wifi, "state")
//   active = state ==

  return <label
    // visible={active.as(Boolean)}
    label={bind(network.wifi, "ssid").as(String)}
  />
}

const Revealer = <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} >
      <Label />
  </revealer>

const NetworkBox = <eventbox
  onHover={() => Revealer.revealChild = true}
  onHoverLost={() => Revealer.revealChild = false} >
    <box>
      {Icon}
      {Revealer}
    </box>
  </eventbox>

export default function Wifi() {
  return <box
    className="network"
    tooltipText={bind(network.wifi, "strength").as((i) => `${i}%`)} >
      {NetworkBox}
  </box>
}
