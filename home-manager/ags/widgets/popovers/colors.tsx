import PickerList from "./colors/PickerList";
import Converter from "./colors/Converter";

export default (
  <popover
    cssClasses={["colors-popover"]}
    name="colorsPopover"
    hasArrow={false}
  >
    <box vertical>
      <Converter />
      <PickerList />
    </box>
  </popover>
);
