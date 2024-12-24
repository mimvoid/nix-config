import { bind, exec, monitorFile } from "astal";
import { Widget, Gtk } from "astal/gtk3";
import { brightness, getBrightness, setBrightness } from "./brightnessVar";
import WlSunset from "./wlsunset";

const { CENTER } = Gtk.Align;

// Brightness label & slider

function Slider() {
  // Update value on changes to backlight brightness file
  function setup(slider: Widget.Slider) {
    function updateValues() {
      brightness.set(getBrightness());
      slider.value = brightness.get();
    }
    setTimeout(updateValues, 0);

    const myDevice = exec("sh -c 'ls -w1 /sys/class/backlight | head -1'");
    monitorFile(`/sys/class/backlight/${myDevice}/brightness`, () =>
      updateValues(),
    );
  }

  // Change brightness on drag
  return (
    <slider
      setup={setup}
      cursor="pointer"
      valign={CENTER}
      hexpand
      value={bind(brightness)}
      onDragged={({ value }) => setBrightness(value)}
    />
  );
}

// Reveal label & slider on hover
const BrightnessBox = () => {
  // Format brightness as percentage
  const Label = (
    <label label={bind(brightness).as((i) => `${Math.floor(i * 100)}%`)} />
  );

  const Rev = (
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
      onHover={() => (Rev.revealChild = true)}
      onHoverLost={() => (Rev.revealChild = false)}
      onScroll={(_, { delta_y }) => {
        // Also change brightness by scrolling
        const step = 0.05;
        const brightnessValue = brightness.get();

        if (delta_y < 0) {
          brightnessValue <= 1 - step
            ? setBrightness(brightnessValue + step)
            : setBrightness(1);
        } else {
          brightnessValue >= step
            ? setBrightness(brightnessValue - step)
            : setBrightness(1);
        }
      }}
    >
      <box className="brightness-revealer">{Rev}</box>
    </eventbox>
  );
};

export default function Brightness() {
  return (
    <box className="brightness">
      <WlSunset />
      <BrightnessBox />
    </box>
  );
}
