import { bind, Variable, writeFile } from "astal";
import { Gtk } from "astal/gtk4";

import Picker from "@services/colorpicker";

import Dropdown from "@lib/widgets/Dropdown";
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
          cssClasses={["color-box"]}
          css={`
            background-color: ${color};
          `}
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
    const Picker = new Gtk.FileChooserNative({
      action: Gtk.FileChooserAction.SAVE,
      acceptLabel: "Save",
    });
    Picker.set_filename(picker.storePath);
    Picker.set_current_name("color-history.json");

    const res = Picker.run();
    if (res === Gtk.ResponseType.ACCEPT) {
      const newFilename = Picker.get_filename();
      if (!newFilename) return;

      writeFile(newFilename, JSON.stringify(picker.colors));
    }

    Picker.destroy();
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
    <Dropdown
      cssClasses={["colorpicker-list"]}
      label={<label label="History" cssClasses={["title"]} halign={START} />}
    >
      <box heightRequest={350}>
        <box spacing={8} vertical>
          <Actions />
          {Colors}
        </box>
      </box>
    </Dropdown>
  );
};
