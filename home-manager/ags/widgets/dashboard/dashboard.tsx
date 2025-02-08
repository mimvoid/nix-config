import { exec } from "astal/process";
import { App, Astal, Gtk } from "astal/gtk3";

import Toggles from "./toggles";
import Stats from "./stats";

function User() {
  const Avatar = <box className="avatar" />;
  const Username = (
    <label className="avatar" label={exec("sh -c 'echo $USER'")} />
  );

  return (
    <box className="container">
      <box halign={Gtk.Align.START} hexpand>
        {Avatar}
        {Username}
      </box>
    </box>
  );
}

export default function Dashboard() {
  const { TOP, LEFT } = Astal.WindowAnchor;

  return (
    <window
      name="dashboard"
      className="dashboard"
      visible={false}
      anchor={TOP | LEFT}
      exclusivity={Astal.Exclusivity.NORMAL}
      layer={Astal.Layer.OVERLAY}
      margin-top={2}
      margin-left={2}
      application={App}
    >
      <box className="box" vertical>
        <User />
        <Toggles />
        <Stats />
      </box>
    </window>
  );
}
