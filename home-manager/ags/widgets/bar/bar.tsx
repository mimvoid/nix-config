import { App, Astal, Gtk, Gdk } from "astal/gtk4";

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
const Left = (
  <box
    cssClasses={["left", "box"]}
    halign={Gtk.Align.START}
    spacing={10}
    hexpand
  >
    {Dashboard}
    <Workspaces />
    <Title />
  </box>
);

const Center = (
  <box cssClasses={["center", "box"]}>
    <Clock />
    {Media}
  </box>
);

const Right = (
  <box cssClasses={["right", "box"]} halign={Gtk.Align.END} hexpand>
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

export default (monitor: Gdk.Monitor) => {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name="bar"
      cssClasses={["bar"]}
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
      marginTop={3}
      marginRight={12}
      marginBottom={1}
      marginLeft={12}
      visible
    >
      <centerbox>
        {Left}
        {Center}
        {Right}
      </centerbox>
    </window>
  );
};
