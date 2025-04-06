import { bind, Variable } from "astal";
import { Widget, Gtk } from "astal/gtk4";
import { pointer } from "../utils";

const { START, CENTER, END } = Gtk.Align;

interface DropdownProps extends Widget.RevealerProps {
  label: string | Gtk.Widget;
  transitionDuration?: number;
  transitionType?: Gtk.RevealerTransitionType;
}

export default ({
  child,
  label,
  revealChild = true,
  transitionDuration = 250,
  transitionType = Gtk.RevealerTransitionType.SLIDE_DOWN,
  ...props
}: DropdownProps): Gtk.Widget => {
  const revealed = Variable(revealChild);

  return (
    <box
      cssClasses={bind(revealed).as((r) => [
        "dropdown",
        "section",
        r ? "open" : "closed",
      ])}
      vertical
    >
      <button
        setup={pointer}
        onClicked={() => revealed.set(!revealed.get())}
        hexpand
        vexpand
      >
        <box valign={CENTER}>
          <box halign={START} valign={CENTER}>
            {label}
          </box>
          <image iconName="pan-down-symbolic" halign={END} valign={CENTER} />
        </box>
      </button>
      <revealer
        transitionDuration={transitionDuration}
        transitionType={transitionType}
        revealChild={revealed()}
        {...props}
      >
        {child}
      </revealer>
    </box>
  );
};
