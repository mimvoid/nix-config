import { Astal, Gdk } from "astal/gtk4";
import { timeout, bind } from "astal";

import Notifd from "gi://AstalNotifd";
import Notification from "./notification";

const notifd = Notifd.get_default();
const TIMEOUT_DELAY = 5000;
const WINDOW_NAME = "notification-window";

function NotifItems() {
  const NotifsBox = <box cssClasses={["notifications"]} vertical />

  notifd.connect("notified", (_, id) => {
    const notification = notifd.get_notification(id);

    if (notifd.dontDisturb && notification.urgency != Notifd.Urgency.CRITICAL) {
      return;
    }

    const Item = Notification({
      notification: notifd.get_notification(id),
      onHoverLeave: (self) => {
        notification.dismiss();
        self.unparent;
      },
      setup: (self) => timeout(TIMEOUT_DELAY, () => {
        notification.dismiss();
        self.unparent;
      }),
    });

    Item.set_parent(NotifsBox);

    // Handle when notifications are closed from the outside before any user input
    notification.connect("resolved", () => Item.unparent);
  });

  return NotifsBox;
}

export default function NotificationPopups(gdkmonitor: Gdk.Monitor) {
  const { TOP, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name={WINDOW_NAME}
      cssClasses={["notification-popups"]}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | RIGHT}
      visible={bind(notifd, "notifications").as((n) => Boolean(n[0]))}
    >
      <NotifItems />
    </window>
  );
}
