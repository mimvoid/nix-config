import { execAsync } from "astal";
import { hook } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";

import BluetoothPopover from "../popovers/bluetooth";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import Icon from "@lib/icons";

const bluetooth = Bluetooth.get_default();

// Show the Bluetooth status
const Indicator = (
  <button
    setup={(self) => {
      self.set_cursor_from_name("pointer");

      function poweredHook() {
        const p = bluetooth.isPowered;
        self.tooltipText = `Bluetooth ${p ? "on" : "off"}`;
        self.iconName = Icon.bluetooth[p ? "enabled" : "disabled"];
      }

      poweredHook();
      hook(self, bluetooth, "notify::is-powered", poweredHook);
    }}
    onClicked={() =>
      execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`)
    }
  />
);

function BluetoothBox() {
  // Show first connected device name
  const DeviceName = (
    <label
      setup={(self) => {
        function connectHook() {
          if (!bluetooth.is_connected) {
            self.label = "None connected";
          } else {
            const firstConnected = bluetooth.devices.find((d) => d.connected)!;
            self.label = firstConnected.alias;
          }
        }

        connectHook();
        hook(self, bluetooth, "notify::is-connected", connectHook);
      }}
    />
  );

  return (
    <menubutton>
      <HoverRevealer hiddenChild={DeviceName}>{Indicator}</HoverRevealer>
      {BluetoothPopover}
    </menubutton>
  );
}

export default () => (
  <box cssClasses={["bluetooth"]}>
    <BluetoothBox />
  </box>
);
