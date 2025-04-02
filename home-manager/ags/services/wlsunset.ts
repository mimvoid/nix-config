import GObject, { register, property } from "astal/gobject";
import { exec, execAsync } from "astal";

function getWlsunset() {
  try {
    return exec("pidof wlsunset") !== null;
  } catch (err) {
    return false;
  }
}

// Create library
@register({ GTypeName: "wlsunset" })
export default class WlSunset extends GObject.Object {
  static instance: WlSunset;

  // WlSunset.get_default() returns this object
  static get_default() {
    if (!this.instance) this.instance = new WlSunset();
    return this.instance;
  }

  #running = getWlsunset();

  @property(Boolean)
  get running() {
    return this.#running;
  }

  set running(stat: boolean) {
    const setValue = stat ? "start" : "stop";

    execAsync(`systemctl --user ${setValue} wlsunset.service`)
      .then(() => {
        this.#running = stat;
        this.notify("running");
      })
      .catch(console.error);
  }
}
