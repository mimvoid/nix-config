import { execAsync, bind } from "astal";
import Network from "gi://AstalNetwork";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import { pointer } from "@lib/utils";
import NetworkPopover from "../popovers/network";

const network = Network.get_default();

function Icon() {
  // Display network strength as percentage on hover
  const tooltip = bind(network.wifi, "strength").as((i) => `${i}%`);

  // Wrap it in a button that launches a network manager
  return (
    <button
      setup={pointer}
      onClicked={() => execAsync("networkmanager_dmenu")}
      tooltipText={tooltip}
      iconName={bind(network.wifi, "iconName")}
    />
  );
}

// Reveal the label on hover
function NetworkEvent() {
  const Label = (
    <label
      label={bind(network.wifi, "ssid")}
      visible={bind(network, "state").as((s) => {
        const { CONNECTED_LOCAL, CONNECTED_GLOBAL, CONNECTED_SITE } =
          Network.State;
        return (
          s === CONNECTED_LOCAL ||
          s === CONNECTED_GLOBAL ||
          s === CONNECTED_SITE
        );
      })}
    />
  );

  return (
    <menubutton>
      <HoverRevealer
        hiddenChild={Label}
        onClicked={() => (NetworkPopover.visible = true)}
      >
        <Icon />
      </HoverRevealer>
      {NetworkPopover}
    </menubutton>
  );
}

export default function Wifi() {
  return (
    <box cssClasses={["network"]}>
      <NetworkEvent />
    </box>
  );
}
