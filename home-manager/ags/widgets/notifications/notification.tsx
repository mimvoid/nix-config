import { GLib } from "astal";
import { Gtk, Astal } from "astal/gtk3";
import { type EventBox } from "astal/gtk3/widget";
import Notifd from "gi://AstalNotifd";

// Defines an individual notification widget

// App icon checkers
const isIcon = (icon: string) => !!Astal.Icon.lookup_icon(icon);
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
  setup(self: EventBox): void;
  onHoverLost(self: EventBox): void;
  notification: Notifd.Notification;
};

export default function Notification(props: Props) {
  const { notification: n, onHoverLost, setup } = props;
  const { START, CENTER, END } = Gtk.Align;

  // Notification structure

  // Display the icon in various possible formats
  function Icon() {
    const DesktopEntry = (n.appIcon || n.desktopEntry) && (
      <icon
        className="app-icon"
        visible={Boolean(n.appIcon || n.desktopEntry)}
        icon={n.appIcon || n.desktopEntry}
      />
    );
    const ImageFile = n.image && fileExists(n.image) && (
      <box
        valign={START}
        className="image"
        css={`
          background-image: url("${n.image}");
        `}
      />
    );
    const IconImage = n.image && isIcon(n.image) && (
      <box expand={false} valign={START} className="icon-image">
        <icon icon={n.image} expand halign={CENTER} valign={CENTER} />
      </box>
    );
    const DefaultIcon = !n.appIcon && !n.desktopEntry && !n.image && (
      <icon className="app-icon" icon="dialog-information-symbolic" />
    );

    return (
      <box className="notif-icon">
        {DesktopEntry}
        {ImageFile}
        {IconImage}
        {DefaultIcon}
      </box>
    );
  }

  function Header() {
    const AppName = (
      <label
        className="app-name"
        label={n.appName || "Unknown"}
        halign={START}
        truncate
      />
    );
    const Time = (
      <label className="time" hexpand halign={END} label={time(n.time)} />
    );

    return (
      <box className="header">
        {AppName}
        {Time}
      </box>
    );
  }

  function Content() {
    const Summary = (
      <label
        className="summary"
        halign={START}
        xalign={0}
        label={n.summary}
        truncate
      />
    );
    const Body = n.body && (
      <label
        className="body"
        wrap
        useMarkup
        halign={START}
        xalign={0}
        label={n.body}
      />
    );

    return (
      <box className="content" vertical>
        {Summary}
        {Body}
      </box>
    );
  }

  // Create a button for each action if they exist
  const Actions = n.get_actions().length > 0 && (
    <box className="actions">
      {n.get_actions().map(({ label, id }) => (
        <button hexpand onClicked={() => n.invoke(id)}>
          <label label={label} halign={CENTER} hexpand />
        </button>
      ))}
    </box>
  );

  // Put all the contents together
  const NotifBox = (
    <box className="notification">
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
    <eventbox
      className={`notifications ${urgency(n)}`}
      setup={setup}
      onHoverLost={onHoverLost}
    >
      {NotifBox}
    </eventbox>
  );
}
