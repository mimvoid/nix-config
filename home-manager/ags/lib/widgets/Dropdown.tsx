import { bind, Variable } from "astal";
import { Widget, Gtk } from "astal/gtk3";

const { START, CENTER, END } = Gtk.Align;

interface DropdownProps extends Widget.RevealerProps {
  label?: string | Gtk.Widget;
  transitionDuration?: number;
  transitionType?: Gtk.RevealerTransitionType;
}

export default function Dropdown({
  child,
  label,
  revealChild = true,
  transitionDuration = 250,
  transitionType = Gtk.RevealerTransitionType.SLIDE_DOWN,
  ...props
}: DropdownProps): Gtk.Widget {

  const revealed = Variable(revealChild);

  return (
    <box className={bind(revealed).as((r) => `dropdown section ${r ? "open" : "closed"}`)} vertical>
      <button onClick={() => revealed.set(!revealed.get())} cursor="pointer" expand>
        <box valign={CENTER}>
          <box halign={START} valign={CENTER}>{label}</box>
          <icon icon="pan-down-symbolic" halign={END} valign={CENTER} />
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
}
