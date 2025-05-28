import { bind } from "astal";
import { Widget, Gtk } from "astal/gtk4";

interface DropdownProps extends Widget.RevealerProps {
  label: Gtk.Widget;
  expanded: boolean;
  transitionDuration?: number;
  transitionType?: Gtk.RevealerTransitionType;
}

export default ({
  child,
  label,
  expanded = true,
  transitionDuration = 250,
  transitionType = Gtk.RevealerTransitionType.SLIDE_DOWN,
  ...props
}: DropdownProps): Gtk.Widget => {
  const Revealer = (
    <revealer
      transitionDuration={transitionDuration}
      transitionType={transitionType}
      revealChild={expanded}
      {...props}
    >
      {child}
    </revealer>
  ) as Gtk.Revealer;

  return (
    <box
      cssClasses={bind(Revealer, "revealChild").as((r) => [
        "dropdown",
        "section",
        r ? "open" : "closed",
      ])}
      vertical
    >
      <button
        setup={(self) => self.set_cursor_from_name("pointer")}
        onClicked={() => Revealer.revealChild = !Revealer.revealChild}
        hexpand
      >
        <box spacing={6}>
          <image iconName="pan-down-symbolic" />
          {label}
        </box>
      </button>
      {Revealer}
    </box>
  );
};
