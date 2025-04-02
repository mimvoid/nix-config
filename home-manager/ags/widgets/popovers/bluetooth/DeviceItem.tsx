import { bind } from "astal";
import { Widget, Gtk } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";
import Icon from "@lib/icons";
import { pointer } from "@lib/utils";

const { START, END } = Gtk.Align;

interface BluetoothItemProps extends Widget.ButtonProps {
  device: Bluetooth.Device;
}

export default ({ device, ...props }: BluetoothItemProps) => {
  const Paired = (
    <image
      iconName={Icon.bluetooth.paired}
      tooltipText="Paired"
      visible={device.paired}
    />
  );

  const Connecting = bind(device, "connecting").as((c) => (
    <image iconName={Icon.waiting} visible={c} halign={END} />
  ));

  return (
    <button setup={pointer} cssClasses={["device"]} {...props}>
      <box>
        <image iconName={bind(device, "icon")} />
        <label label={device.alias} halign={START} hexpand />
        <box cssClasses={["device-info"]} halign={END}>
          {Paired}
        </box>
        {Connecting}
      </box>
    </button>
  );
};
