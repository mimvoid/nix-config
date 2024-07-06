import brightness from '../../services/brightness-service';
import WlsunsetToggle from './wlsunset';

const slider = Widget.Slider({
  on_change: self => brightness.screen_value = self.value,
  value: brightness.bind('screen-value'),
  draw_value: false,
  cursor: "pointer",
});

const label = Widget.Label({
  label: brightness.bind('screen-value').as(v => `${Math.floor(v * 100)}%`),
  setup: self => self.hook(brightness, (self, screenValue) => {
    // screenValue is the passed parameter from the 'screen-changed' signal
    self.label = screenValue ?? `0`;

    self.label = `${brightness.screenValue}`;
  }, 'screen-changed'),
});

const brightness_elements = Widget.Box({
  children: [ slider, label ],
  hexpand: true,
  vpack: "center",
})

const revealer = Widget.Revealer({
  child: brightness_elements,

  reveal_child: false,
  transition_duration: 250,
  transition: 'slide_left',
})

const eventbox = Widget.EventBox({
  on_hover: () => {
    revealer.reveal_child = true;
  },
  on_hover_lost: () => {
    revealer.reveal_child = false;
  },

  child: Widget.Box({
    child: revealer,
    class_name: "brightness-revealer",
  }),
})

export default () => Widget.Box({
  class_name: "brightness",
  children: [ WlsunsetToggle(), eventbox ],
})
