import { bind, Variable, writeFile } from "astal";
import { Gtk, Gdk } from "astal/gtk4";
import Gio from "gi://Gio";

import Picker from "@services/colorpicker";

import Dropdown from "@lib/widgets/Dropdown";
import { ColorDialogButton, ScrolledWindow } from "@lib/astalified";
import { hexToRgb, hexToHsl } from "@lib/colors";
import Icons from "@lib/icons";
import { pointer } from "@lib/utils";

const picker = Picker.get_default();
const { START, CENTER, END } = Gtk.Align;

function ColorItem(color: string) {
  const curr = Variable(color);

  const Main = (
    <button
      setup={pointer}
      onClicked={() => picker.copy(curr.get())}
      cssClasses={["main-info"]}
      hexpand
    >
      <box>
        <ColorDialogButton
          setup={(self) => {
            const gRgb = new Gdk.RGBA();
            gRgb.parse(color);
            self.rgba = gRgb;
          }}
          cssClasses={["color-box"]}
          halign={START}
          valign={CENTER}
        />
        <label label={bind(curr)} halign={START} />
      </box>
    </button>
  );

  const Switcher = bind(curr).as((c) => {
    switch (c) {
      case color:
        const setRgb = () => curr.set(hexToRgb(color)!);
        return <button setup={pointer} label="rgb" onClicked={setRgb} />;
      case hexToRgb(color):
        const setHsl = () => curr.set(hexToHsl(color)!);
        return <button setup={pointer} label="hsl" onClicked={setHsl} />;
      default:
        const setHex = () => curr.set(color);
        return <button setup={pointer} label="hex" onClicked={setHex} />;
    }
  });

  const Actions = (
    <box className="actions" halign={END}>
      {Switcher}
      <button
        setup={pointer}
        iconName={Icons.actions.close}
        onClicked={() => picker.remove(color)}
      />
    </box>
  );

  return (
    <box cssClasses={["color-item"]} hexpand>
      {Main}
      {Actions}
    </box>
  );
}

function Actions() {
  const saveColors = () => {
    const Picker = new Gtk.FileDialog({
      acceptLabel: "Save",
      initialFolder: Gio.File.new_for_path(picker.storeFolder),
      initialName: "color-history.json",
    });

    Picker.save(null, null, (_, res) => {
      const newFile = Picker.save_finish(res)!;
      const newPath = newFile.get_path()!;
      writeFile(newPath, JSON.stringify(picker.colors));
    });
  };

  return (
    <box spacing={4} halign={END}>
      <button
        setup={pointer}
        onClicked={saveColors}
        tooltipText="Save color history to file"
        iconName={Icons.actions.save}
      />
      <button
        setup={pointer}
        onClicked={() => picker.clear()}
        tooltipText="Clear color history"
        iconName={Icons.actions.clearAll}
      />
    </box>
  );
}

export default () => {
  const Colors = bind(picker, "colors").as((c) =>
    c.map((color) => ColorItem(color)),
  );

  return (
    <ScrolledWindow heightRequest={350}>
      <Dropdown
        cssClasses={["colorpicker-list"]}
        label={<label label="History" cssClasses={["title"]} halign={START} />}
      >
        <box spacing={8} vertical>
          <Actions />
          {Colors}
        </box>
      </Dropdown>
    </ScrolledWindow>
  );
};
