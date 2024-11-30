import { exec } from "astal"
import { App } from "astal/gtk3"
import Icon from "../../lib/icons"

// A button to toggle buttons for logging out, shutting down, etc.

export default function Power() {
  return <button
    className="power-actions"
    cursor="pointer"
    onClicked={() => App.toggle_window("session")} >
      <icon icon={Icon.powermenu.indicator} />
  </button>
}
