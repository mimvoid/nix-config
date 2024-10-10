const notifications = await Service.import("notifications");

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
function NotificationIcon({ app_entry, app_icon, image }) {
  // Default icon
  let icon = "dialog-information-symbolic";

  // Uses an image for the icon, if available
  if (image) {
    return Widget.Box({
      css:
        `background-image: url("${image}");` +
        "background-size: contain;" +
        "background-repeat: no-repeat;" +
        "background-position: center;",
    });
  }

  // Picks an icon for an app, if available
  if (Utils.lookUpIcon(app_icon)) icon = app_icon;

  if (app_entry && Utils.lookUpIcon(app_entry)) icon = app_entry;

  return Widget.Box({
    child: Widget.Icon(icon),
  });
}

/** @param {import('resource:///com/github/Aylur/ags/service/notifications.js').Notification} n */
function Notification(n) {
  // The 4 elements of a notification
  const icon = Widget.Box({
    class_name: "icon",
    vpack: "start",

    child: NotificationIcon(n),
  });

  const title = Widget.Label({
    class_name: "title",

    xalign: 0,
    justification: "left",
    hexpand: true,

    max_width_chars: 24,
    truncate: "end",
    wrap: true,
    use_markup: true,

    label: n.summary,
  });

  const body = Widget.Label({
    class_name: "body",

    xalign: 0,
    justification: "left",
    hexpand: true,
    wrap: true,
    use_markup: true,

    label: n.body,
  });

  const actions = Widget.Box({
    class_name: "actions",
    children: n.actions.map(({ id, label }) =>
      Widget.Button({
        class_name: "action-button",
        on_clicked: () => {
          n.invoke(id);
          n.dismiss();
        },
        hexpand: true,
        hpack: "center",
        child: Widget.Label(label),
      }),
    ),
  });

  // Groupings of the elements
  const text = Widget.Box({
    children: [title, body],
    vertical: true,
    hpack: "start",
  });

  const main = Widget.Box({
    children: [icon, text],
  });

  const all = Widget.Box({
    class_name: `notification ${n.urgency}`,

    children: [main, actions],
    vertical: true,
  });

  // Putting it all together
  return Widget.EventBox({
    attribute: { id: n.id },
    on_primary_click: n.dismiss,

    child: all,
  });
}

// Handling multiple notifications
const list = Widget.Box({
  vertical: true,
  children: notifications.popups.map(Notification),
});

function onNotified(_, /** @type {number} */ id) {
  const n = notifications.getNotification(id);
  if (n) list.children = [Notification(n), ...list.children];
}

function onDismissed(_, /** @type {number} */ id) {
  list.children.find((n) => n.attribute.id === id)?.destroy();
}

list
  .hook(notifications, onNotified, "notified")
  .hook(notifications, onDismissed, "dismissed");

// Notification window
export default (monitor: number) =>
  Widget.Window({
    monitor,
    name: `notifications-${monitor}`,
    class_name: "notification-popups",
    anchor: ["top", "right"],
    child: Widget.Box({
      class_name: "notifications",
      vertical: true,
      child: list,
    }),
  });
