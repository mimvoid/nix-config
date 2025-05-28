import { bind } from "astal";
import { Gdk, hook } from "astal/gtk4";

import Picker from "@services/colorpicker";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import { ColorDialogButton } from "@lib/astalified";
import Icons from "@lib/icons";
import ColorsPopover from "../popovers/colors";

const picker = Picker.get_default();

const Trigger = (
  <button
    setup={(self) => self.set_cursor_from_name("pointer")}
    cssClasses={["color-button"]}
    onClicked={() => picker.pick().catch(console.error)}
    tooltipText={bind(picker, "lastColor").as((c) => `Last color: ${c}`)}
    iconName={Icons.colorpicker}
  />
);

function Color() {
  // A circle showing the last picked color
  const colorDisplay = (
    <ColorDialogButton
      setup={(self) => {
        function colorHook() {
          const gRgb = new Gdk.RGBA();
          if (gRgb.parse(picker.lastColor)) {
            self.rgba = gRgb;
          } else if (!self.rgba) {
            gRgb.red = 0;
            gRgb.green = 0;
            gRgb.blue = 0;
            gRgb.alpha = 1;
            self.rgba = gRgb;
          }
        }
        colorHook();
        hook(self, picker, "notify::lastColor", colorHook);
      }}
      cssClasses={["color-display"]}
    />
  );

  // Include a color label and the circle
  return (
    <menubutton>
      <HoverRevealer
        hiddenChild={
          <box cssClasses={["color-box"]}>
            <label label={bind(picker, "lastColor")} />
            {colorDisplay}
          </box>
        }
      >
        {Trigger}
      </HoverRevealer>
      {ColorsPopover}
    </menubutton>
  );
}

export default () => (
  <box cssClasses={["colorpicker"]}>
    <Color />
  </box>
);
