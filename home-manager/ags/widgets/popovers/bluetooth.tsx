import { execAsync, bind, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import Bluetooth from "gi://AstalBluetooth";

import Popover from "@lib/widgets/Popover";
import Icon from "@lib/icons";
import DeviceItem from "./bluetooth/DeviceItem";

const bluetooth = Bluetooth.get_default();
const { START, END } = Gtk.Align;

function Status() {
  const action = () => execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`);
  const tooltip = bind(bluetooth, "isPowered").as((p) => `Turn ${p ? "off" : "on"} Bluetooth`);

  // Display icon depending on Bluetooth status
  const icon = bind(bluetooth, "isPowered").as((p) =>
    p ? Icon.bluetooth.enabled : Icon.bluetooth.disabled,
  );

  return (
    <box className="status section">
      <button onClicked={action} tooltipText={tooltip} cursor="pointer">
        <icon className="big-icon" icon={icon} />
      </button>
      <label label={bind(bluetooth, "isPowered").as((p) => p ? "On" : "Off")} halign={START} />
    </box>
  );
}

function Connected() {
  const Devices = bind(bluetooth, "devices").as((d) =>
    d.filter((device) => device.connected).map((device) =>
      <DeviceItem
        device={device}
        onClick={() => execAsync(["bluetoothctl", "disconnect", device.address])}
        tooltipText="Disconnect device"
      />
  ));

  const DefaultLabel = (
    <label
      label="None connected"
      visible={bind(bluetooth, "isConnected").as((c) => !c)}
      halign={START}
    />
  );

  return (
    <box className="section connected" vertical>
      <label className="title" label="Connected" halign={START} />
      {DefaultLabel}
      {Devices}
    </box>
  );
}

function Disconnected() {
  const Devices = bind(bluetooth, "devices").as((d) =>
    d.filter((device) => !device.connected).map((device) =>
      <DeviceItem
        device={device}
        onClick={() => execAsync(["bluetoothctl", "connect", device.address])}
        tooltipText="Connect device"
      />
  ));

  return (
    <box className="section disconnected" vertical>
      <label className="title" label="Disconnected" halign={START} />
      {Devices}
    </box>
  );
}

function BluetoothPopover() {
  const visible = Variable(false);

  const Widget = (
    <Popover
      className="bluetooth-popover popover"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={START}
      halign={END}
      marginTop={28}
      marginRight={12}
    >
      <box vertical>
        <Status />
        <Connected />
        <Disconnected />
      </box>
    </Popover>
  )

  return {
    visible: visible,
    Widget: Widget
  }
}

export default BluetoothPopover()
