import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Picker from "@services/colorpicker";
import HoverRevealer from "@lib/widgets/HoverRevealer";
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
    <box cssClasses={["color-circle"]}>
      {bind(picker, "lastColor").as((c) => {
        const colorClass = `color-${c.startsWith("#") ? c.substring(1) : c}`;
        const sp = new Gtk.CssProvider();
        sp.load_from_string(
          `.color-circle box.${colorClass} { background-color: ${c}; }`,
        );

        return [
          <box
            setup={(self) =>
              self
                .get_style_context()
                .add_provider(sp, Gtk.STYLE_PROVIDER_PRIORITY_USER)
            }
            cssClasses={["color-display", colorClass]}
          />,
        ];
      })}
    </box>
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
        onClicked={() => (ColorsPopover.visible = true)}
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
