import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";

// Information about the current song

const { CENTER } = Gtk.Align;

export default function Info(player: Mpris.Player) {
  // Display cover art
  const CoverArt = (
    <box
      className="cover-art with-bg-img"
      valign={CENTER}
      css={bind(player, "coverArt").as((cover) => `background-image: url('${cover}')`)}
    />
  );

  const Title = (
    <label
      className="media-title title"
      label={bind(player, "title")}
      maxWidthChars={36}
      justify={Gtk.Justification.CENTER}
      wrap
    />
  );

  const Artist = (
    <label
      className="media-artist"
      label={bind(player, "artist")}
      justify={Gtk.Justification.CENTER}
      wrap
    />
  );

  return (
    <box className="with-cover-art" vertical>
      {CoverArt}
      {Title}
      {Artist}
    </box>
  );
}
