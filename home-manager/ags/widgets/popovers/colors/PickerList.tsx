import { bind, Variable, writeFile } from "astal";
import { Gtk } from "astal/gtk3";

import Dropdown from "@lib/widgets/Dropdown";
import Picker from "@services/colorpicker";
import { hexToRgb, hexToHsl } from "@lib/colors";
import Icons from "@lib/icons";

import visible from "./visible";

const picker = Picker.get_default();
const { START, CENTER, END } = Gtk.Align;

function ColorItem(color: string) {
  const curr = Variable(color);

  const Main = (
    <button
      onClick={() => picker.copy(curr.get())}
      className="main-info"
      cursor="pointer"
      hexpand
    >
      <box>
        <box
          className="color-box"
          css={`background-color: ${color}`}
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
      if (rgb) curr.set(rgb)
    }

    const setHsl = () => {
      const hsl = hexToHsl(color);
      if (hsl) curr.set(hsl);
    }
    
    switch (c) {
      case color:
        return <button label="rgb" onClick={setRgb} cursor="pointer" />
      case hexToRgb(color):
        return <button label="hsl" onClick={setHsl} cursor="pointer" />
      default:
        return <button label="hex" onClick={() => curr.set(color)} cursor="pointer" />
    }
  })

  const Actions = (
    <box className="actions" halign={END}>
      {Switcher}
      <button onClick={() => picker.remove(color)} cursor="pointer" >
        <icon icon={Icons.actions.close} />
      </button>
    </box>
  )

  return (
    <box className="color-item" hexpand>
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

    visible.set(false);
    const res = Picker.run();
    if (res === Gtk.ResponseType.ACCEPT) {
      const newFilename = Picker.get_filename();
      if (!newFilename) return;

      writeFile(newFilename, JSON.stringify(picker.colors));
    }

    Picker.destroy();
  }

  return (
    <box spacing={4} halign={END}>
      <button onClick={saveColors} cursor="pointer" >
        <icon icon={Icons.actions.save} />
      </button>
      <button onClick={() => picker.clear()}>
        <icon icon={Icons.actions.clearAll} />
      </button>
    </box>
  )
}

export default function PickerList() {
  const Colors = bind(picker, "colors").as((c) =>
    c.map((color) => ColorItem(color))
  );

  const { EXTERNAL, NEVER } = Gtk.PolicyType;

  return (
    <Dropdown
      className="colorpicker-list"
      label={<label label="History" className="title" halign={START} />}
    >
      <scrollable hscroll={NEVER} vscroll={EXTERNAL} heightRequest={350}>
        <box spacing={8} vertical>
          <Actions />
          {Colors}
        </box>
      </scrollable>
    </Dropdown>
  );
}
