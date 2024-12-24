import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Wp from "gi://AstalWp";

const speaker = Wp.get_default()?.audio.defaultSpeaker!;

const Icon = (
  // Can mute or unmute speaker
  <button cursor="pointer" onClicked={() => (speaker.mute = !speaker.mute)}>
    <icon icon={bind(speaker, "volumeIcon")} />
  </button>
);

const Label = (
  // Format volume as percentage
  <label label={bind(speaker, "volume").as((i) => `${Math.floor(i * 100)}%`)} />
);

// Control volume with slider
const Slider = (
  <slider
    cursor="pointer"
    valign={Gtk.Align.CENTER}
    hexpand
    onDragged={({ value }) => (speaker.volume = value)}
    value={bind(speaker, "volume")}
  />
);

// Only show slider on hover
function EventSlider() {
  const Rev = (
    <revealer
      transitionDuration={250}
      transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
    >
      {Slider}
    </revealer>
  );

  // Hitbox does not include the icon
  // Makes clicking on the icon button easier
  return (
    <eventbox
      onHover={() => (Rev.revealChild = true)}
      onHoverLost={() => (Rev.revealChild = false)}
      onScroll={(_, { delta_y }) => {
        const step = 0.05;

        if (delta_y < 0) {
          speaker.volume <= 0.95
            ? (speaker.volume += step)
            : (speaker.volume = 1);
        } else {
          speaker.volume >= 0.05
            ? (speaker.volume -= step)
            : (speaker.volume = 0);
        }
      }}
    >
      <box>
        {Rev}
        {Label}
      </box>
    </eventbox>
  );
}

export default function AudioSlider() {
  return (
    <box className="sound icon-label">
      {Icon}
      <EventSlider />
    </box>
  );
}
