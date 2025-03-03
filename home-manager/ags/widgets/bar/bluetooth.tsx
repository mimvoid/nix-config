import { execAsync, bind } from "astal";
import Bluetooth from "gi://AstalBluetooth";

import BluetoothPopover from "../popovers/bluetooth";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import Icon from "@lib/icons";

const bluetooth = Bluetooth.get_default();

function Indicator() {
  // Show the Bluetooth status

  // Execute `bluetooth off` or `bluetooth on`
  const action = () => execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`);

  // Show Bluetooth status on hover
  const tooltip = bind(bluetooth, "isPowered").as((p) =>
    `Bluetooth ${p ? "on" : "off"}`
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
  // Show first connected device name
  function Device() {
    if (bind(bluetooth, "isConnected").as((c) => !c)) {
      return <label label="None connected" />;
    }

    return bind(bluetooth, "devices").as((d) => {
      const first = d.filter((device) => device.connected)[0]
      return <label label={first.alias} visible={bind(first, "connected")} />
    })
  }

  return (
    <HoverRevealer
      hiddenChild={<box>{Device()}</box>}
      onClick={() => BluetoothPopover.visible.set(true)}
      cursor="pointer"
    >
      <Indicator />
    </HoverRevealer>
  );
}

export default function BluetoothWidget() {
  return (
    <box className="bluetooth">
      <BluetoothBox />
    </box>
  );
}
