import { App, Variable, Astal, Gtk, Gdk } from "astal"

import Overview from "./overview"
import Workspaces from "./workspaces"
import Title from "./window-title"
import Clock from "./clock"
import Tray from "./sys-tray"
import Network from "./network"
import Bluetooth from "./bluetooth"
import Sound from "./sound"
import Battery from "./battery"
import Brightness from "./brightness"
import Power from "./power"

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
      <Bluetooth />
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