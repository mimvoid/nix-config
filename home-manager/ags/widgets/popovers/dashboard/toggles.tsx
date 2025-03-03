import { bind } from "astal";
import Notifd from "gi://AstalNotifd";

import Icons from "@lib/icons";

const notifd = Notifd.get_default();

const NotifDnd = (
  <button
    className={bind(notifd, "dontDisturb").as((d) => d ? "on" : "off")}
    tooltipText={bind(notifd, "dontDisturb").as((d) => `Turn ${d ? "off" : "on"} Do not Disturb`)}
    onClick={() => notifd.dontDisturb = !notifd.dontDisturb}
    cursor="pointer"
  >
    <icon
      icon={bind(notifd, "dontDisturb").as((d) => d ? Icons.notifications.off : Icons.notifications.on)}
    />
  </button>
);

export default function Toggles() {
  return (
    <box className="toggles section">
      {NotifDnd}
    </box>
  );
}
