import { exec, bind } from "astal";
import { Gtk } from "astal/gtk3";
import Network from "gi://AstalNetwork";

const network = Network.get_default();

const Icon = () => {
  // Get icon from Astal
  const StatusIcon = (
    <icon className="wifi" icon={bind(network.wifi, "iconName")} />
  );

  // Wrap it in a button that launches a network manager
  return (
    <button cursor="pointer" onClicked={() => exec("networkmanager_dmenu")}>
      {StatusIcon}
    </button>
  );
};

const Label = () => {
  // TODO: Only show the label when it makes sense
  // state = bind(network.wifi, "state")
  // active = state ==

  return (
    <label
      // visible={active.as(Boolean)}
      label={bind(network.wifi, "ssid").as(String)}
    />
  );
};

// Reveal the label on hover
const NetworkEvent = () => {
  const Revealer = (
    <revealer
      transitionDuration={250}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
    >
      <Label />
    </revealer>
  );

  // Hitbox includes the icon
  return (
    <eventbox
      onHover={() => (Revealer.revealChild = true)}
      onHoverLost={() => (Revealer.revealChild = false)}
    >
      <box>
        {Revealer}
        <Icon />
      </box>
    </eventbox>
  );
};

export default function Wifi() {
  // Display network strength as percentage on hover
  const tooltip = bind(network.wifi, "strength").as((i) => `${i}%`);

  return (
    <box className="network" tooltipText={tooltip}>
      <NetworkEvent />
    </box>
  );
}
