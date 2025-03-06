import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Mpris from "gi://AstalMpris";

// Information about the current song

const { CENTER } = Gtk.Align;

export default function Info(player: Mpris.Player) {
  // Display cover art
  const CoverArt = (
    <image
      cssClasses={["cover-art"]}
      file={bind(player, "coverArt")}
      valign={CENTER}
    />
  );

  const Title = (
    <label
      cssClasses={["media-title", "title"]}
      label={bind(player, "title")}
      maxWidthChars={36}
      justify={Gtk.Justification.CENTER}
      wrap
    />
  );

  const Artist = (
    <label
      cssClasses={["media-artist"]}
      label={bind(player, "artist")}
      justify={Gtk.Justification.CENTER}
      wrap
    />
  );

  return (
    <box cssClasses={["with-cover-art"]} vertical>
      {CoverArt}
      {Title}
      {Artist}
    </box>
  );
}
