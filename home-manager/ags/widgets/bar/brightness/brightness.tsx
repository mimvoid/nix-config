import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import WlSunset from "./wlsunset";

import Brightness from "@services/brightness";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import { pointer } from "@lib/utils";

// Brightness label & slider

const brightness = Brightness.get_default();
const { CENTER } = Gtk.Align;

function BrightnessBox() {
  // Change brightness on drag
  const Slider = (
    <slider
      setup={pointer}
      value={bind(brightness, "light")}
      onChangeValue={({ value }) => (brightness.light = value)}
      valign={CENTER}
      hexpand
    />
  );

  // Format brightness as percentage
  const label = bind(brightness, "light").as((i) => `${Math.floor(i * 100)}%`);

  return (
    <HoverRevealer
      hiddenChild={
        <box hexpand valign={CENTER}>
          {Slider}
          {label}
        </box>
      }
      onScroll={(_, __, dy) =>
        // Change brightness by scrolling
        dy < 0 ? (brightness.light += 0.05) : (brightness.light -= 0.05)
      }
    />
  );
}

export default () => (
  <box cssClasses={["brightness"]}>
    <WlSunset />
    <BrightnessBox />
  </box>
);
