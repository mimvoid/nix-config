import { bind } from "astal"
import { App, Gdk } from "astal/gtk3"
import Tray from "gi://AstalTray"

const tray = Tray.get_default()

export default function SysTray() {
  return <box>
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
}
