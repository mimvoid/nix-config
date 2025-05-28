import { hook } from "astal/gtk4";
import Notifd from "gi://AstalNotifd";

import Icons from "@lib/icons";

const notifd = Notifd.get_default();

const NotifDnd = (
  <button
    setup={(self) => {
      self.set_cursor_from_name("pointer");

      function dndHook() {
        const dnd = notifd.dontDisturb;

        self.remove_css_class(dnd ? "off" : "on");
        self.add_css_class(dnd ? "on" : "off");
        self.tooltipText = `Turn ${dnd ? "off" : "on"} Do not Disturb`;
        self.iconName = Icons.notifications[dnd ? "off" : "on"];
      }

      dndHook();
      hook(self, notifd, "notify::dont-disturb", dndHook);
    }}
    cssClasses={["dnd-toggle", "big-toggle"]}
    onClicked={() => (notifd.dontDisturb = !notifd.dontDisturb)}
  />
);

export default () => (
  <box cssClasses={["toggles", "section"]} spacing={10}>
    {NotifDnd}
  </box>
);
