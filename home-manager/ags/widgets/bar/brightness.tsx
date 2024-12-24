import { bind, exec, execAsync, Variable, monitorFile } from "astal";
import { App, Gtk } from "astal/gtk3";
import Icon from "../../lib/icons";

const { CENTER } = Gtk.Align;

// Wlsunset toggler

const WlSunset = () => {
  // Call shell script toggle for wlsunset
  const toggle = () => {
    exec(`bash -c ${SRC}/scripts/wlsunset-toggle.sh`)
      .then((out) => console.log(out))
      .catch((err) => console.log(err));
  };

  // Create icon toggle button
  return (
    <button
      className="wlsunset-toggle"
      onClicked={toggle}
      cursor="pointer"
      tooltipText="Toggle wlsunset"
    >
      <icon icon={Icon.wlsunset} />
    </button>
  );
};

// Brightness label & slider
// from https://github.com/gitmeED331/agsv2

function GetBrightness() {
  const current = Number(exec("brightnessctl get"));
  const max = Number(exec("brightnessctl max"));

  const brightness = current / max;

  return brightness;
}

const currentBrightness = Variable(GetBrightness());

// Format brightness as percentage
const Label = (
  <label label={bind(currentBrightness).as((i) => `${Math.floor(i * 100)}%`)} />
);

// Sync slider with brightness value
const Slider = () => {
  const update = ({ value }) => {
    execAsync(`brightnessctl set ${Math.floor(value * 100)}% -q`).catch();
    currentBrightness.set(value);
  };

  return (
    <slider
      cursor="pointer"
      valign={CENTER}
      hexpand
      value={bind(currentBrightness)}
      onDragged={update}
    />
  );
};

// Reveal label & slider on hover
const BrightnessBox = () => {
  const Revealer = (
    <revealer
      transitionDuration={250}
      transitionType={Gtk.RevealerTransitionType.SLIDE_LEFT}
    >
      <box hexpand valign={CENTER}>
        <Slider />
        {Label}
      </box>
    </revealer>
  );

  return (
    <eventbox
      onHover={() => (Revealer.revealChild = true)}
      onHoverLost={() => (Revealer.revealChild = false)}
    >
      <box className="brightness-revealer">{Revealer}</box>
    </eventbox>
  );
};

export default function Brightness() {
  // Updating brightness values I believe
  // FIX: I don't know if this actually works
  function initializeValues() {
    currentBrightness.set(GetBrightness());
    Slider.value = currentBrightness.get();
  }

  setTimeout(initializeValues, 0);

  const myDevice = exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");

  monitorFile(`/sys/class/backlight/${myDevice}/brightness`),
    () => {
      currentBrightness.set(GetBrightness());
      Slider.value = currentBrightness.get();
    };

  return (
    <box className="brightness">
      <WlSunset />
      <BrightnessBox />
    </box>
  );
}
