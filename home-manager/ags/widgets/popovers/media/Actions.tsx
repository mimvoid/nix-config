import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Mpris from "gi://AstalMpris";

import Icons from "@lib/icons";
import { pointer } from "@lib/utils";

// Action buttons for playback

const { START, CENTER, END } = Gtk.Align;

export default (player: Mpris.Player) => {
  // Play or pause
  // Icon changes based on the playing status
  function Toggle() {
    const icon = bind(player, "playbackStatus").as((s) =>
      s === Mpris.PlaybackStatus.PLAYING
        ? Icons.mpris.pause
        : Icons.mpris.start,
    );

    return (
      <button
        setup={pointer}
        cssClasses={["play-pause"]}
        onClicked={() => player.play_pause()}
        visible={bind(player, "canPlay")}
        iconName={icon}
      />
    );
  }

  const Prev = (
    <button
      setup={pointer}
      cssClasses={["previous"]}
      onClicked={() => player.previous()}
      visible={bind(player, "canGoPrevious")}
      iconName={Icons.mpris.backward}
    />
  );

  const Next = (
    <button
      setup={pointer}
      cssClasses={["next"]}
      onClicked={() => player.next()}
      visible={bind(player, "canGoNext")}
      iconName={Icons.mpris.forward}
    />
  );

  function Loop() {
    const { UNSUPPORTED, NONE, TRACK } = Mpris.Loop;

    const icon = bind(player, "loopStatus").as((s) =>
      s === TRACK ? Icons.mpris.loopSong : Icons.mpris.loop,
    );

    return (
      <button
        setup={pointer}
        cssClasses={bind(player, "loopStatus").as((s) => [
          "loop",
          s === NONE ? "off" : "",
        ])}
        onClicked={() => player.loop()}
        visible={bind(player, "loopStatus").as((s) => s !== UNSUPPORTED)}
        halign={START}
        iconName={icon}
      />
    );
  }

  function Shuffle() {
    const { UNSUPPORTED, ON, OFF } = Mpris.Shuffle;

    const icon = bind(player, "shuffleStatus").as((s) =>
      s === ON ? Icons.mpris.shuffle : Icons.mpris.noShuffle,
    );

    return (
      <button
        setup={pointer}
        cssClasses={bind(player, "shuffleStatus").as((s) => [
          "shuffle",
          s === OFF ? "off" : "",
        ])}
        onClicked={() => player.shuffle()}
        visible={bind(player, "shuffleStatus").as((s) => s !== UNSUPPORTED)}
        halign={END}
        iconName={icon}
      />
    );
  }

  return (
    <centerbox cssClasses={["media-actions"]}>
      <Loop />
      <box cssClasses={["main-actions"]} halign={CENTER} hexpand>
        {Prev}
        <Toggle />
        {Next}
      </box>
      <Shuffle />
    </centerbox>
  );
};
