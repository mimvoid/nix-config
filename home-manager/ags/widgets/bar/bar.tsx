import { Variable } from "astal"
import { App, Astal, Gtk, Gdk } from "astal/gtk3"

// Get the bar modules
import Overview from "./overview"
import Workspaces from "./workspaces"
import Title from "./window-title"

import Clock from "./clock"
import MediaIcon from "./media"

import Tray from "./sys-tray"
import Network from "./network"
import Bluetooth from "./bluetooth"
import Sound from "./sound"
import Battery from "./battery"
import Brightness from "./brightness"
import Power from "./power"


// Define the three parts of the bar
function Left() {
  return <box
    className="left box"
    hexpand
    halign={Gtk.Align.START}>
      <Overview />
      <Workspaces />
      <Title />
  </box>
}

function Center() {
  return <box
    className="center box" >
      <Clock />
      <MediaIcon />
  </box>
}

function Right() {
  return <box
    className="right box"
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
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return <window
    name="bar"
    className="bar"
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={TOP | LEFT | RIGHT}
    application={App} >
      <centerbox>
        <Left />
        <Center />
        <Right />
      </centerbox>
  </window>
}