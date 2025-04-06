import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk4";

import Brightness from "@services/brightness";
import WlSunset from "@services/wlsunset";

import Popover from "@lib/widgets/Popover";
import Icon from "@lib/icons";
import { pointer } from "@lib/utils";

const brightness = Brightness.get_default();
const wlsunset = WlSunset.get_default();
const { START, CENTER, END } = Gtk.Align;

function WlStatus() {
  const action = () => (wlsunset.running = !wlsunset.running);

  // Display icon depending on Bluetooth status
  const icon = bind(wlsunset, "running").as((r) =>
    r ? Icon.wlsunset.on : Icon.wlsunset.off,
  );

  return (
    <box cssClasses={["status", "section"]}>
      <button setup={pointer} onClicked={action}>
        <image iconName={icon} iconSize={Gtk.IconSize.LARGE} />
      </button>
      <label
        label={bind(wlsunset, "running").as(
          (r) => `wlsunset ${r ? "on" : "off"}`,
        )}
        halign={START}
      />
    </box>
  );
}

function BrightnessSlider() {
  const Slider = (
    <slider
      setup={pointer}
      value={bind(brightness, "light")}
      onChangeValue={({ value }) => (brightness.light = value)}
      valign={CENTER}
      hexpand
    />
  );

  const Label = bind(brightness, "light").as((i) => `${Math.floor(i * 100)}%`);

  return (
    <box
      onScroll={(_, __, dy) =>
        dy < 0 ? (brightness.light += 0.05) : (brightness.light -= 0.05)
      }
    >
      {Slider}
      {Label}
    </box>
  );
}

export default (
  <popover
    cssClasses={["brightness-popover", "popover"]}
    valign={START}
    halign={END}
    hasArrow={false}
  >
    <box vertical>
      <WlStatus />
      <BrightnessSlider />
    </box>
  </popover>
);
