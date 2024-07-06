import brightness from '../../services/brightness-service';
import WlsunsetToggle from './wlsunset';

const slider = Widget.Slider({
  on_change: self => brightness.screen_value = self.value,
  value: brightness.bind('screen-value'),

  hexpand: true,
  vpack: "center",
  draw_value: false,
});

const slider_box = Widget.Revealer({
  child: slider,

  cursor: "pointer",
  reveal_child: false,
  transition_duration: 250,
  transition: 'slide_left',
})

const label = Widget.Label({
  label: brightness.bind('screen-value').as(v => `${Math.floor(v * 100)}%`),
  setup: self => self.hook(brightness, (self, screenValue) => {
    // screenValue is the passed parameter from the 'screen-changed' signal
    self.label = screenValue ?? 0;

    self.label = `${brightness.screenValue}`;
  }, 'screen-changed'),
});

const eventbox = Widget.EventBox({
  on_hover: () => {
    slider_box.reveal_child = true;
  },
  on_hover_lost: () => {
    slider_box.reveal_child = false;
  },

  child: Widget.Box({
    children: [slider_box, label],
  }), 
})

export default () => Widget.Box({
  class_name: "brightness",
  children: [ WlsunsetToggle(), eventbox ],
})
