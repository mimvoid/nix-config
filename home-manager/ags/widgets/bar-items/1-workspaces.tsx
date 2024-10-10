import { bind } from "astal"
import Hyprland from "gi://AstalHyprland"

const hypr = Hyprland.get_default()

const wp = bind(hypr, "workspaces").as(wss => wss
  .sort((a, b) => a.id - b.id)
  .map(ws => (
    <button
      className={bind(hypr, "focusedWorkspace").as(fw =>
        ws === fw ? "focused" : "")}
      onClicked={() => ws.focus()}
      cursor="pointer"
      tooltipText={ws.id.toString()}>
    </button>
  ))
)

export default function Workspaces() {
  return <box className="workspaces">
    {wp}
  </box>
}
