import { hook } from "astal/gtk4";
import WlSunset from "@services/wlsunset";
import Icon from "@lib/icons";

const wlsunset = WlSunset.get_default();

// Wlsunset toggler

export default () => (
  <button
    setup={(self) => {
      self.set_cursor_from_name("pointer");

      function runningHook() {
        const r = wlsunset.running;
        const state = r ? "on" : "off";

        self.remove_css_class(r ? "off" : "on");
        self.add_css_class(state);
        self.tooltipText = `wlsunset ${state}`;
        self.iconName = Icon.wlsunset[state];
      }

      runningHook();
      hook(self, wlsunset, "notify::running", runningHook);
    }}
    cssClasses={["wlsunset-toggle"]}
    onClicked={() => (wlsunset.running = !wlsunset.running)}
  />
);
