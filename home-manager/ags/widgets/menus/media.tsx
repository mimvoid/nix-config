import { bind } from "astal"
import { App, Astal, Gtk } from "astal/gtk3"
import Mpris from "gi://AstalMpris"
import Icon from "../../lib/icons"

const mpris = Mpris.get_default()

// Action buttons for playback
const Actions = (player) => {
  // Play or pause
  // Icon changes based on the playing status
  const Toggle = () => {
    const playIcon = bind(player, "playbackStatus").as((s) =>
      s === Mpris.PlaybackStatus.PLAYING
        ? Icon.mpris.pause
        : Icon.mpris.start)

    return <button
      onClick={() => player.play_pause()}
      visible={bind(player, "canPlay")} >
        <icon icon={playIcon} />
    </button>
  }

  const Prev = <button
    onClick={() => player.previous()}
    visible={bind(player, "canGoPrevious")} >
      <icon icon={Icon.mpris.backward} />
  </button>

  const Next = <button
    onClick={() => player.next()}
    visible={bind(player, "canGoNext")} >
      <icon icon={Icon.mpris.forward} />
  </button>

  return <box
    className="media-actions"
    halign={Gtk.Align.CENTER} >
      {Prev}
      <Toggle />
      {Next}
  </box>
}

// Information about the current song
const Media = (player) => {
  // Display cover art
  const CoverArt = () => {
    const coverArt = bind(player, "coverArt").as(cover =>
      `background-image: url('${cover}')`)

    return <box
      className="cover-art"
      valign={Gtk.Align.CENTER}
      css={coverArt} />
  }

  const Title = <label
    className="media-title"
    wrap
    justify={Gtk.Justification.CENTER}
    label={bind(player, "title")} />

  const Artist = <label
    className="media-artist"
    wrap
    justify={Gtk.Justification.CENTER}
    label={bind(player, "artist")} />

  return <box vertical>
    {CoverArt}
    {Title}
    {Artist}
  </box>
}

// Pass the mpris player to the widget modules
const InputPlayer = (player) => {
  return <box className="box" >
    {
      // Draw the widget modules if there is a player
      // Only displays the first player
      bind(mpris, "players").as(ps => ps[0]
        ? (<box vertical >
            {Actions(ps[0])}
            {Media(ps[0])}
          </box>)
        : ( "Nothing Playing" ))
    }
  </box>
}

export default function MediaBox() {
  return <window
    name="media"
    className="media"
    visible={false}

    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={Astal.WindowAnchor.TOP}
    layer={Astal.Layer.OVERLAY}

    margin-top={2}
    application={App} >
      <InputPlayer />
  </window>
}
