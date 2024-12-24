import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Wp from "gi://AstalWp";

const speaker = Wp.get_default()?.audio.defaultSpeaker!;

const Icon = () => {
  // Get icon from Astal
  const AudioIcon = <icon icon={bind(speaker, "volumeIcon")} />;

  // Mute or unmute speaker
  return (
    <button cursor="pointer" onClicked={() => (speaker.mute = !speaker.mute)}>
      {AudioIcon}
    </button>
  );
};

// Format volume as percentage
const Label = (
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
  const Revealer = (
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
      onHover={() => (Revealer.revealChild = true)}
      onHoverLost={() => (Revealer.revealChild = false)}
    >
      <box>
        {Revealer}
        {Label}
      </box>
    </eventbox>
  );
}

export default function AudioSlider() {
  return (
    <box className="sound icon-label">
      <Icon />
      <EventSlider />
    </box>
  );
}
