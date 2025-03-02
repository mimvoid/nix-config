import { bind } from "astal";
import Picker from "@services/colorpicker";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import Icons from "@lib/icons";
import ColorsPopover from "../popovers/colors";

const picker = Picker.get_default();

function Trigger() {
  const Icon = <icon icon={Icons.colorpicker} />;

  return (
    <button
      className="color-button"
      onClicked={() => picker.pick().catch(console.error)}
      tooltipText={bind(picker, "colors").as(() => `Last color: ${picker.lastColor()}`)}
      cursor="pointer"
    >
      {Icon}
    </button>
  );
}

function Color() {
  // A circle showing the last picked color
  const colorDisplay = (
    <box className="color-circle">
      <box
        className="color-display"
        css={bind(picker, "colors").as(() => `background-color: ${picker.lastColor()}`)}
      />
    </box>
  );

  // Include a color label and the circle
  return (
    <HoverRevealer
      hiddenChild={
        <box className="color-box">
          {bind(picker, "colors").as(() => picker.lastColor())}
          {colorDisplay}
        </box>
      }
      onClick={() => ColorsPopover.visible.set(true)}
    >
      <Trigger />
    </HoverRevealer>
  );
}

export default function ColorPicker() {
  return (
    <box className="colorpicker icon-label">
      <Color />
    </box>
  );
}
