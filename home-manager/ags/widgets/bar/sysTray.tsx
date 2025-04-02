import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Tray from "gi://AstalTray";
import Icon from "@lib/icons";
import { pointer } from "@lib/utils";

const tray = Tray.get_default();

function TrayIcons() {
  // Create buttons for every system tray item
  const Items = bind(tray, "items").as((items) =>
    items.map((item) => (
      <menubutton
        cssClasses={["system-tray-item"]}
        tooltipMarkup={bind(item, "tooltipMarkup")}
        actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
        menuModel={bind(item, "menuModel")}
      >
        <image setup={pointer} gicon={bind(item, "gicon")} />
      </menubutton>
    )),
  );

  // Wrap them all in a box
  return <box spacing={8}>{Items}</box>;
}

const reveal = Variable(false);

// Display system tray after clicking on a button
const Revealer = (
  <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
    revealChild={reveal()}
  >
    <TrayIcons />
  </revealer>
);

function SysTrayToggle() {
  const ToggleIcon = (
    <image
      cssClasses={bind(reveal).as((r) => ["hider", r ? "open" : ""])}
      iconName={Icon.hider}
    />
  );
  const Indicator = <box cssClasses={["indicator"]} />;

  // Don't actually include the revealer in the hitbox
  return (
    <button
      setup={pointer}
      cssClasses={bind(tray, "items").as((items) => [
        "hider-wrapper",
        items[0] ? "non-empty" : "empty",
      ])}
      onClicked={() => reveal.set(!reveal.get())}
    >
      <box>
        {Indicator}
        {ToggleIcon}
      </box>
    </button>
  );
}

export default function SysTray() {
  return (
    <box cssClasses={["system-tray"]}>
      {Revealer}
      <SysTrayToggle />
    </box>
  );
}
