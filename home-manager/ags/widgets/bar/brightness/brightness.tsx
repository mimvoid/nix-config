import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Brightness from "../../../lib/brightness";
import WlSunset from "./wlsunset";

import HoverRevealer from "../../../lib/widgets/HoverRevealer";

const brightness = Brightness.get_default();
const { CENTER } = Gtk.Align;

// Brightness label & slider

// Change brightness on drag
const Slider = (
  <slider
    cursor="pointer"
    valign={CENTER}
    hexpand
    value={bind(brightness, "light")}
    onDragged={({ value }) => (brightness.light = value)}
  />
);

// Reveal label & slider on hover
const BrightnessBox = () => {
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
      onScroll={(_, { delta_y }) => {
        // Change brightness by scrolling
        delta_y < 0 ? (brightness.light += 0.05) : (brightness.light -= 0.05);
      }}
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
