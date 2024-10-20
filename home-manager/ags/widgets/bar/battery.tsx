import { bind } from "astal"
import Battery from "gi://AstalBattery"

const battery = Battery.get_default()

function BatteryTooltip() {
  if (battery.charging) {
    const tooltip = `Charging`
    return tooltip
  }
  else {
    const tooltip = `Discharging`
    return tooltip
  }
}

export default function BatteryLevel() {
  const Icon = <icon
    icon={bind(battery, "batteryIconName")} />

  const Label = <label
    label={bind(battery, "percentage").as(i => `${Math.floor(i * 100)}%`)} />

  return <box
    className="battery icon-label"
    tooltipText={BatteryTooltip()}
    visible={bind(battery, "isPresent")}>
      {Icon}
      {Label}
  </box>
}
