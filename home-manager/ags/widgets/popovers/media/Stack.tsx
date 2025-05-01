import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Mpris from "gi://AstalMpris";

import { ScrolledWindow } from "@lib/astalified";
import Actions from "./Actions";
import Progress from "./Progress";
import Info from "./Info";

export default (player: Mpris.Player) => {
  const Main = (
    <box vertical>
      {Actions(player)}
      {Progress(player)}
      {Info(player)}
    </box>
  );

  const Lyrics = (
    <ScrolledWindow cssClasses={["lyrics"]}>
      <label
        label={bind(player, "lyrics").as((l) => (l === "" ? "No lyrics" : l))}
        justify={Gtk.Justification.LEFT}
        vexpand
        hexpand
        wrap
      />
    </ScrolledWindow>
  );

  const MediaStack = (
    <stack
      setup={(self) => {
        self.add_titled(Main, "main", "");
        self.add_titled(Lyrics, "lyrics", "");
      }}
      transitionType={Gtk.StackTransitionType.SLIDE_LEFT_RIGHT}
      hhomogeneous
      vhomogeneous
    />
  ) as Gtk.Stack;

  const Switcher = new Gtk.StackSwitcher({
    stack: MediaStack,
    cssClasses: ["no-labels"],
  });

  return (
    <box vertical>
      {MediaStack}
      {Switcher}
    </box>
  );
};
