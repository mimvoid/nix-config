import { Variable } from "astal";
import { Gtk } from "astal/gtk3";
import Gdk from "gi://Gdk";

import Picker from "@services/colorpicker";

import { ColorButton } from "@lib/astalified";
import Dropdown from "@lib/widgets/Dropdown";

import Icons from "@lib/icons";
import { gRgbaToHex, gRgbaToHsl } from "@lib/colors";

const picker = Picker.get_default();

let color = new Gdk.RGBA({
  red: (245 / 255),
  green: (189 / 255),
  blue: (230 / 255),
  alpha: 1.0
});
color.parse(picker.lastColor());

const colorLabel = Variable(color.to_string());

const Display = (
  <ColorButton
    rgba={color}
    className="color-box"
    cursor="pointer"
    onColorSet={(self) => {
      color = self.rgba;
      colorLabel.set(self.rgba.to_string());
    }}
    expand
  />
);

function updateColor(value: string) {
  const newColor = color.parse(value);
  if (newColor) {
    Display.set_property("rgba", color);
    colorLabel.set(color.to_string());
  }
}

const Entry = (
  <entry
    placeholderText={colorLabel()}
    onChanged={(self) => updateColor(self.text)}
  />
)

function Switcher() {
  function Formats() {
    function updateLabel(value: string) {
      if (!value) return;
      colorLabel.set(value);
      Entry.set_property("text", colorLabel.get());
    }

    const rgb = () => updateLabel(color.to_string());
    const hex = () => updateLabel(gRgbaToHex(color));
    const hsl = () => updateLabel(gRgbaToHsl(color));

    return (
      <box spacing={4} vertical halign={Gtk.Align.END}>
        <button label="hex" cursor="pointer" onClick={hex} />
        <button label="rgb" cursor="pointer" onClick={rgb} />
        <button label="hsl" cursor="pointer" onClick={hsl} />
      </box>
    )
  }

  return (
    <box className="color-switcher" spacing={8} hexpand>
      {Display}
      <Formats />
    </box>
  )
}

function Enter() {
  const clear = () => {
    Entry.set_property("text", "");
    colorLabel.set(color.to_string());
  }

  const buttons = [
    {
      icon: Icons.actions.save,
      tooltip: "Add color to history",
      cmd: () => {
        picker.add(gRgbaToHex(color));
        clear();
      }
    },
    {
      icon: Icons.actions.copy,
      tooltip: "Copy color to clipboard",
      cmd: () => picker.copy(colorLabel.get()),
    },
    {
      icon: Icons.actions.clear,
      tooltip: "Clear color text",
      cmd: clear,
    },
    {
      icon: Icons.colorpicker,
      tooltip: "Pick color",
      cmd: async () => {
        const newColor = await picker.pick();
        if (!newColor) return;
        updateColor(newColor);
      }
    }
  ]

  return (
    <box vertical spacing={8}>
      {Entry}
      <box spacing={4} halign={Gtk.Align.END}>
        {buttons.map((b) => (
          <button onClick={b.cmd} tooltipText={b.tooltip} cursor="pointer">
            <icon icon={b.icon} />
          </button>
        ))}
      </box>
    </box>
  )
}

export default function Converter() {
  return (
    <Dropdown label={<label label="Color Selector" className="title" />}>
      <box className="converter" vertical spacing={8}>
        <Switcher />
        <Enter />
      </box>
    </Dropdown>
  )
}
