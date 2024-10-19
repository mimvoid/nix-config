import { bind } from "astal"
import Battery from "gi://AstalBattery"

const battery = Battery.get_default()

function BatteryTooltip() {
  if (battery.charging) {
    // let time = battery.timeToFull
    // const timeFormatted = `${Math.floor(time / 60)}h ${time % 60}m`

    const tooltip = `Charging`
    return tooltip
  }
  else {
    // let time = battery.timeToEmpty
    // const timeFormatted = `${Math.floor(time / 60)}h ${time % 60}m`

    const tooltip = `Discharging`
    return tooltip
  }
}

export default function BatteryLevel() {
  return <box
    className="battery icon-label"
    tooltipText={BatteryTooltip()}
    visible={bind(battery, "isPresent")}>
      <icon icon={bind(battery, "batteryIconName")} />
      <label label={bind(battery, "percentage").as(p =>
        `${Math.floor(p * 100)}%`
      )} />
  </box>
}
