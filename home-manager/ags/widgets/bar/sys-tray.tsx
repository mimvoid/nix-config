import { Variable, bind } from "astal"
import { App, Gtk, Gdk } from "astal/gtk3"
import Tray from "gi://AstalTray"
import Icon from "../../lib/icons"

const tray = Tray.get_default()

const TrayIcons = <box>
  {bind(tray, "items").as(items => items.map(item => {
    if (item.iconThemePath)
      App.add_icons(item.iconThemePath)

    const menu = item.create_menu()

    return <button
      className="system-tray"
      tooltipMarkup={bind(item, "tooltipMarkup")}
      onDestroy={() => menu?.destroy()}
      onClickRelease={self => {
        menu?.popup_at_widget(self, Gdk.Gravity.SOUTH, Gdk.Gravity.NORTH, null)
      }} >
      <icon gIcon={bind(item, "gicon")} />
    </button>
  }))}
</box>

const Revealer = <revealer
  transitionDuration={250}
  transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} >
    {TrayIcons}
</revealer>

const ToggleIcon = <icon className="hider" icon={Icon.hider} />

const state = Variable(true)

export default function SysTray() {
  function toggle() {
    Revealer.revealChild = !Revealer.revealChild

    if (Revealer.revealChild) {
      ToggleIcon.className = "hider open"
    }
    else {
      ToggleIcon.className = "hider"
    }
  }

  return <eventbox
    onClick={() => toggle()} >
      <box>
        {Revealer}
        {ToggleIcon}
      </box>
  </eventbox>
}
