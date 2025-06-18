import { bind } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Tray from "gi://AstalTray";
import Icon from "@lib/icons";

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
        <image
          setup={(self) => self.set_cursor_from_name("pointer")}
          gicon={bind(item, "gicon")}
        />
      </menubutton>
    )),
  );

  // Wrap them all in a box
  return <box spacing={8}>{Items}</box>;
}

// Display system tray after clicking on a button
const Revealer = (
  <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
  >
    <TrayIcons />
  </revealer>
) as Gtk.Revealer;

function SysTrayToggle() {
  const ToggleIcon = (
    <image
      setup={(self) =>
        hook(self, Revealer, "notify::reveal-child", () =>
          Revealer.revealChild
            ? self.add_css_class("open")
            : self.remove_css_class("open"),
        )
      }
      cssClasses={["hider"]}
      iconName={Icon.hider}
    />
  );
  const Indicator = <box cssClasses={["indicator"]} />;

  // Don't actually include the revealer in the hitbox
  return (
    <button
      setup={(self) => {
        self.set_cursor_from_name("pointer");
        if (tray.items && tray.items[0]) self.add_css_class("non-empty");

        hook(self, tray, "item-added", () => {
          if (!self.has_css_class("non-empty")) self.add_css_class("non-empty");
        });
        hook(self, tray, "item-removed", () => {
          if (!tray.items || !tray.items[0]) self.remove_css_class("non-empty");
        })
      }}
      cssClasses={["hider-wrapper"]}
      onClicked={() => (Revealer.revealChild = !Revealer.revealChild)}
    >
      <box>
        {Indicator}
        {ToggleIcon}
      </box>
    </button>
  );
}

export default () => (
  <box cssClasses={["system-tray"]}>
    {Revealer}
    <SysTrayToggle />
  </box>
);
