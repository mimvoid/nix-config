import { Variable } from "astal";
import { exec } from "astal/process";
import { Gtk } from "astal/gtk3";

import Popover from "@lib/widgets/Popover";
import Toggles from "./dashboard/toggles";
import Stats from "./dashboard/stats";

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

function Dashboard() {
  const visible = Variable(false)
  const { START } = Gtk.Align;

  const Widget = (
    <Popover
      name="dashboard"
      className="dashboard popover"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={START}
      halign={START}
      marginTop={28}
      marginLeft={12}
    >
      <box vertical>
        <User />
        <Toggles />
        <Stats />
      </box>
    </Popover>
  );

  return {
    visible: visible,
    Widget: Widget
  }
}

export default Dashboard()
