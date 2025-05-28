import { bind } from "astal";
import Battery from "gi://AstalBattery";

const battery = Battery.get_default();

export default () => (
  <box
    cssClasses={["battery", "icon-label"]}
    tooltipText={bind(battery, "charging").as((c) =>
      c ? "Charging" : "Discharging",
    )}
    visible={bind(battery, "isPresent")}
  >
    <image iconName={bind(battery, "batteryIconName")} />
    <label
      label={bind(battery, "percentage").as((p) => `${Math.floor(p * 100)}%`)}
    />
  </box>
);
