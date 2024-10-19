import { bind } from "astal"
import { Gtk } from "astal/gtk3"
import Wp from "gi://AstalWp"

const speaker = Wp.get_default()?.audio.defaultSpeaker!

const Icon = <button
  cursor="pointer"
  onClicked={() => speaker.mute = !speaker.mute} >
    <icon icon={bind(speaker, "volumeIcon")} />
  </button>

const Label = <label
  label={bind(speaker, "volume").as((i) => `${Math.floor(i * 100)}%`)} />

const Slider = <slider
  cursor="pointer"
  valign={Gtk.Align.CENTER}
  hexpand
  onDragged={({ value }) => (speaker.volume = value)}
  value={bind(speaker, "volume")} />

const Revealer = <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} >
      {Slider}
  </revealer>

const SoundBox = <eventbox
  onHover={() => Revealer.revealChild = true}
  onHoverLost={() => Revealer.revealChild = false} >
    <box>
      {Revealer}
      {Label}
    </box>
  </eventbox>

export default function AudioSlider() {
  return <box className="sound icon-label" >
    {Icon}
    {SoundBox}
  </box>
}
