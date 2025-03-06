import { Binding, Variable } from "astal";
import { Widget, Gtk } from "astal/gtk4";
import { pointer } from "../utils";

interface HoverRevealerProps extends Widget.ButtonProps {
  hiddenChild: Gtk.Widget;
  transitionDuration?: number | Binding<number>;
  transitionType?: Gtk.RevealerTransitionType;
}

export default function HoverRevealer({
  hiddenChild,
  child,
  transitionDuration = 250,
  transitionType = Gtk.RevealerTransitionType.SLIDE_RIGHT,
  ...props
}: HoverRevealerProps): Gtk.Widget {

  const revealed = Variable(false);

  const Revealer = (
    <revealer
      transitionDuration={transitionDuration}
      transitionType={transitionType}
      revealChild={revealed()}
    >
      {hiddenChild}
    </revealer>
  );

  const result = (
    <button
      onHoverEnter={() => revealed.set(true)}
      onHoverLeave={() => revealed.set(false)}
      {...props}
    >
      <box className="revealer-box">
        {Revealer}
        {child}
      </box>
    </button>
  );

  result.add_css_class("hover-revealer");
  pointer(result);

  return result;
}
