import { Variable, bind } from "astal";
import { App, Gtk, Gdk } from "astal/gtk3";
import Tray from "gi://AstalTray";
import Icon from "../../lib/icons";

const tray = Tray.get_default();

const TrayIcons = () => {
  // Create buttons for every system tray item
  const Items = bind(tray, "items").as((items) =>
    items.map((item) => {
      if (item.iconThemePath) App.add_icons(item.iconThemePath);

      const menu = item.create_menu();

      return (
        <button
          className="system-tray-item"
          tooltipMarkup={bind(item, "tooltipMarkup")}
          onDestroy={() => menu?.destroy()}
          onClickRelease={(self) => {
            menu?.popup_at_widget(
              self,
              Gdk.Gravity.SOUTH,
              Gdk.Gravity.NORTH,
              null,
            );
          }}
        >
          <icon gIcon={bind(item, "gicon")} />
        </button>
      );
    }),
  );

  // Wrap them all in a box
  return <box>{Items}</box>;
};

// Display system tray after clicking on a button
const Revealer = (
  <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
  >
    <TrayIcons />
  </revealer>
);

const SysTrayToggle = () => {
  const ToggleIcon = <icon className="hider" icon={Icon.hider} />;

  function toggle() {
    Revealer.revealChild = !Revealer.revealChild;
    // Change icon class to style it
    ToggleIcon.className = Revealer.revealChild ? "hider open" : "hider";
  }

  // Don't actually include the revealer in the hitbox
  return <eventbox onClick={() => toggle()}>{ToggleIcon}</eventbox>;
};

export default function SysTray() {
  return (
    <box className="system-tray">
      {Revealer}
      <SysTrayToggle />
    </box>
  );
}
