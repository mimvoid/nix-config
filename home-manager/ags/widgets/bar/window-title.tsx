import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"

const hypr = Hyprland.get_default()

export default function Title() {
  // Get the focused window
  const focused = bind(hypr, "focusedClient")

  // Format the focused window title
  const Label = focused.as(client => (
    client && <label
      truncate
      maxWidthChars={42}
      label={bind(client, "title").as(String)} />
  ))

  // Show the title if there is a focused window
  return <box
    className="window-title"
    visible={focused.as(Boolean)} >
      {Label}
  </box>
}
