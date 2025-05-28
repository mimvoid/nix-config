import { execAsync, readFile, writeFile } from "astal";
import GObject, { register, property } from "astal/gobject";
import GLib from "gi://GLib";

const MAX_COLORS = 10;

@register({ GTypeName: "Colorpicker" })
export default class ColorPicker extends GObject.Object {
  static instance: ColorPicker;

  static get_default() {
    if (!this.instance) this.instance = new ColorPicker();
    return this.instance;
  }

  readonly storeFolder = GLib.get_user_state_dir() + "/ags";
  readonly storeFile = this.storeFolder + "/colorpicker.json";

  #colors = this.readColorsCache();

  @property()
  get colors() {
    return [...this.#colors];
  }

  set colors(colors) {
    this.#colors = colors;
    this.notify("colors");
    writeFile(this.storeFile, JSON.stringify(colors, null, 2));
  }

  @property()
  get lastColor() {
    return this.colors[this.colors.length - 1] || "#000000";
  }

  private readColorsCache(): string[] {
    try {
      return JSON.parse(readFile(this.storeFile));
    } catch (error) {
      writeFile(this.storeFile, "[]");
      return [];
    }
  }

  readonly pick = async () => {
    const color = await execAsync(
      "hyprpicker --format=hex --autocopy --no-fancy",
    ).catch(console.error);
    if (!color) return;

    this.add(color.toLowerCase());
    return color.toLowerCase();
  };

  readonly copy = async (color: string) => {
    execAsync(["wl-copy", color]).catch(console.error);
    execAsync(
      `notify-send "Colorpicker" "Copied to clipboard:\n\n${color}"`,
    ).catch(console.error);
  };

  readonly add = (color: string) => {
    let list = this.colors;

    if (list.includes(color)) {
      list = list.filter((c) => c !== color);
      list.push(color);
    } else {
      list.push(color);
      if (list.length > MAX_COLORS) list.shift();
    }

    this.colors = list;
  };

  readonly remove = (color: string) => {
    const newList = this.colors.filter((c) => c !== color);
    this.colors = newList;
  };

  readonly clear = () => (this.colors = []);
}
