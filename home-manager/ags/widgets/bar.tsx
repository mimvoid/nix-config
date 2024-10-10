import { App, Variable, Astal, Gtk, Gdk } from "astal"

import Overview from "./bar-items/0-overview"
import Workspaces from "./bar-items/1-workspaces"
import Title from "./bar-items/2-window-title"
import Clock from "./bar-items/3-clock"
import Tray from "./bar-items/4-sys-tray"
import Network from "./bar-items/5-network"
// import Bluetooth from "./bar-items/6-bluetooth"
import Sound from "./bar-items/7-sound"
import Battery from "./bar-items/8-battery"
import Brightness from "./bar-items/9-brightness"
import Power from "./bar-items/10-power"

function Left() {
  return <box
    className="left"
    hexpand
    halign={Gtk.Align.START}>
      <Overview />
      <Workspaces />
      <Title />
  </box>
}

function Center() {
  return <box
    className="center" >
      <Clock />
  </box>
}

function Right() {
  return <box
    className="right"
    hexpand
    halign={Gtk.Align.END} >
      <Tray />
      <Network />
      <Sound />
      <Battery />
      <Brightness />
      <Power />
  </box>
}

export default function Bar(monitor: Gdk.Monitor) {
  const anchor = Astal.WindowAnchor.TOP
    | Astal.WindowAnchor.LEFT
    | Astal.WindowAnchor.RIGHT

  return <window
    className="bar"
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={anchor}
    application={App} >
    <centerbox>
      <Left />
      <Center />
      <Right />
    </centerbox>
  </window>
}
