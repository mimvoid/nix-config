import { Variable } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";
import Icon from "@lib/icons";

const { START, END } = Gtk.Align;
const bluetooth = Bluetooth.get_default();

export const connectedDevices: Variable<Gtk.Widget[]> = Variable([]);
export const disconnectedDevices: Variable<Gtk.Widget[]> = Variable([]);

bluetooth.get_devices().map((device) => {
  const DeviceInfo = (
    <box cssClasses={["device-info"]} halign={END} />
  ) as Gtk.Box;

  if (device.paired) {
    DeviceInfo.append(
      <image
        iconName={Icon.bluetooth.paired}
        tooltipText="Paired"
      />,
    );
  }

  const DeviceIcon = (<image iconName={device.icon} />) as Gtk.Image;

  return (
    <button
      setup={(self) => {
        self.set_cursor_from_name("pointer");

        function connectHook() {
          const c = device.connected;
          self.tooltipText = `${c ? "Disconnect" : "Connect"} device`;

          const toAddTo = c ? connectedDevices : disconnectedDevices;
          toAddTo.set([...toAddTo.get(), self]);
        }

        connectHook();

        hook(self, device, "notify::connected", () => {
          connectHook();

          const toRemoveFrom = device.connected
            ? disconnectedDevices
            : connectedDevices;
          toRemoveFrom.set(toRemoveFrom.get().filter((d) => d !== self));
        });
      }}
      cssClasses={["device"]}
      onClicked={() => {
        if (device.connecting) return;

        DeviceIcon.iconName = Icon.waiting;
        const callback = () => (DeviceIcon.iconName = device.icon);

        device.connected
          ? device.disconnect_device(callback)
          : device.connect_device(callback);
      }}
    >
      <box widthRequest={180}>
        {DeviceIcon}
        <label label={device.alias} halign={START} hexpand />
        {DeviceInfo}
      </box>
    </button>
  );
});
