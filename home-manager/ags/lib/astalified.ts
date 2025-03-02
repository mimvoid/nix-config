import { Gtk, astalify, type ConstructProps } from "astal/gtk3";
import GObject from "gi://GObject";

export class Calendar extends astalify(Gtk.Calendar) {
  static {
    GObject.registerClass(this);
  }

  constructor(props: ConstructProps<Calendar, Gtk.Calendar.ConstructorProps, {}>) {
    super(props as any);
  }
}

export class ColorButton extends astalify(Gtk.ColorButton) {
  static {
    GObject.registerClass(this);
  }

  constructor(props: ConstructProps<ColorButton, Gtk.ColorButton.ConstructorProps, {}>) {
    super(props as any);
  }
}
