import { bind, exec, execAsync, Variable, monitorFile } from "astal"
import { App, Gtk } from "astal/gtk3"
import Icon from "../../lib/icons"

// brightness slider
// from https://github.com/gitmeED331/agsv2

function GetBrightness() {
  const current = Number(exec("brightnessctl get"))
  const max = Number(exec("brightnessctl max"))

  const brightness = current / max;
  return brightness
}

let currentBrightness = Variable(GetBrightness());

export default function Brightness() {
  function initializeValues() {
    currentBrightness = GetBrightness();
    Slider.value = currentBrightness;
  }

  setTimeout(initializeValues, 0)

  const myDevice = exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");

  monitorFile(`/sys/class/backlight/${myDevice}/brightness`), () => {
    currentBrightness = GetBrightness();
    Slider.value = currentBrightness;
  }

  // toggle for wlsunset
  const WlSunset = <button
    className="wlsunset-toggle"
    onClicked={() => exec(`bash -c ${SRC}/scripts/wlsunset-toggle.sh`)
      .then((out) => console.log(out))
      .catch((err) => console.log(err))}
    cursor="pointer"
    tooltipText="Toggle wlsunset" >
      <icon icon={Icon.wlsunset} />
  </button>

  const Label = <label
    label={bind(currentBrightness).as((i) => (`${Math.floor(i * 100)}%`))} />

  // FIX: slider value does not change immediately
  const Slider = <slider
    cursor="pointer"
    valign={Gtk.Align.CENTER}
    hexpand
    value={bind(currentBrightness)}
    onDragged={({value}) => {
      execAsync(`brightnessctl set ${Math.floor(value * 100)}% -q`).catch();
      currentBrightness = value;
      }
    } />

  const Revealer = <revealer
    transitionDuration={250}
    transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT} >
      <box hexpand valign={Gtk.Align.CENTER} >
        {Slider}
        {Label}
      </box>
  </revealer>

  const BrightnessBox = <eventbox
    onHover={() => Revealer.revealChild = true}
    onHoverLost={() => Revealer.revealChild = false} >
      <box className="brightness-revealer" >
        {Revealer}
      </box>
  </eventbox>

  return <box className="brightness">
    {WlSunset}
    {BrightnessBox}
  </box>
}
