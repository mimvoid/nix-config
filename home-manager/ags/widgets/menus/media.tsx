import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";
import Icon from "@lib/icons";

const mpris = Mpris.get_default();

// Action buttons for playback
function Actions(player: Mpris.Player) {
  // Play or pause
  // Icon changes based on the playing status
  function Toggle() {
    const playIcon = bind(player, "playbackStatus").as((s) =>
      s === Mpris.PlaybackStatus.PLAYING ? Icon.mpris.pause : Icon.mpris.start,
    );

    return (
      <button
        className="play-pause"
        onClick={() => player.play_pause()}
        visible={bind(player, "canPlay")}
        cursor="pointer"
      >
        <icon icon={playIcon} />
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
      <icon icon={Icon.mpris.backward} />
    </button>
  );

  const Next = (
    <button
      className="next"
      onClick={() => player.next()}
      visible={bind(player, "canGoNext")}
      cursor="pointer"
    >
      <icon icon={Icon.mpris.forward} />
    </button>
  );

  function Loop() {
    const { UNSUPPORTED, NONE, TRACK } = Mpris.Loop;

    const icon = bind(player, "loopStatus").as((s) =>
      s === TRACK ? Icon.mpris.loopSong : Icon.mpris.loop,
    );

    return (
      <button
        className={bind(player, "loopStatus").as((s) =>
          s === NONE ? "loop off" : "loop",
        )}
        onClick={() => player.loop()}
        visible={bind(player, "loopStatus").as((s) => s !== UNSUPPORTED)}
        cursor="pointer"
        halign={Gtk.Align.START}
      >
        <icon icon={icon} />
      </button>
    );
  }

  function Shuffle() {
    const { UNSUPPORTED, ON, OFF } = Mpris.Shuffle;

    const icon = bind(player, "shuffleStatus").as((s) =>
      s === ON ? Icon.mpris.shuffle : Icon.mpris.noShuffle,
    );

    return (
      <button
        className={bind(player, "shuffleStatus").as((s) =>
          s === OFF ? "shuffle off" : "shuffle",
        )}
        onClick={() => player.shuffle()}
        visible={bind(player, "shuffleStatus").as((s) => s !== UNSUPPORTED)}
        cursor="pointer"
        halign={Gtk.Align.END}
      >
        <icon icon={icon} />
      </button>
    );
  }

  return (
    <centerbox className="media-actions">
      <Loop />
      <box className="main-actions" halign={Gtk.Align.CENTER} hexpand>
        {Prev}
        <Toggle />
        {Next}
      </box>
      <Shuffle />
    </centerbox>
  );
}

// Song progress
function Progress(player: Mpris.Player) {
  function lengthStr(length: number) {
    const min = Math.floor(length / 60);
    const sec = Math.floor(length % 60);
    const sec0 = sec < 10 ? "0" : "";
    return `${min}:${sec0}${sec}`;
  }

  const hasLength = bind(player, "length").as((l) => l > 0);

  const position = bind(player, "position").as((p) =>
    player.length > 0 ? p / player.length : 0,
  );

  function ProgressBar() {
    return (
      <slider
        value={position}
        onDragged={({ value }) => (player.position = value * player.length)}
        visible={hasLength}
      />
    );
  }

  const Position = (
    <label
      className="position"
      visible={hasLength}
      halign={Gtk.Align.START}
      hexpand
      label={bind(player, "position").as(lengthStr)}
    />
  );

  const Length = (
    <label
      className="length"
      visible={hasLength}
      halign={Gtk.Align.END}
      hexpand
      label={bind(player, "length").as((l) => (l > 0 ? lengthStr(l) : "0:00"))}
    />
  );

  return (
    <box className="media-progress">
      {Position}
      <ProgressBar />
      {Length}
    </box>
  );
}

// Information about the current song
function Media(player: Mpris.Player) {
  // Display cover art
  const CoverArt = () => {
    const coverArt = bind(player, "coverArt").as(
      (cover) => `background-image: url('${cover}')`,
    );

    return (
      <box className="cover-art" valign={Gtk.Align.CENTER} css={coverArt} />
    );
  };

  const Title = (
    <label
      className="media-title"
      wrap
      justify={Gtk.Justification.CENTER}
      label={bind(player, "title")}
    />
  );

  const Artist = (
    <label
      className="media-artist"
      wrap
      justify={Gtk.Justification.CENTER}
      label={bind(player, "artist")}
    />
  );

  return (
    <box vertical>
      <CoverArt />
      {Title}
      {Artist}
    </box>
  );
}

export default function MediaBox() {
  // Pass the mpris player to the widget modules
  function Input() {
    function Popup(player: Mpris.Player) {
      return (
        <box vertical>
          {Actions(player)}
          {Progress(player)}
          {Media(player)}
        </box>
      );
    }

    // Draw the widget modules if there is a player
    // Only displays the first player
    return bind(mpris, "players").as((ps) =>
      ps[0] ? Popup(ps[0]) : "Nothing Playing",
    );
  }

  return (
    <window
      name="media"
      className="media"
      visible={false}
      exclusivity={Astal.Exclusivity.NORMAL}
      anchor={Astal.WindowAnchor.TOP}
      layer={Astal.Layer.OVERLAY}
      margin-top={2}
      application={App}
    >
      <box className="box">{Input()}</box>
    </window>
  );
}
