import { bind } from "astal";
import { execAsync } from "astal/process";
import { Widget, Gtk } from "astal/gtk3";

import Network from "gi://AstalNetwork";
import Bluetooth from "gi://AstalBluetooth";
import Wp from "gi://AstalWp";
import Icons from "../../lib/icons";

const network = Network.get_default();
const bluetooth = Bluetooth.get_default();
const speaker = Wp.get_default()?.audio.defaultSpeaker!;

// Big buttons for easier controls

function setup(self: Widget.Button) {
  self.cursor = "pointer";
}

// TODO: wifi on / wifi off and track state
const NetworkToggle = (
  <button setup={setup} className="toggle-button on">
    <icon icon={bind(network.wifi, "iconName")} />
  </button>
);

// TODO: This looks rather messy
function BluetoothToggle() {
  const { enabled, disabled } = Icons.bluetooth;

  const Icon = (
    <icon
      icon={bind(bluetooth, "isPowered").as((p) => (p ? enabled : disabled))}
    />
  );

  return (
    <button
      setup={setup}
      className={bind(bluetooth, "isPowered").as((p) =>
        p ? "toggle-button bluetooth on" : "toggle-button bluetooth off",
      )}
      onClicked={() =>
        execAsync(`bluetooth ${bluetooth.isPowered ? "off" : "on"}`)
      }
    >
      {Icon}
    </button>
  );
}

const AudioToggle = (
  <button
    setup={setup}
    className={bind(speaker, "mute").as((m) =>
      m ? "toggle-button off" : "toggle-button on",
    )}
    onClicked={() => (speaker.mute = !speaker.mute)}
  >
    <icon icon={bind(speaker, "volumeIcon")} />
  </button>
);

export default function Toggles() {
  return (
    <box className="container">
      <box halign={Gtk.Align.CENTER} hexpand>
        {NetworkToggle}
        <BluetoothToggle />
        {AudioToggle}
      </box>
    </box>
  );
}
