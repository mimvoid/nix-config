import { Gtk } from "astal/gtk3";

import Popover from "@lib/widgets/Popover";

import visible from "./colors/visible";
import PickerList from "./colors/PickerList";
import Converter from "./colors/Converter";

const { START, END } = Gtk.Align;

function ColorsPopover() {
  const Widget = (
    <Popover
      className="colors-popover popover"
      name="colorsPopover"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={START}
      halign={END}
      marginTop={28}
      marginRight={12}
    >
      <box vertical>
        <Converter />
        <PickerList />
      </box>
    </Popover>
  )

  return {
    visible: visible,
    Widget: () => Widget
  }
}

export default ColorsPopover()
