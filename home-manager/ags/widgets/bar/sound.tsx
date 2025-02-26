import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Wp from "gi://AstalWp";
import HoverRevealer from "@lib/widgets/HoverRevealer";

const speaker = Wp.get_default()?.audio.defaultSpeaker!;

const Icon = (
  // Can mute or unmute speaker
  <button cursor="pointer" onClicked={() => (speaker.mute = !speaker.mute)}>
    <icon icon={bind(speaker, "volumeIcon")} />
  </button>
);

// Control volume with slider
const Slider = (
  <slider
    value={bind(speaker, "volume")}
    onDragged={({ value }) => (speaker.volume = value)}
    cursor="pointer"
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
    <HoverRevealer
      hiddenChild={Slider}
      onScroll={(_, { delta_y }) => {
        const step = 0.05;

        if (delta_y < 0) {
          speaker.volume <= 1 - step
            ? (speaker.volume += step)
            : (speaker.volume = 1);
        } else {
          speaker.volume >= step
            ? (speaker.volume -= step)
            : (speaker.volume = 0);
        }
      }}
    >
      {label}
    </HoverRevealer>
  )
}

export default function AudioSlider() {
  return (
    <box className="sound icon-label">
      {Icon}
      <SliderHover />
    </box>
  );
}
