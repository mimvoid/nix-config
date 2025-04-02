import { bind } from "astal";
import WlSunset from "@services/wlsunset";
import Icon from "@lib/icons";
import { pointer } from "@lib/utils";

const wlsunset = WlSunset.get_default();

// Wlsunset toggler

export default function WlSunsetWidget() {
  return (
    <button
      setup={pointer}
      cssClasses={bind(wlsunset, "running").as((r) => [
        "wlsunset-toggle",
        r ? "on" : "off",
      ])}
      tooltipText={bind(wlsunset, "running").as(
        (r) => `wlsunset ${r ? "on" : "off"}`,
      )}
      onClicked={() => (wlsunset.running = !wlsunset.running)}
      iconName={bind(wlsunset, "running").as((r) =>
        r ? Icon.wlsunset.on : Icon.wlsunset.off,
      )}
    />
  );
}
