import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Gdk from "gi://Gdk";

import Picker from "@services/colorpicker";

import { ColorDialogButton } from "@lib/astalified";
import Dropdown from "@lib/widgets/Dropdown";

import Icons from "@lib/icons";
import { gRgbaToHex, gRgbaToHsl } from "@lib/colors";
import { pointer } from "@lib/utils";

const picker = Picker.get_default();

let color = new Gdk.RGBA({
  red: 245 / 255,
  green: 189 / 255,
  blue: 230 / 255,
  alpha: 1.0,
});
color.parse(picker.lastColor);

const colorLabel = Variable(color.to_string());

const Display = (
  <ColorDialogButton
    setup={(self) => {
      pointer(self);
      bind(self, "rgba").as((rgba) => {
        color = rgba;
        colorLabel.set(rgba.to_string());
      });
    }}
    rgba={color}
    cssClasses={["color-box"]}
    hexpand
    vexpand
  />
) as Gtk.ColorDialogButton;

function updateColor(value: string) {
  const newColor = color.parse(value);
  if (newColor) {
    Display.rgba = color;
    colorLabel.set(color.to_string());
  }
}

const Entry = (
  <entry
    placeholderText={colorLabel()}
    onChanged={(self) => updateColor(self.text)}
  />
) as Gtk.Entry;

function Switcher() {
  function Formats() {
    function updateLabel(value: string) {
      colorLabel.set(value);
      Entry.text = colorLabel.get();
    }

    const rgb = () => updateLabel(color.to_string());
    const hex = () => updateLabel(gRgbaToHex(color));
    const hsl = () => updateLabel(gRgbaToHsl(color));

    return (
      <box spacing={4} vertical halign={Gtk.Align.END}>
        <button setup={pointer} label="hex" onClicked={hex} />
        <button setup={pointer} label="rgb" onClicked={rgb} />
        <button setup={pointer} label="hsl" onClicked={hsl} />
      </box>
    );
  }

  return (
    <box cssClasses={["color-switcher"]} spacing={8} hexpand>
      {Display}
      <Formats />
    </box>
  );
}

function Enter() {
  function clear() {
    Entry.text = "";
    colorLabel.set(color.to_string());
  }

  const buttons = [
    {
      icon: Icons.actions.save,
      tooltip: "Add color to history",
      cmd: () => {
        picker.add(gRgbaToHex(color));
        clear();
      },
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
      },
    },
  ];

  return (
    <box vertical spacing={8}>
      {Entry}
      <box spacing={4} halign={Gtk.Align.END}>
        {buttons.map(({ icon, tooltip, cmd }) => (
          <button
            setup={pointer}
            onClicked={cmd}
            tooltipText={tooltip}
            iconName={icon}
          />
        ))}
      </box>
    </box>
  );
}

export default () => (
  <Dropdown label={<label label="Color Selector" cssClasses={["title"]} />}>
    <box cssClasses={["converter"]} vertical spacing={8}>
      <Switcher />
      <Enter />
    </box>
  </Dropdown>
);
