import { execAsync, Variable, bind } from "astal";
import HoverRevealer from "../../lib/widgets/HoverRevealer";
import Icons from "../../lib/icons";

// Initial color value
const color = Variable("#F5BDE6");

function Trigger() {
  const Icon = <icon icon={Icons.colorpicker} />;

  return (
    <button
      className="color-button"
      onClicked={() =>
        // Update color Variable with hyprpicker
        // FIX: only updates with the second to last color
        execAsync("hyprpicker --format=hex -a -n")
          .then((out) => color.set(out))
          .catch((err) => printerr(err))
      }
      tooltipText={bind(color).as((c) => `Last color: ${c}`)}
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
        css={bind(color).as((c) => `background-color: ${c}`)}
      />
    </box>
  );

  // Include a color label and the circle
  return (
    <HoverRevealer
      hiddenChild={
        <box className="color-box">
          {bind(color)}
          {colorDisplay}
        </box>
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
