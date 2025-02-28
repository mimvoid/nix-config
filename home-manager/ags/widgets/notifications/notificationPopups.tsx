import { Astal, Gtk, Gdk } from "astal/gtk3";
import { Subscribable } from "astal/binding";
import { Variable, bind, timeout } from "astal";

import Notifd from "gi://AstalNotifd";
import Notification from "./notification";

const notifd = Notifd.get_default();
const TIMEOUT_DELAY = 5000;

// Maps notifications and puts them in a window

// Use a Map<number, Widget> type to track notification widgets by their id,
// while making it bindable as an array

class NotificationMap implements Subscribable {
  private map: Map<number, Gtk.Widget> = new Map(); // for id widget pairs
  private var: Variable<Array<Gtk.Widget>> = Variable([]);

  // Notify subscribers to rerender when state changes
  private notifiy() {
    this.var.set([...this.map.values()].reverse());
  }

  private constructor() {
    if (notifd.dontDisturb) return;

    notifd.ignoreTimeout = true;

    notifd.connect("notified", (_, id) => {
      this.set(id, Notification({
        notification: notifd.get_notification(id),
        onHoverLost: () => this.dismiss(id),
        setup: () => timeout(TIMEOUT_DELAY, () => this.dismiss(id)),
      }));
    });

    // Handle when notifications are closed from the outside before any user input
    notifd.connect("resolved", (_, id) => this.dismiss(id));
  }

  private set(key: number, value: Gtk.Widget) {
    this.map.get(key)?.destroy(); // In case of replacement, destroy previous widget
    this.map.set(key, value);
    this.notifiy();
  }

  private dismiss(key: number) {
    this.map.get(key)?.destroy();
    notifd.get_notification(key)?.dismiss();
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
  const notifs = new NotificationMap();

  return (
    <window
      name="notification-window"
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
