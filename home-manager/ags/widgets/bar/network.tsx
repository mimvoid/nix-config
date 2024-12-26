import { execAsync, bind } from "astal";
import { Gtk } from "astal/gtk3";
import Network from "gi://AstalNetwork";

const network = Network.get_default();

function Icon() {
  // Display network strength as percentage on hover
  const tooltip = bind(network.wifi, "strength").as((i) => `${i}%`);

  // Get icon from Astal
  const StatusIcon = (
    <icon className="wifi" icon={bind(network.wifi, "iconName")} />
  );

  // Wrap it in a button that launches a network manager
  return (
    <button
      cursor="pointer"
      onClicked={() => execAsync("networkmanager_dmenu")}
      tooltipText={tooltip}
    >
      {StatusIcon}
    </button>
  );
}

// Reveal the label on hover
function NetworkEvent() {
  const Label = (
    <label
      visible={network.state >= 50 && network.state <= 70}
      label={bind(network.wifi, "ssid").as(String)}
    />
  );

  const Rev = (
    <revealer
      transitionDuration={250}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
    >
      {Label}
    </revealer>
  );

  // Hitbox includes the icon
  return (
    <eventbox
      onHover={() => (Rev.revealChild = true)}
      onHoverLost={() => (Rev.revealChild = false)}
    >
      <box>
        {Rev}
        <Icon />
      </box>
    </eventbox>
  );
}

export default function Wifi() {
  return (
    <box className="network">
      <NetworkEvent />
    </box>
  );
}
