import { Gtk, hook, Astal } from "astal/gtk4";
import Cava from "gi://AstalCava";

const { END, FILL } = Gtk.Align;

export default () => {
  const cava = Cava.get_default()!;
  cava.bars = 12;
  cava.active = true;

  const Bars = cava
    .get_values()
    .map(
      (v) =>
        (
          <slider
            value={v}
            inverted
            orientation={Gtk.Orientation.VERTICAL}
            halign={FILL}
            hexpand
          />
        ) as Astal.Slider,
    );

  return (
    <box
      setup={(self) => {
        hook(self, cava, "notify::values", () => {
          for (let i = 0; i < Bars.length; i++) {
            Bars[i].value = cava.get_values()[i];
          }
        });
        self.connect("notify::visible", () => (cava.active = self.visible));
      }}
      cssClasses={["cava"]}
      spacing={2}
      valign={END}
      halign={FILL}
    >
      {Bars}
    </box>
  );
};
