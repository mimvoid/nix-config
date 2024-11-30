import { bind } from "astal"
import Battery from "gi://AstalBattery"

const battery = Battery.get_default()

export default function BatteryLevel() {
  // Show the charging status on hover
  const tooltip = bind(battery, "charging").as((i) =>
    i ? "Charging" : "Discharging")

  // Get the icon from Astal
  const Icon = <icon
    icon={bind(battery, "batteryIconName")} />

  // Format the battery percentage
  const Label = <label
    label={bind(battery, "percentage").as(i => `${Math.floor(i * 100)}%`)} />

  return <box
    className="battery icon-label"
    tooltipText={tooltip}
    visible={bind(battery, "isPresent")}>
      {Icon}
      {Label}
  </box>
}
