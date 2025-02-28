import { bind } from "astal";
import { Widget, Gtk } from "astal/gtk3";
import Bluetooth from "gi://AstalBluetooth";
import Icon from "@lib/icons";

const { START, END } = Gtk.Align;

interface BluetoothItemProps extends Widget.ButtonProps {
  device: Bluetooth.Device;
}

export default function DeviceItem({ device, ...props }: BluetoothItemProps) {
  const Paired = <icon icon={Icon.bluetooth.paired} visible={device.paired} />
  const Connecting = bind(device, "connecting").as((c) =>
    <icon icon={Icon.waiting} visible={c} halign={END} />
  );

  return (
    <button className="device" cursor="pointer" {...props}>
      <box>
        <icon icon={bind(device, "icon")} />
        <label label={device.alias} halign={START} hexpand />
        <box className="device-info" halign={END}>
          {Paired}
        </box>
        {Connecting}
      </box>
    </button>
  )
}
