import { bind } from "astal"
import { App, Astal, Gtk } from "astal/gtk3"
import Mpris from "gi://AstalMpris"
import Icon from "../../lib/icons"

const mpris = Mpris.get_default()

const Actions = (player) => {
  const Toggle = <button
    onClick={() => player.play_pause()}
    visible={bind(player, "canPlay")} >
      <icon icon={bind(player, "playbackStatus").as((s) => (
        s === Mpris.PlaybackStatus.PLAYING ? Icon.mpris.pause : Icon.mpris.start
      ))} />
  </button>

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
      {Toggle}
      {Next}
  </box>
}

function Media() {
  const CoverArt = (player) => {
    return <box
      className="cover-art"
      valign={Gtk.Align.CENTER}
      css={bind(player, "coverArt").as(cover =>
        `background-image: url('${cover}');`
      )}
    />
  }

  const Title = (player) => {
    return <label
      className="media-title"
      wrap
      justify={Gtk.Justification.CENTER}
      label={bind(player, "title").as(() =>
        `${player.title} - ${player.artist}`
      )}
    />
  }

  return <box className="box">
    {bind(mpris, "players").as(ps => ps[0] ? (
      <box vertical >
        {Actions(ps[0])}
        {CoverArt(ps[0])}
        {Title(ps[0])}
      </box>
    ) : (
      "Nothing Playing"
    ))}
  </box>
}

export default function MediaBox(monitor: Gdk.Monitor) {
  return <window
    name="media"
    className="media"
    visible={false}
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={Astal.WindowAnchor.TOP}
    layer={Astal.Layer.OVERLAY}
    margin-top={2}
    application={App} >
      <Media />
  </window>
}
