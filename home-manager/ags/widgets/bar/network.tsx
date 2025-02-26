import { execAsync, bind } from "astal";
import Network from "gi://AstalNetwork";
import HoverRevealer from "@lib/widgets/HoverRevealer";

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

  return (
    <HoverRevealer hiddenChild={Label} >
      <Icon />
    </HoverRevealer>
  )
}

export default function Wifi() {
  return (
    <box className="network">
      <NetworkEvent />
    </box>
  );
}
