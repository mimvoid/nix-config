import { bind } from "astal";
import Notifd from "gi://AstalNotifd";

import Icons from "@lib/icons";
import { pointer } from "@lib/utils";

const notifd = Notifd.get_default();

const NotifDnd = (
  <button
    setup={pointer}
    cssClasses={bind(notifd, "dontDisturb").as((d) => ["dnd-toggle", "big-toggle", d ? "on" : "off"])}
    tooltipText={bind(notifd, "dontDisturb").as(
      (d) => `Turn ${d ? "off" : "on"} Do not Disturb`,
    )}
    onClicked={() => (notifd.dontDisturb = !notifd.dontDisturb)}
    iconName={bind(notifd, "dontDisturb").as((d) =>
      d ? Icons.notifications.off : Icons.notifications.on,
    )}
  />
);

export default () => (
  <box cssClasses={["toggles", "section"]} spacing={10}>
    {NotifDnd}
  </box>
);
