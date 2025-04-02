import { bind } from "astal";
import Battery from "gi://AstalBattery";

const battery = Battery.get_default();

export default function BatteryLevel() {
  // Get the icon from Astal
  const Icon = <image iconName={bind(battery, "batteryIconName")} />;

  // Format the battery percentage
  const label = bind(battery, "percentage").as(
    (i) => `${Math.floor(i * 100)}%`,
  );

  // Show the charging status on hover
  const tooltip = bind(battery, "charging").as((i) =>
    i ? "Charging" : "Discharging",
  );

  return (
    <box
      cssClasses={["battery", "icon-label"]}
      tooltipText={tooltip}
      visible={bind(battery, "isPresent")}
    >
      {Icon}
      {label}
    </box>
  );
}
