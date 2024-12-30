import { App, Astal, Gtk, Gdk } from "astal/gtk3";

// Get the bar modules
import Workspaces from "./workspaces";
import Title from "./windowTitle";

import Clock from "./clock";
import { Media, Dashboard, Session } from "./togglers";

import Tray from "./sysTray";
import ColorPicker from "./colorPicker";
import Network from "./network";
import Bluetooth from "./bluetooth";
import Sound from "./sound";
import Battery from "./battery";
import Brightness from "./brightness/brightness";

// Define the three parts of the bar
function Left() {
  return (
    <box className="left box" hexpand halign={Gtk.Align.START}>
      {Dashboard}
      <Workspaces />
      <Title />
    </box>
  );
}

function Center() {
  return (
    <box className="center box">
      <Clock />
      {Media}
    </box>
  );
}

function Right() {
  return (
    <box className="right box" hexpand halign={Gtk.Align.END}>
      <Tray />
      <ColorPicker />
      <Network />
      <Bluetooth />
      <Sound />
      <Battery />
      <Brightness />
      {Session}
    </box>
  );
}

export default function Bar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name="bar"
      className="bar"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox>
        <Left />
        <Center />
        <Right />
      </centerbox>
    </window>
  );
}
