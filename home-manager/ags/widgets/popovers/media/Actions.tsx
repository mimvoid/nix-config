import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";

import Icons from "@lib/icons";

// Action buttons for playback

const { START, CENTER, END } = Gtk.Align;

export default function Actions(player: Mpris.Player) {
  // Play or pause
  // Icon changes based on the playing status
  function Toggle() {
    const icon = bind(player, "playbackStatus").as((s) =>
      s === Mpris.PlaybackStatus.PLAYING ? Icons.mpris.pause : Icons.mpris.start,
    );

    return (
      <button
        className="play-pause"
        onClick={() => player.play_pause()}
        visible={bind(player, "canPlay")}
        cursor="pointer"
      >
        <icon icon={icon} />
      </button>
    );
  }

  const Prev = (
    <button
      className="previous"
      onClick={() => player.previous()}
      visible={bind(player, "canGoPrevious")}
      cursor="pointer"
    >
      <icon icon={Icons.mpris.backward} />
    </button>
  );

  const Next = (
    <button
      className="next"
      onClick={() => player.next()}
      visible={bind(player, "canGoNext")}
      cursor="pointer"
    >
      <icon icon={Icons.mpris.forward} />
    </button>
  );

  function Loop() {
    const { UNSUPPORTED, NONE, TRACK } = Mpris.Loop;

    const icon = bind(player, "loopStatus").as((s) =>
      s === TRACK ? Icons.mpris.loopSong : Icons.mpris.loop,
    );

    return (
      <button
        className={bind(player, "loopStatus").as((s) => `loop${s === NONE && " off"}`)}
        onClick={() => player.loop()}
        visible={bind(player, "loopStatus").as((s) => s !== UNSUPPORTED)}
        cursor="pointer"
        halign={START}
      >
        <icon icon={icon} />
      </button>
    );
  }

  function Shuffle() {
    const { UNSUPPORTED, ON, OFF } = Mpris.Shuffle;

    const icon = bind(player, "shuffleStatus").as((s) =>
      s === ON ? Icons.mpris.shuffle : Icons.mpris.noShuffle,
    );

    return (
      <button
        className={bind(player, "shuffleStatus").as((s) => `shuffle${s === OFF && " off"}`)}
        onClick={() => player.shuffle()}
        visible={bind(player, "shuffleStatus").as((s) => s !== UNSUPPORTED)}
        cursor="pointer"
        halign={END}
      >
        <icon icon={icon} />
      </button>
    );
  }

  return (
    <centerbox className="media-actions">
      <Loop />
      <box className="main-actions" halign={CENTER} hexpand>
        {Prev}
        <Toggle />
        {Next}
      </box>
      <Shuffle />
    </centerbox>
  );
}
