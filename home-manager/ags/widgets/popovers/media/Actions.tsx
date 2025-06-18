import { bind } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Mpris from "gi://AstalMpris";

import Icons from "@lib/icons";
import { pointer, popButton } from "@lib/utils";

// Action buttons for playback

const { START, CENTER, END } = Gtk.Align;

export default (player: Mpris.Player) => {
  // Play or pause
  // Icon changes based on the playing status
  function Toggle() {
    const icon = bind(player, "playbackStatus").as(
      (s) =>
        Icons.mpris[s === Mpris.PlaybackStatus.PLAYING ? "pause" : "start"],
    );

    return (
      <button
        setup={(self) => {
          pointer(self);
          popButton(self);
        }}
        cssClasses={["play-pause"]}
        onClicked={() => player.play_pause()}
        visible={bind(player, "canPlay")}
        iconName={icon}
      />
    );
  }

  const Prev = (
    <button
      setup={(self) => {
        pointer(self);
        popButton(self);
      }}
      cssClasses={["previous"]}
      onClicked={() => player.previous()}
      visible={bind(player, "canGoPrevious")}
      iconName={Icons.mpris.backward}
    />
  );

  const Next = (
    <button
      setup={(self) => {
        pointer(self);
        popButton(self);
      }}
      cssClasses={["next"]}
      onClicked={() => player.next()}
      visible={bind(player, "canGoNext")}
      iconName={Icons.mpris.forward}
    />
  );

  const Loop = (
    <button
      setup={(self) => {
        pointer(self);
        popButton(self);

        function loopHook() {
          const { UNSUPPORTED, NONE, TRACK } = Mpris.Loop;
          const loop = player.loopStatus;

          self.visible = loop !== UNSUPPORTED;
          if (!self.visible) return;

          self.iconName = Icons.mpris[loop === TRACK ? "loopSong" : "loop"];
          loop === NONE
            ? self.add_css_class("off")
            : self.remove_css_class("off");
        }

        loopHook();
        hook(self, player, "notify::loop-status", loopHook);
      }}
      cssClasses={["loop"]}
      onClicked={() => player.loop()}
      halign={START}
    />
  );

  const Shuffle = (
    <button
      setup={(self) => {
        pointer(self);
        popButton(self);

        function shuffleHook() {
          const { UNSUPPORTED, ON, OFF } = Mpris.Shuffle;
          const s = player.shuffleStatus;

          self.visible = s !== UNSUPPORTED;
          if (!self.visible) return;

          self.iconName = Icons.mpris[s === ON ? "shuffle" : "noShuffle"];
          s === OFF ? self.add_css_class("off") : self.remove_css_class("off");
        }

        shuffleHook();
        hook(self, player, "notify::shuffle-status", shuffleHook);
      }}
      cssClasses={["shuffle"]}
      onClicked={() => player.shuffle()}
      halign={END}
    />
  );

  return (
    <centerbox cssClasses={["media-actions"]}>
      {Loop}
      <box cssClasses={["main-actions"]} halign={CENTER} hexpand>
        {Prev}
        <Toggle />
        {Next}
      </box>
      {Shuffle}
    </centerbox>
  );
};
