import { bind } from "astal";
import Picker from "@services/colorpicker";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import { pointer } from "@lib/utils";
import Icons from "@lib/icons";
import ColorsPopover from "../popovers/colors";

const picker = Picker.get_default();

const Trigger = (
  <button
    setup={pointer}
    cssClasses={["color-button"]}
    onClicked={() => picker.pick().catch(console.error)}
    tooltipText={bind(picker, "colors").as(
      () => `Last color: ${picker.lastColor()}`,
    )}
    iconName={Icons.colorpicker}
  />
);

function Color() {
  // A circle showing the last picked color
  const colorDisplay = (
    <box cssClasses={["color-circle"]}>
      <box
        cssClasses={["color-display"]}
        css={bind(picker, "colors").as(
          () => `background-color: ${picker.lastColor()}`,
        )}
      />
    </box>
  );

  // Include a color label and the circle
  return (
    <menubutton>
      <HoverRevealer
        hiddenChild={
          <box cssClasses={["color-box"]}>
            {bind(picker, "colors").as(() => picker.lastColor())}
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
  <box cssClasses={["colorpicker", "icon-label"]}>
    <Color />
  </box>
);
