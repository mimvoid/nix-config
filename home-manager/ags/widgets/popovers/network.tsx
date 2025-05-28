import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Network from "gi://AstalNetwork";

const network = Network.get_default();
const wifi = network.wifi;

const { START, CENTER } = Gtk.Align;

const Current = (
  <box cssClasses={["section", "current"]}>
    <button
      setup={(self) => self.set_cursor_from_name("pointer")}
      cssClasses={bind(wifi, "enabled").as((e) => [
        "big-toggle",
        e ? "on" : "off",
      ])}
      onClicked={() => (wifi.enabled = !wifi.enabled)}
      tooltipText={bind(wifi, "enabled").as(
        (e) => `Turn ${e ? "off" : "on"} wifi`,
      )}
    >
      <image iconName={bind(wifi, "iconName")} iconSize={Gtk.IconSize.LARGE} />
    </button>
    <box valign={CENTER} vertical>
      <label label={bind(wifi, "ssid")} halign={START} />
      <label label={bind(wifi, "strength").as((i) => `${i}%`)} halign={START} />
    </box>
  </box>
);

export default (
  <popover cssClasses={["network-popover"]} hasArrow={false}>
    <box vertical>{Current}</box>
  </popover>
);
