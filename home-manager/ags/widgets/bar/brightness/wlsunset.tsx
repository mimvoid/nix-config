import { bind } from "astal";
import WlSunset from "../../../lib/wlsunset";
import Icon from "../../../lib/icons";

const wlsunset = WlSunset.get_default();

// Wlsunset toggler

export default function WlSunsetWidget() {
  const Indicator = (
    <icon icon={Icon.wlsunset[wlsunset.running ? "on" : "off"]} />
  );

  // Create icon toggle button
  return (
    <button
      className={bind(wlsunset, "running").as(
        (r) => `wlsunset-toggle ${r ? "on" : "off"}`,
      )}
      tooltipText={bind(wlsunset, "running").as(
        (r) => `wlsunset ${r ? "on" : "off"}`,
      )}
      onClicked={() => {
        wlsunset.running = !wlsunset.running;
        Indicator.icon === Icon.wlsunset.on
          ? (Indicator.icon = Icon.wlsunset.off)
          : (Indicator.icon = Icon.wlsunset.on);
      }}
      cursor="pointer"
    >
      {Indicator}
    </button>
  );
}
