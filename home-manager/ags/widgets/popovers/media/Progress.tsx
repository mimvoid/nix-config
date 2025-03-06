import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Mpris from "gi://AstalMpris";
import { pointer } from "@lib/utils";

// Song progress

const { START, END } = Gtk.Align;

function lengthStr(length: number) {
  const min = Math.floor(length / 60).toString();
  const sec = Math.floor(length % 60).toString().padStart(2, "0");
  return min + ":" + sec;
}

export default function Progress(player: Mpris.Player) {
  const position = bind(player, "position").as((p) =>
    player.length > 0 ? p / player.length : 0,
  );

  const ProgressBar = (
    <slider
      setup={pointer}
      value={position}
      onChangeValue={({ value }) => (player.position = value * player.length)}
      hexpand
    />
  );

  const Position = (
    <label
      cssClasses={["position"]}
      label={bind(player, "position").as(lengthStr)}
      halign={START}
    />
  );

  const Length = (
    <label
      cssClasses={["length"]}
      label={bind(player, "length").as((l) => (l > 0 ? lengthStr(l) : "0:00"))}
      halign={END}
    />
  );

  return (
    <box cssClasses={["media-progress"]} visible={bind(player, "length").as((l) => l > 0)}>
      {Position}
      {ProgressBar}
      {Length}
    </box>
  );
}
