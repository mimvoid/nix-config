/*

Brightness (dependency: brightnessctl)

signals
- `screen-changed` screen brightness value changed

properties
- `screen-value` screen brightness value, a float between 0 and 1

*/

class BrightnessService extends Service {
  static {
    Service.register(
      this,
      { 'screen-changed': ['float'], }, // signals
      { 'screen-value': ['float', 'rw'], }, // properties
    );
  }

  // this Service assumes only one device with backlight
  #interface = Utils.exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");

  // # prefix means private in JS
  #screenValue = 0;
  #max = Number(Utils.exec('brightnessctl max'));

  get screen_value() {
    return this.#screenValue;
  }

  set screen_value(percent) {
    if (percent < 0)
      percent = 0;

    if (percent > 1)
      percent = 1;

    Utils.execAsync(`brightnessctl set ${Math.floor(percent * 100)}% -q`);
    // the file monitor will handle the rest
  }

  constructor() {
    super();

    // setup monitor
    const brightness = `/sys/class/backlight/${this.#interface}/brightness`;
    Utils.monitorFile(brightness, () => this.#onChange());

    // initialize
    this.#onChange();
  }

  #onChange() {
    this.#screenValue = Number(Utils.exec('brightnessctl get')) / this.#max;

    // signals have to be explicitly emitted
    this.emit('changed'); // emits "changed"
    this.notify('screen-value'); // emits "notify::screen-value"

    // or use Service.changed(propName: string) which does the above two
    // this.changed('screen-value');

    // emit screen-changed with the percent as a parameter
    this.emit('screen-changed', this.#screenValue);
  }

  // overwriting the connect method, lets you
  // change the default event that widgets connect to
  connect(event = 'screen-changed', callback) {
    return super.connect(event, callback);
  }
}

// the singleton instance
const service = new BrightnessService;

// export to use in other modules
export default service;
