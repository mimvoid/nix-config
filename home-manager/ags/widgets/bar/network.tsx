import { execAsync, bind } from "astal";
import Network from "gi://AstalNetwork";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import NetworkPopover from "../popovers/network";

const network = Network.get_default();

export default () => {
  const Icon = (
    <button
      setup={(self) => self.set_cursor_from_name("pointer")}
      onClicked={() => execAsync("networkmanager_dmenu")}
      tooltipText={bind(network.wifi, "strength").as((i) => `${i}%`)}
      iconName={bind(network.wifi, "iconName")}
    />
  );

  const Label = <label label={bind(network.wifi, "ssid")} />;

  return (
    <menubutton cssClasses={["network"]}>
      <HoverRevealer hiddenChild={Label}>
        {Icon}
      </HoverRevealer>
      {NetworkPopover}
    </menubutton>
  );
};
