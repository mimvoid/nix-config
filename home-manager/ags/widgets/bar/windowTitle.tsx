import { hook } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";
import Pango from "gi://Pango";

const hypr = Hyprland.get_default();

export default () => (
  <label
    setup={(self) => {
      function hookClient() {
        self.visible = Boolean(hypr.focusedClient);
        if (!hypr.focusedClient) return;

        self.label = hypr.focusedClient.title;
        self.tooltipText = hypr.focusedClient.title;
      }
      hookClient();
      hook(self, hypr, "notify::focused-client", hookClient);
    }}
    cssClasses={["window-title"]}
    ellipsize={Pango.EllipsizeMode.END}
    maxWidthChars={42}
  />
);
