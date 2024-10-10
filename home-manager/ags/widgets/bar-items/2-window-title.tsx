import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"

const hypr = Hyprland.get_default()
const focused = bind(hypr, "focusedClient")

export default function Title() {
  return <box
    className="window-title"
    visible={focused.as(Boolean)} >
      {focused.as(client => (
        client && <label
          truncate
          maxWidthChars={42}
          label={bind(client, "title").as(String)} />
      ))}
  </box>
}
