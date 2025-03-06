import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Wp from "gi://AstalWp";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import { pointer } from "@lib/utils";
import AudioPopover from "../popovers/audio";

const speaker = Wp.get_default()?.audio.defaultSpeaker!;

// Can mute or unmute speaker
const Icon = (
  <button
    setup={pointer}
    onClicked={() => (speaker.mute = !speaker.mute)}
    iconName={bind(speaker, "volumeIcon")}
  />
);

// Control volume with slider
const Slider = (
  <slider
    setup={pointer}
    value={bind(speaker, "volume")}
    onChangeValue={({ value }) => (speaker.volume = value)}
    valign={Gtk.Align.CENTER}
    hexpand
  />
);

// Only show slider on hover
function SliderHover() {
  // Format volume as percentage
  const label = bind(speaker, "volume").as((i) => `${Math.floor(i * 100)}%`);

  // Hitbox does not include the icon
  // Makes clicking on the icon button easier
  return (
    <menubutton>
      <HoverRevealer
        hiddenChild={Slider}
        onScroll={(_, __, dy) => {
          const step = 0.05;

          if (dy < 0) {
            speaker.volume <= 1 - step
              ? (speaker.volume += step)
              : (speaker.volume = 1);
          } else {
            speaker.volume >= step
              ? (speaker.volume -= step)
              : (speaker.volume = 0);
          }
        }}
        onClicked={() => AudioPopover.visible = true}
      >
        {label}
      </HoverRevealer>
      {AudioPopover}
    </menubutton>
  )
}

export default function AudioSlider() {
  return (
    <box cssClasses={["sound", "icon-label"]}>
      {Icon}
      <SliderHover />
    </box>
  );
}
