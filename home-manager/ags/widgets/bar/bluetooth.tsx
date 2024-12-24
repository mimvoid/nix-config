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

  function Devices() {
    return bluetooth
      .get_devices()
      .map((device) => (
        <label label={device.alias} visible={device.connected} />
      ));
  }

  const Rev = (
    <revealer
      transitionDuration={250}
      transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
    >
      <box>{Devices()}</box>
    </revealer>
  );

  return (
    <eventbox
      onHover={() => (Rev.revealChild = true)}
      onHoverLost={() => (Rev.revealChild = false)}
    >
      <box>
        <Indicator />
        {Rev}
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
