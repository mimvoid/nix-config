import { execAsync, bind } from "astal";
import { Gtk } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";

import Icon from "@lib/icons";
import { pointer } from "@lib/utils";
import DeviceItem from "./bluetooth/DeviceItem";

const bluetooth = Bluetooth.get_default();
const { START } = Gtk.Align;

function Status() {
  const action = () => execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`);
  const tooltip = bind(bluetooth, "isPowered").as((p) => `Turn ${p ? "off" : "on"} Bluetooth`);

  // Display icon depending on Bluetooth status
  const icon = bind(bluetooth, "isPowered").as((p) =>
    p ? Icon.bluetooth.enabled : Icon.bluetooth.disabled,
  );

  return (
    <box cssClasses={["status", "section"]}>
      <button setup={pointer} onClicked={action} tooltipText={tooltip}>
        <image cssClasses={["big-icon"]} iconName={icon} />
      </button>
      <label label={bind(bluetooth, "isPowered").as((p) => p ? "On" : "Off")} halign={START} />
    </box>
  );
}

const Devices = (forConnected: boolean) => (
  bind(bluetooth, "devices").as((d) => (
    d.map((device) => (
      <DeviceItem
        device={device}
        onClicked={() => execAsync([
          "bluetoothctl",
          forConnected ? "disconnect" : "connect",
          device.address
        ])}
        tooltipText={`${forConnected ? "Disconnect" : "Connect"} device`}
        visible={bind(device, "connected").as((c) => forConnected ? c : !c)}
      />
    ))
  ))
);

function Connected() {
  const DefaultLabel = (
    <label
      label="None connected"
      visible={bind(bluetooth, "isConnected").as((c) => !c)}
      halign={START}
    />
  );

  return (
    <box cssClasses={["section", "connected"]} vertical>
      <label cssClasses={["title"]} label="Connected" halign={START} />
      {DefaultLabel}
      {Devices(true)}
    </box>
  );
}

const Disconnected = (
  <box cssClasses={["section", "disconnected"]} vertical>
    <label cssClasses={["title"]} label="Disconnected" halign={START} />
    {Devices(false)}
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
