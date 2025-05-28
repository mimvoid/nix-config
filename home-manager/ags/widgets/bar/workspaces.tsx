import { bind } from "astal";
import { hook } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";

const hypr = Hyprland.get_default();

const Spaces = bind(hypr, "workspaces").as((wss) =>
  wss
    // Keep workspaces sorted regardless of when they're entered
    .sort((a, b) => a.id - b.id)

    // Create a button for each workspace
    .map((ws) => (
      <button
        setup={(self) => {
          self.set_cursor_from_name("pointer");
          function focusHook() {
            hypr.focusedWorkspace.id === ws.id
              ? self.add_css_class("active")
              : self.remove_css_class("active");
          }
          focusHook();
          hook(self, hypr, "notify::focused-workspace", focusHook);
        }}
        onClicked={() => ws.focus()}
        tooltipText={`Workspace ${ws.id}`}
      />
    )),
);

export default () => (
  <box cssClasses={["workspaces"]} spacing={4}>
    {Spaces}
  </box>
);
