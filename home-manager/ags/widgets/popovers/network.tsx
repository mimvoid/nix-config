import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import Network from "gi://AstalNetwork";
import Popover from "@lib/widgets/Popover";

const network = Network.get_default();
const wifi = network.wifi;

const { START, END } = Gtk.Align;

const Current = (
  <box className="section current">
    <button
      onClick={() => wifi.enabled = !wifi.enabled}
      tooltipText={bind(wifi, "enabled").as((e) => `Turn ${e ? "off" : "on"} wifi`)}
      cursor="pointer"
    >
      <icon className="big-icon" icon={bind(wifi, "iconName")} />
    </button>
    <box vertical>
      <label label={bind(wifi, "ssid")} halign={START} />
      <label label={bind(wifi, "strength").as((i) => `${i}%`)} halign={START} />
    </box>
  </box>
);

function NetworkPopover() {
  const visible = Variable(false);

  const Widget = (
    <Popover
      className="network-popover popover"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={START}
      halign={END}
      marginTop={28}
      marginRight={12}
    >
      <box vertical>
        {Current}
      </box>
    </Popover>
  )

  return {
    visible: visible,
    Widget: Widget
  }
}

export default NetworkPopover()
