import { GLib } from "astal";
import { Gtk } from "astal/gtk4";
import Notifd from "gi://AstalNotifd";
import Pango from "gi://Pango";
import { pointer } from "@lib/utils";

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

export default function Notification(props: Props) {
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
          <box cssClasses={["icon-image"]} valign={START}>
            <image
              iconName={n.image}
              hexpand
              vexpand
              halign={CENTER}
              valign={CENTER}
            />
          </box>
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

    return (
      <box cssClasses={["content"]} vertical>
        {Summary}
        {n.body && Body}
      </box>
    );
  }

  // Create a button for each action if they exist
  const Actions = n.get_actions().length > 0 && (
    <box cssClasses={["actions"]}>
      {n.get_actions().map(({ label, id }) => (
        <button setup={pointer} onClicked={() => n.invoke(id)} hexpand>
          <label label={label} halign={CENTER} hexpand />
        </button>
      ))}
    </box>
  );

  // Put all the contents together
  const NotifBox = (
    <box cssClasses={["notification"]}>
      <Icon />
      <box vertical>
        <Header />
        <Content />
        {Actions}
      </box>
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
}
