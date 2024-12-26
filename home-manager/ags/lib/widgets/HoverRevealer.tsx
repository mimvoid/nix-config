import { Gtk } from "astal/gtk3";

interface HoverRevealer {
  hiddenChild: JSX.Element;
  child: JSX.Element;
}

export default ({
  hiddenChild,
  child,
  ...props
}: HoverRevealer): JSX.Element => {
  const Revealer = (
    <revealer
      transitionDuration={250}
      transitionType={Gtk.RevealerTransitionType.SLIDE_RIGHT}
    >
      {hiddenChild}
    </revealer>
  );

  return (
    <eventbox
      onHover={() => (Revealer.revealChild = true)}
      onHoverLost={() => (Revealer.revealChild = false)}
      {...props}
    >
      <box>
        {Revealer}
        {child}
      </box>
    </eventbox>
  );
};
