import { bind } from "astal";
import Picker from "@services/colorpicker";
import HoverRevealer from "@lib/widgets/HoverRevealer";
import Icons from "@lib/icons";

const picker = Picker.get_default();

function Trigger() {
  const Icon = <icon icon={Icons.colorpicker} />;

  return (
    <button
      className="color-button"
      onClicked={() => picker.pick()}
      tooltipText={bind(picker, "color").as((c) => `Last color: ${c}`)}
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
        css={bind(picker, "color").as((c) => `background-color: ${c}`)}
      />
    </box>
  );

  // Include a color label and the circle
  return (
    <HoverRevealer
      hiddenChild={
        <button className="color-box" cursor="pointer" onClicked={() => picker.copy()}>
          <box>
            {bind(picker, "color").as((c) => c)}
            {colorDisplay}
          </box>
        </button>
      }
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
