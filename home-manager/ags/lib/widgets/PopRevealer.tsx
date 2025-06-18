import { Binding } from "astal";
import { Widget, Gtk, hook } from "astal/gtk4";

interface PopRevealerProps extends Widget.PopoverProps {
  transitionDuration?: number | Binding<number>;
  transitionType?: Gtk.RevealerTransitionType;
}

export default ({
  child,
  transitionDuration = 150,
  transitionType = Gtk.RevealerTransitionType.SLIDE_DOWN,
  ...props
}: PopRevealerProps): Gtk.Popover => {
  const Revealer = (
    <revealer
      transitionDuration={transitionDuration}
      transitionType={transitionType}
      child={child}
    />
  ) as Gtk.Revealer;

  const Popover = (
    <popover {...props}>
      {Revealer}
    </popover>
  ) as Gtk.Popover;

  hook(Popover, Popover, "show", (self) => {
    self.add_css_class("pop-down");
  });

  hook(Revealer, Popover, "notify::visible", (self) => {
    self.revealChild = Popover.visible;
  });

  return Popover;
};
