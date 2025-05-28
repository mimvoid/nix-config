import { bind, Variable, writeFile } from "astal";
import { Gtk } from "astal/gtk4";
import Gio from "gi://Gio";

import Picker from "@services/colorpicker";

import Dropdown from "@lib/widgets/Dropdown";
import { ScrolledWindow } from "@lib/astalified";
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
        <box
          setup={(self) => {
            const colorClass = `color-${color.startsWith("#") ? color.substring(1) : color}`;
            self.add_css_class(colorClass);

            const sp = new Gtk.CssProvider();
            sp.load_from_string(
              `box.color-item box.${colorClass} { background-color: ${color}; }`,
            );

            self
              .get_style_context()
              .add_provider(sp, Gtk.STYLE_PROVIDER_PRIORITY_USER);
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
    const setRgb = () => {
      const rgb = hexToRgb(color);
      if (rgb) curr.set(rgb);
    };

    const setHsl = () => {
      const hsl = hexToHsl(color);
      if (hsl) curr.set(hsl);
    };

    switch (c) {
      case color:
        return <button setup={pointer} label="rgb" onClicked={setRgb} />;
      case hexToRgb(color):
        return <button setup={pointer} label="hsl" onClicked={setHsl} />;
      default:
        return (
          <button
            setup={pointer}
            label="hex"
            onClicked={() => curr.set(color)}
          />
        );
    }
  });

  const Actions = (
    <box className="actions" halign={END}>
      {Switcher}
      <button setup={pointer} onClicked={() => picker.remove(color)}>
        <image iconName={Icons.actions.close} />
      </button>
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

    const cancel = new Gio.Cancellable();
    Picker.save(null, cancel, (_, res) => {
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
