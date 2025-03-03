import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import WlSunset from "./wlsunset";

import Brightness from "@services/brightness";
import HoverRevealer from "@lib/widgets/HoverRevealer";

// Brightness label & slider

const brightness = Brightness.get_default();
const { CENTER } = Gtk.Align;

function BrightnessBox() {
  // Change brightness on drag
  const Slider = (
    <slider
      value={bind(brightness, "light")}
      onDragged={({ value }) => brightness.light = value}
      cursor="pointer"
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
      onScroll={(_, { delta_y }) => (
        // Change brightness by scrolling
        delta_y < 0 ? (brightness.light += 0.05) : (brightness.light -= 0.05)
      )}
    />
  );
};

export default function BrightnessWidget() {
  return (
    <box className="brightness">
      <WlSunset />
      <BrightnessBox />
    </box>
  );
}
