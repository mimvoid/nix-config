import GObject, { register, property } from "astal/gobject";
import { monitorFile, readFileAsync } from "astal/file";
import { exec, execAsync } from "astal";

// Fetch brightness light from brightnessctl
const current = Number(exec("brightnessctl get"));
const max = Number(exec("brightnessctl max"));
const value = current / max;

// Create library
@register({ GTypeName: "Brightness" })
export default class Brightness extends GObject.Object {
  static instance: Brightness;

  // Brightness.get_default() returns this object
  static get_default() {
    if (!this.instance) this.instance = new Brightness();

    return this.instance;
  }

  // brightness.light, the only value I need
  #light = value;

  @property(Number)
  get light() {
    return this.#light;
  }

  set light(percent) {
    // Check for limits
    if (percent < 0) percent = 0;
    if (percent > 1) percent = 1;

    // Update brightness lights
    execAsync(`brightnessctl set ${Math.floor(percent * 100)}% -q`).then(() => {
      this.#light = percent;
      this.notify("light");
    });
  }

  constructor() {
    super();

    const monitor = exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");

    // Update brightness on changes to the file
    monitorFile(`/sys/class/backlight/${monitor}/brightness`, async (f) => {
      const v = await readFileAsync(f);
      this.#light = Number(v) / max;
      this.notify("light");
    });
  }
}
