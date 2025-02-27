import GObject, { register, property } from "astal/gobject";
import { execAsync } from "astal";

@register({ GTypeName: "Colorpicker" })
export default class ColorPicker extends GObject.Object {
  static instance: ColorPicker;

  static get_default() {
    if (!this.instance) this.instance = new ColorPicker();
    return this.instance;
  }

  #color = "#F5BDE6" // default value

  @property(String)
  get color() {
    return this.#color;
  }

  set color(value) {
    this.#color = value;
    this.notify("color");
  }

  readonly pick = async () => {
    const out = await execAsync("hyprpicker --format=hex --autocopy --no-fancy").catch(console.error);
    if (!out) return;

    // FIX: still has an issue with updating the color
    this.#color = out;
    this.notify("color");
  }

  readonly copy = async () => {
    execAsync(["wl-copy", this.#color]).catch(console.error).catch(console.error);
    execAsync(`notify-send "Colorpicker" "Copied to clipboard:\n\n${this.#color}"`).catch(console.error);
  }
}
