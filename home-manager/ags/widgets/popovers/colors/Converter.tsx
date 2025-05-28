import { Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Gdk from "gi://Gdk";

import Picker from "@services/colorpicker";

import { ColorDialogButton } from "@lib/astalified";
import Dropdown from "@lib/widgets/Dropdown";

import Icons from "@lib/icons";
import { gRgbaToHex, gRgbaToHsl } from "@lib/colors";
import { pointer } from "@lib/utils";

const picker = Picker.get_default();

const color = Variable(
  new Gdk.RGBA({
    red: 245 / 255,
    green: 189 / 255,
    blue: 230 / 255,
    alpha: 1.0,
  }),
);

function updateColor(value: string) {
  const newColor = new Gdk.RGBA();
  if (newColor.parse(value)) color.set(newColor);
}
updateColor(picker.lastColor);

const Entry = (
  <entry
    setup={(self) => color.subscribe((value) => self.placeholderText = value.to_string())}
    placeholderText={color.get().to_string()}
    onChanged={(self) => updateColor(self.text)}
  />
) as Gtk.Entry;

function Switcher() {
  const Display = (
    <ColorDialogButton
      setup={pointer}
      rgba={color()}
      cssClasses={["color-box"]}
      hexpand
      vexpand
    />
  );

  function updateLabel(value: string) {
    Entry.placeholderText = value;
    Entry.text = value;
  }
  const rgb = () => updateLabel(color.get().to_string());
  const hex = () => updateLabel(gRgbaToHex(color.get()));
  const hsl = () => updateLabel(gRgbaToHsl(color.get()));

  const Formats = (
    <box spacing={4} vertical halign={Gtk.Align.END}>
      <button setup={pointer} label="hex" onClicked={hex} />
      <button setup={pointer} label="rgb" onClicked={rgb} />
      <button setup={pointer} label="hsl" onClicked={hsl} />
    </box>
  );

  return (
    <box cssClasses={["color-switcher"]} spacing={8} hexpand>
      {Display}
      {Formats}
    </box>
  );
}

function EntryBox() {
  function clear() {
    Entry.placeholderText = color.get().to_string();
    Entry.text = "";
  }

  const buttons = [
    {
      icon: Icons.actions.save,
      tooltip: "Add color to history",
      cmd: () => {
        picker.add(gRgbaToHex(color.get()));
        clear();
      },
    },
    {
      icon: Icons.actions.copy,
      tooltip: "Copy color to clipboard",
      cmd: () => picker.copy(Entry.placeholderText),
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
        const newColor = (await picker.pick())!;
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
    <box
      cssClasses={["converter"]}
      vertical
      spacing={8}
      onDestroy={() => color.drop()}
    >
      <Switcher />
      <EntryBox />
    </box>
  </Dropdown>
);
