import { Gtk } from "astal/gtk4";

import { name } from "@lib/variables";

import Toggles from "./dashboard/toggles";
import Launchers from "./dashboard/launchers";

const { START, CENTER } = Gtk.Align;

function User() {
  const Avatar = (
    <image cssClasses={["avatar"]} file={`${SRC}/assets/avatar.jpg`} />
  );

  const Names = (
    <box vertical valign={CENTER}>
      <label label={name.username} cssClasses={["avatar", "title"]} halign={START} />
      <label label={name.hostname} halign={START} />
    </box>
  );

  return (
    <box cssClasses={["user-info", "section"]}>
      {Avatar}
      {Names}
    </box>
  );
}

export default (
  <popover
    name="dashboard"
    cssClasses={["dashboard"]}
    hasArrow={false}
  >
    <box vertical>
      <User />
      <Toggles />
      <Launchers />
    </box>
  </popover>
);
