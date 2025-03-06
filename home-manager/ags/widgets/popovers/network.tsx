import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Network from "gi://AstalNetwork";
import { pointer } from "@lib/utils";

const network = Network.get_default();
const wifi = network.wifi;

const { START } = Gtk.Align;

const Current = (
  <box cssClasses={["section", "current"]}>
    <button
      setup={pointer}
      onClicked={() => wifi.enabled = !wifi.enabled}
      tooltipText={bind(wifi, "enabled").as((e) => `Turn ${e ? "off" : "on"} wifi`)}
    >
      <image cssClasses={["big-icon"]} iconName={bind(wifi, "iconName")} />
    </button>
    <box vertical>
      <label label={bind(wifi, "ssid")} halign={START} />
      <label label={bind(wifi, "strength").as((i) => `${i}%`)} halign={START} />
    </box>
  </box>
);

export default (
  <popover cssClasses={["network-popover"]} hasArrow={false}>
    <box vertical>
      {Current}
    </box>
  </popover>
);
