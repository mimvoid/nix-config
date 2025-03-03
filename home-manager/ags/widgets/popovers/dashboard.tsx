import { Gtk } from "astal/gtk3";

import Popover from "@lib/widgets/Popover";
import Toggles from "./dashboard/toggles";
import Launchers from "./dashboard/launchers";
import visible from "./dashboard/visible";

import { name } from "@lib/variables";

const { START, CENTER } = Gtk.Align;

function User() {
  const Avatar = (
    <box className="avatar with-bg-img" css={`background-image: url('${SRC}/assets/avatar.jpg')`} />
  );

  const Names = (
    <box vertical valign={CENTER}>
      <label className="avatar title" label={name.username} halign={START} />
      <label label={name.hostname} halign={START} />
    </box>
  );

  return (
    <box className="user-info section">
      {Avatar}
      {Names}
    </box>
  );
}

function Dashboard() {
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
        <Launchers />
      </box>
    </Popover>
  );

  return {
    visible: visible,
    Widget: Widget
  }
}

export default Dashboard()
