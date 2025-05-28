import { Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";
import Icon from "@lib/icons";

const { START, END } = Gtk.Align;
const bluetooth = Bluetooth.get_default();

export const connectedDevices: Variable<Gtk.Widget[]> = Variable([]);
export const disconnectedDevices: Variable<Gtk.Widget[]> = Variable([]);

bluetooth.get_devices().map((device) => {
  const DeviceInfo: Gtk.Widget[] = [];

  if (device.paired) {
    DeviceInfo.push(
      <image
        iconName={Icon.bluetooth.paired}
        tooltipText="Paired"
        visible={device.paired}
      />,
    );
  }

  const iconName = Variable(device.icon);

  return (
    <button
      setup={(self) => {
        self.set_cursor_from_name("pointer");

        if (device.connected) {
          const d = connectedDevices.get();
          d.push(self);
          connectedDevices.set(d);
        } else {
          const d = disconnectedDevices.get();
          d.push(self);
          disconnectedDevices.set(d);
        }

        device.connect("notify::connected", ({ c }) => {
          self.tooltipText = `${c ? "Disconnect" : "Connect"} device`;

          const toRemoveFrom = c ? disconnectedDevices : connectedDevices;
          const toAddTo = c ? connectedDevices : disconnectedDevices;

          toRemoveFrom.set(toRemoveFrom.get().filter((d) => d !== self));

          const d = toAddTo.get();
          d.push(self);
          toAddTo.set(d);
        });
      }}
      tooltipText={`${device.connected ? "Disconnect" : "Connect"} device`}
      cssClasses={["device"]}
      onClicked={() => {
        if (device.connecting) return;

        iconName.set(Icon.waiting);

        const callback = () => iconName.set(device.icon);

        device.connected
          ? device.disconnect_device(callback)
          : device.connect_device(callback);
      }}
    >
      <box widthRequest={180}>
        <image iconName={iconName()} onDestroy={() => iconName.drop()} />
        <label label={device.alias} halign={START} hexpand />
        <box cssClasses={["device-info"]} halign={END}>
          {DeviceInfo}
        </box>
      </box>
    </button>
  );
});
