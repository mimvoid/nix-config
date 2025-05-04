import { Astal, Gdk } from "astal/gtk4";
import { timeout, bind } from "astal";

import Notifd from "gi://AstalNotifd";
import { setLayerrules } from "@lib/utils";
import Notification from "./notification";

const notifd = Notifd.get_default();
const TIMEOUT_DELAY = 5000;
const WINDOW_NAME = "notification-window";

const Notifications = bind(notifd, "notifications").as((n) => {
  if (notifd.dontDisturb) {
    n = n.filter((notif) => notif.urgency === Notifd.Urgency.CRITICAL);
  }

  return n.map((notif) => {
    const remove = timeout(TIMEOUT_DELAY, () => notif.dismiss());

    return Notification({
      notification: notif,
      onHoverLeave: () => {
        remove.cancel();
        notif.dismiss();
      },
      setup: () => remove,
    });
  });
});

export default (gdkmonitor: Gdk.Monitor) => {
  const { TOP, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      setup={(self) =>
        setLayerrules(self.namespace, [
          "animation slidefade right",
          "blur",
          "ignorezero",
          "xray 0",
        ])
      }
      name={WINDOW_NAME}
      namespace={WINDOW_NAME}
      cssClasses={["notification-popups"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | RIGHT}
      visible={bind(notifd, "notifications").as((n) => Boolean(n[0]))}
    >
      <box cssClasses={["notifications"]} vertical>
        {Notifications}
      </box>
    </window>
  );
};
