import { execAsync, bind } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";

import Icon from "@lib/icons";
import { connectedDevices, disconnectedDevices } from "./bluetooth/DeviceItem";

const bluetooth = Bluetooth.get_default();
const { START, CENTER } = Gtk.Align;

function Status() {
  const action = () =>
    execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`);

  // Display icon depending on Bluetooth status
  const icon = bind(bluetooth, "isPowered").as((p) =>
    p ? Icon.bluetooth.enabled : Icon.bluetooth.disabled,
  );

  return (
    <box cssClasses={["status", "section"]}>
      <button
        setup={(self) => {
          self.set_cursor_from_name("pointer");

          function powerHook() {
            const p = bluetooth.isPowered;
            self.tooltipText = `Turn ${p ? "off" : "on"} Bluetooth`;
            p ? self.remove_css_class("off") : self.add_css_class("on");
          }

          powerHook();
          hook(self, bluetooth, "notify::is-powered", powerHook);
        }}
        cssClasses={["big-toggle"]}
        onClicked={action}
      >
        <image iconName={icon} iconSize={Gtk.IconSize.LARGE} />
      </button>
      <box valign={CENTER} vertical>
        <label
          label={bind(bluetooth, "adapter").as((a) => a.name)}
          halign={START}
        />
        <label
          label={bind(bluetooth, "isPowered").as((p) => (p ? "On" : "Off"))}
          halign={START}
        />
      </box>
    </box>
  );
}

function Connected() {
  const DefaultLabel = <label label="None connected" halign={START} />;

  return (
    <box
      cssClasses={["section", "connected"]}
      vertical
      onDestroy={() => connectedDevices.drop()}
    >
      <label cssClasses={["title"]} label="Connected" halign={START} />
      {bind(connectedDevices).as((d) =>
        d.length == 0 ? DefaultLabel : <box vertical>{d}</box>,
      )}
    </box>
  );
}

const Disconnected = (
  <box
    cssClasses={["section", "disconnected"]}
    vertical
    onDestroy={() => disconnectedDevices.drop()}
  >
    <label cssClasses={["title"]} label="Disconnected" halign={START} />
    <box vertical>{disconnectedDevices()}</box>
  </box>
);

export default (
  <popover cssClasses={["bluetooth-popover"]} hasArrow={false}>
    <box vertical>
      <Status />
      <Connected />
      {Disconnected}
    </box>
  </popover>
);
