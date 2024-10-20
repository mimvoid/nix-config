import { exec } from "astal"
import { App } from "astal/gtk3"
import Icon from "../../lib/icons"

// TODO: replace wlogout

export default function Power() {
  return <button
    className="power-actions"
    cursor="pointer"
    onClicked={() => App.toggle_window("session")} >
      <icon icon={Icon.powermenu.indicator} />
  </button>
}
