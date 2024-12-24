import { exec, execAsync } from "astal";
import Icon from "../../../lib/icons";

// Wlsunset toggler

export default function WlSunset() {
  function toggle() {
    // HACK: Gjs error Gio.IOErrorEnum when wlsunset is not active
    try {
      exec("pgrep -x 'wlsunset'");
      execAsync("systemctl --user stop wlsunset.service");
    } catch (err) {
      execAsync("systemctl --user start wlsunset.service");
    }
  };

  // Create icon toggle button
  return (
    <button
      className="wlsunset-toggle"
      onClicked={toggle}
      cursor="pointer"
      tooltipText="Toggle wlsunset"
    >
      <icon icon={Icon.wlsunset} />
    </button>
  );
}
