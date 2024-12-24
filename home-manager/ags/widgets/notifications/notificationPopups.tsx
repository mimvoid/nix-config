import { Astal, Gtk, Gdk } from "astal/gtk3";
import { type Subscribable } from "astal/binding";
import { Variable, bind, timeout } from "astal";

import Notifd from "gi://AstalNotifd";
import Notification from "./notification";

// Maps notifications and puts them in a window
// from https://github.com/Aylur/astal/blob/main/examples/js/notifications/notifications/NotificationPopups.tsx

// see comment below in constructor
const TIMEOUT_DELAY = 5000;

// This class replaces Variable<Array<Widget>>
// with a Map<number, Widget> type to track notification widgets by their id,
// while making it conveniently bindable as an array

class NotifiationMap implements Subscribable {
  // The underlying map to keep track of id widget pairs
  private map: Map<number, Gtk.Widget> = new Map();

  // It makes sense to use a Variable under the hood and use its
  // reactivity implementation instead of keeping track of subscribers ourselves
  private var: Variable<Array<Gtk.Widget>> = Variable([]);

  // Notify subscribers to rerender when state changes
  private notifiy() {
    this.var.set([...this.map.values()].reverse());
  }

  private constructor() {
    const notifd = Notifd.get_default();

    // Ignore timeout by senders and enforce our own

    // NOTE: if the notification has any actions
    // they might not work, since the sender already treats them as resolved
    notifd.ignoreTimeout = true;

    notifd.connect("notified", (_, id) => {
      this.set(
        id,
        Notification({
          notification: notifd.get_notification(id)!,

          // Once hovering over the notification is done,
          // destroy the widget without calling notification.dismiss(),
          // so that it acts as a "popup" and we can still display it
          // in a notification center-like widget,
          // but clicking on the close button will close it

          // TODO: Actually, do dismiss it (see function below)
          // I do not like notification centers
          onHoverLost: () => this.delete(id),

          // Notifd by default does not close notifications
          // until user input or the timeout specified by sender,
          // which we set to ignore above
          setup: () =>
            timeout(TIMEOUT_DELAY, () => {
              this.delete(id);
            }),
        }),
      );
    });

    // Handle when notifications are closed from
    // the outside before any user input
    notifd.connect("resolved", (_, id) => {
      this.delete(id);
    });
  }

  private set(key: number, value: Gtk.Widget) {
    // In case of replacement, destroy previous widget
    this.map.get(key)?.destroy();
    this.map.set(key, value);
    this.notifiy();
  }

  private delete(key: number) {
    this.map.get(key)?.destroy();
    this.map.delete(key);
    this.notifiy();
  }

  // Needed by the Subscribable interface
  get() {
    return this.var.get();
  }

  // Needed by the Subscribable interface
  subscribe(callback: (list: Array<Gtk.Widget>) => void) {
    return this.var.subscribe(callback);
  }
}

export default function NotificationPopups(gdkmonitor: Gdk.Monitor) {
  const { TOP, RIGHT } = Astal.WindowAnchor;
  const notifs = new NotifiationMap();

  return (
    <window
      name="notifications"
      className="notification-popups"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | RIGHT}
    >
      <box className="notifications" vertical>
        {bind(notifs)}
      </box>
    </window>
  );
}
