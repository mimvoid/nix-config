import { bind } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Network from "gi://AstalNetwork";

const network = Network.get_default();
const wifi = network.wifi;

const { START, CENTER } = Gtk.Align;

const Current = (
  <box cssClasses={["section", "current"]}>
    <button
      setup={(self) => {
        self.set_cursor_from_name("pointer");

        function enabledHook() {
          const e = wifi.enabled;
          self.tooltipText = `Turn ${wifi.enabled ? "off" : "on"} wifi`;
          e ? self.remove_css_class("off") : self.add_css_class("off");
        }

        enabledHook();
        hook(self, wifi, "notify::enabled", enabledHook);
      }}
      cssClasses={["big-toggle"]}
      onClicked={() => (wifi.enabled = !wifi.enabled)}
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
