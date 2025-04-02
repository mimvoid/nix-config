import { bind } from "astal";
import Hyprland from "gi://AstalHyprland";
import { pointer } from "@lib/utils";

const hypr = Hyprland.get_default();

const Spaces = bind(hypr, "workspaces").as((wss) =>
  wss
    // Keep workspaces sorted regardless of when they're entered
    .sort((a, b) => a.id - b.id)

    // Create a button for each workspace
    .map((ws) => (
      <button
        setup={pointer}
        cssClasses={bind(hypr, "focusedWorkspace").as((fw) =>
          ws === fw ? ["active"] : [],
        )}
        onClicked={() => ws.focus()}
        tooltipText={`Workspace ${ws.id}`}
      />
    )),
);

export default () => <box cssClasses={["workspaces"]}>{Spaces}</box>;
