import { Binding, Variable } from "astal";
import { Widget, Gtk } from "astal/gtk3";

interface HoverRevealerProps extends Widget.EventBoxProps {
  hiddenChild: Gtk.Widget;
  transitionDuration?: number | Binding<number | undefined> | undefined;
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

  return (
    <eventbox
      onHover={() => revealed.set(true)}
      onHoverLost={() => revealed.set(false)}
      {...props}
    >
      <box>
        {Revealer}
        {child}
      </box>
    </eventbox>
  );
}
