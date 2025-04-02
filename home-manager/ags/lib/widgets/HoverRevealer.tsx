import { Binding } from "astal";
import { Widget, Gtk } from "astal/gtk4";
import { pointer } from "../utils";

interface HoverRevealerProps extends Widget.ButtonProps {
  hiddenChild: Gtk.Widget;
  transitionDuration?: number | Binding<number>;
  transitionType?: Gtk.RevealerTransitionType;
}

export default ({
  hiddenChild,
  child,
  transitionDuration = 250,
  transitionType = Gtk.RevealerTransitionType.SLIDE_RIGHT,
  ...props
}: HoverRevealerProps): Gtk.Widget => {
  const Revealer = (
    <revealer
      transitionDuration={transitionDuration}
      transitionType={transitionType}
    >
      {hiddenChild}
    </revealer>
  ) as Gtk.Revealer;

  const result = (
    <button
      onHoverEnter={() => (Revealer.revealChild = true)}
      onHoverLeave={() => (Revealer.revealChild = false)}
      {...props}
    >
      <box cssClasses={["revealer-box"]}>
        {Revealer}
        {child}
      </box>
    </button>
  );

  result.add_css_class("hover-revealer");
  pointer(result);

  return result;
};
