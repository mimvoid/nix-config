import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Mpris from "gi://AstalMpris";
import Gio from "gi://Gio";
import Pango from "gi://Pango";
import { Picture } from "@lib/astalified";

// Information about the current song

const { FILL } = Gtk.Align;

export default (player: Mpris.Player) => {
  // Display cover art
  const CoverArt = (
    <overlay cssClasses={["cover-art-container"]}>
      <box cssClasses={["cover-art-box"]} />
      <Picture
        type="overlay clip"
        cssClasses={["cover-art"]}
        file={bind(player, "coverArt").as((a) => Gio.File.new_for_path(a))}
        contentFit={Gtk.ContentFit.COVER}
        valign={FILL}
      />
    </overlay>
  );

  const Title = (
    <label
      cssClasses={["title"]}
      label={bind(player, "title")}
      justify={Gtk.Justification.CENTER}
      maxWidthChars={36}
      lines={3}
      ellipsize={Pango.EllipsizeMode.END}
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
};
