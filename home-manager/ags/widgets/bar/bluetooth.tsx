import { execAsync, bind } from "astal";
import { Gtk } from "astal/gtk3";
import Bluetooth from "gi://AstalBluetooth";
import Icon from "../../lib/icons";

const bluetooth = Bluetooth.get_default();

function Indicator() {
  // Show the Bluetooth status

  // Execute `bluetooth off` or `bluetooth on`
  function action() {
    execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`);
  }

  // Show Bluetooth status on hover
  const tooltip = bind(bluetooth, "isPowered").as(
    (p) => `Bluetooth ${p ? "on" : "off"}`,
  );

  // Display icon depending on Bluetooth status
  const icon = bind(bluetooth, "isPowered").as((p) =>
    p ? Icon.bluetooth.enabled : Icon.bluetooth.disabled,
  );

  return (
    <button onClicked={action} tooltipText={tooltip} cursor="pointer">
      <icon icon={icon} />
    </button>
  );
}

function BluetoothBox() {
  // Show connected device names

  const Devices = bind(bluetooth, "devices").as((d) =>
    d.map((device) => (
      <label label={device.alias} visible={bind(device, "connected")} />
    )),
  );

  const DefaultLabel = (
    <label
      label="None connected"
      visible={bind(bluetooth, "isConnected").as((c) => !c)}
    />
  );

  const Rev = (
    <revealer
      transitionDuration={250}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
    >
      <box>
        {DefaultLabel}
        {Devices}
      </box>
    </revealer>
  );

  return (
    <eventbox
      onHover={() => (Rev.revealChild = true)}
      onHoverLost={() => (Rev.revealChild = false)}
    >
      <box>
        {Rev}
        <Indicator />
      </box>
    </eventbox>
  );
}

export default function BluetoothWidget() {
  return (
    <box className="bluetooth">
      <BluetoothBox />
    </box>
  );
}
