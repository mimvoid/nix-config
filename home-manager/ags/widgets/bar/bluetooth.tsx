import { execAsync, bind } from "astal";
import Bluetooth from "gi://AstalBluetooth";

import BluetoothPopover from "../popovers/bluetooth";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import Icon from "@lib/icons";
import { pointer } from "@lib/utils";

const bluetooth = Bluetooth.get_default();

function Indicator() {
  // Show the Bluetooth status

  // Execute `bluetooth off` or `bluetooth on`
  const action = () =>
    execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`);

  // Show Bluetooth status on hover
  const tooltip = bind(bluetooth, "isPowered").as(
    (p) => `Bluetooth ${p ? "on" : "off"}`,
  );

  // Display icon depending on Bluetooth status
  const icon = bind(bluetooth, "isPowered").as((p) =>
    p ? Icon.bluetooth.enabled : Icon.bluetooth.disabled,
  );

  return (
    <button
      setup={pointer}
      onClicked={action}
      tooltipText={tooltip}
      iconName={icon}
    />
  );
}

function BluetoothBox() {
  // Show first connected device name
  function Device() {
    if (bind(bluetooth, "isConnected").as((c) => !c)) {
      return <label label="None connected" />;
    }

    return bind(bluetooth, "devices").as((d) => {
      const first = d.filter((device) => device.connected)[0];
      return <label label={first.alias} visible={bind(first, "connected")} />;
    });
  }

  return (
    <menubutton>
      <HoverRevealer
        hiddenChild={<box>{Device()}</box>}
        onClicked={() => (BluetoothPopover.visible = true)}
      >
        <Indicator />
      </HoverRevealer>
      {BluetoothPopover}
    </menubutton>
  );
}

export default () => (
  <box cssClasses={["bluetooth"]}>
    <BluetoothBox />
  </box>
);
