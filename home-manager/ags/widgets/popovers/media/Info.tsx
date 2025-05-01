import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk4";

import Mpris from "gi://AstalMpris";

import Gio from "gi://Gio";
import Pango from "gi://Pango";

import Visualizer from "./Visualizer";
import { Picture } from "@lib/astalified";
import { pointer } from "@lib/utils";
import Icon from "@lib/icons";

// Information about the current song

const { START, END, FILL } = Gtk.Align;

export default (player: Mpris.Player) => {
  const CavaWidget: Variable<Gtk.Widget | null> = Variable(null);

  const CoverArtBox = <box cssClasses={["cover-art-box"]} />;
  const VisToggle = (overlay: Gtk.Overlay) => (
    <button
      setup={pointer}
      onClicked={() => {
        const CurrentCava = CavaWidget.get();

        if (CurrentCava) {
          CurrentCava.visible = !CurrentCava.visible;
        } else {
          // Lazy load Cava visualizer
          const newCava = Visualizer()!;
          CavaWidget.set(newCava);
          overlay.add_overlay(newCava);
        }
      }}
      iconName={Icon.visualizer}
      cssClasses={["cava-toggler"]}
      halign={END}
      valign={START}
    />
  );

  // Display cover art
  const CoverArt = (
    <overlay
      setup={(self) => self.add_overlay(VisToggle(self))}
      cssClasses={["cover-art-container"]}
    >
      {bind(player, "coverArt").as((a) => {
        if (!a) return [CoverArtBox];

        return [
          CoverArtBox,
          <Picture
            type="overlay clip"
            cssClasses={["cover-art"]}
            file={Gio.File.new_for_path(a)}
            contentFit={Gtk.ContentFit.COVER}
            valign={FILL}
          />,
        ];
      })}
    </overlay>
  );

  const Title = (
    <label
      cssClasses={["title"]}
      label={bind(player, "title")}
      justify={Gtk.Justification.CENTER}
      maxWidthChars={36}
      lines={2}
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
