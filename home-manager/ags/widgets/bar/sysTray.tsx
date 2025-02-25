import { bind } from "astal";
import { Gtk } from "astal/gtk3";
import Tray from "gi://AstalTray";
import Icon from "../../lib/icons";

const tray = Tray.get_default();

function TrayIcons() {
  // Create buttons for every system tray item
  const Items = bind(tray, "items").as((items) =>
    items.map((item) =>
      <menubutton
        className="system-tray-item"
        usePopover={false}
        tooltipMarkup={bind(item, "tooltipMarkup")}
        actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
        menuModel={bind(item, "menuModel")}
      >
        <icon gIcon={bind(item, "gicon")} />
      </menubutton>
    ),
  );

  // Wrap them all in a box
  return <box>{Items}</box>;
}

// Display system tray after clicking on a button
const Revealer = (
  <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
  >
    <TrayIcons />
  </revealer>
);

function SysTrayToggle() {
  const ToggleIcon = <icon className="hider" icon={Icon.hider} />
  const Indicator = <box className="indicator"></box>

  const toggle = () => {
    Revealer.revealChild = !Revealer.revealChild;

    // Change icon class to style it
    ToggleIcon.className = Revealer.revealChild ? "hider open" : "hider";
  };

  // Don't actually include the revealer in the hitbox
  return <eventbox onClick={toggle}>
    <box className={bind(tray, "items").as((items) => `hider-wrapper ${items.length > 0 ? "non-empty" : "empty"}`)}>
      {Indicator}
      {ToggleIcon}
    </box>
  </eventbox>;
}

export default function SysTray() {
  return (
    <box className="system-tray">
      {Revealer}
      <SysTrayToggle />
    </box>
  );
}
