import { bind } from "astal";
import Hyprland from "gi://AstalHyprland";

const hypr = Hyprland.get_default();

const Spaces = bind(hypr, "workspaces").as((wss) =>
  wss
    // Keep workspaces sorted regardless of when they're entered
    .sort((a, b) => a.id - b.id)
    // Create a button for each workspace
    .map((ws) => (
      <button
        className={bind(hypr, "focusedWorkspace").as((fw) =>
          ws === fw ? "focused" : "",
        )}
        onClicked={() => ws.focus()}
        cursor="pointer"
        tooltipText={ws.id.toString()}
      ></button>
    )),
);

export default function Workspaces() {
  return <box className="workspaces">{Spaces}</box>;
}
