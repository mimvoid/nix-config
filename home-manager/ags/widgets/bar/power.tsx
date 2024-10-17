import { exec } from "astal"
import Icon from "../../lib/icons"

// TODO: replace wlogout

export default function Power() {
  return <button
    className="power-actions"
    cursor="pointer"
    onClicked={() => exec("wlogout -b 2")} >
      <icon icon={Icon.powermenu.indicator} />
  </button>
}
