import { GLib } from "astal";
import { Gtk } from "astal/gtk4";
import Notifd from "gi://AstalNotifd";
import Pango from "gi://Pango";

// Defines an individual notification widget

// App icon checkers
function isIcon(icon: string) {
  const iconTheme = new Gtk.IconTheme();
  return iconTheme.has_icon(icon);
}
const fileExists = (path: string) => GLib.file_test(path, GLib.FileTest.EXISTS);

// Format the timestamp
const time = (time: number, format = "%H:%M") =>
  GLib.DateTime.new_from_unix_local(time).format(format)!;

const urgency = (n: Notifd.Notification) => {
  const { LOW, NORMAL, CRITICAL } = Notifd.Urgency;
  // match operator when?
  switch (n.urgency) {
    case LOW:
      return "low";
    case CRITICAL:
      return "critical";
    case NORMAL:
    default:
      return "normal";
  }
};

type Props = {
  setup(self: Gtk.Box): void;
  onHoverLeave(self: Gtk.Box): void;
  notification: Notifd.Notification;
};

export default (props: Props) => {
  const { notification: n, onHoverLeave, setup } = props;
  const { START, CENTER, END } = Gtk.Align;

  // Notification structure

  // Display the icon in various possible formats
  function Icon() {
    let Image = (
      <image cssClasses={["app-icon"]} iconName="dialog-information-symbolic" />
    );

    if (n.appIcon || n.desktopEntry) {
      Image = (
        <image
          cssClasses={["app-icon"]}
          iconName={n.appIcon || n.desktopEntry}
        />
      );
    } else if (n.image) {
      if (fileExists(n.image)) {
        Image = <image cssClasses={["image"]} valign={START} file={n.image} />;
      } else if (isIcon(n.image)) {
        Image = (
          <image
            iconName={n.image}
            cssClasses={["icon-image"]}
            hexpand
            vexpand
            halign={CENTER}
            valign={CENTER}
          />
        );
      }
    }

    return <box cssClasses={["notif-icon"]}>{Image}</box>;
  }

  function Header() {
    const AppName = (
      <label
        cssClasses={["app-name"]}
        label={n.appName || "Unknown"}
        ellipsize={Pango.EllipsizeMode.END}
        halign={START}
      />
    );
    const Time = (
      <label label={time(n.time)} cssClasses={["time"]} hexpand halign={END} />
    );

    return (
      <box cssClasses={["header"]}>
        {AppName}
        {Time}
      </box>
    );
  }

  function Content() {
    const Summary = (
      <label
        label={n.summary}
        cssClasses={["summary"]}
        halign={START}
        xalign={0}
        wrap
      />
    );

    const Container = (
      <box cssClasses={["content"]} vertical>
        {Summary}
      </box>
    ) as Gtk.Box;

    if (n.body) {
      const Body = (
        <label
          label={n.body}
          cssClasses={["body"]}
          wrap
          maxWidthChars={36}
          useMarkup
          halign={START}
        />
      );

      Container.append(Body);
    }

    return Container;
  }

  // Put contents together
  const NotifText = (
    <box vertical>
      <Header />
      <Content />
    </box>
  ) as Gtk.Box;

  // Create a button for each action if they exist
  if (n.get_actions().length > 0) {
    const Actions = (
      <box cssClasses={["actions"]}>
        {n.get_actions().map(({ label, id }) => (
          <button
            setup={(self) => self.set_cursor_from_name("pointer")}
            onClicked={() => n.invoke(id)}
            hexpand
          >
            <label label={label} halign={CENTER} hexpand />
          </button>
        ))}
      </box>
    );

    NotifText.append(Actions);
  }

  // Put everything together
  const NotifBox = (
    <box cssClasses={["notification"]}>
      <Icon />
      {NotifText}
    </box>
  );

  // Handle urgency & events
  return (
    <box
      cssClasses={["notifications", urgency(n)]}
      setup={setup}
      onHoverLeave={onHoverLeave}
    >
      {NotifBox}
    </box>
  );
};
