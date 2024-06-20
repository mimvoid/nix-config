const audio = await Service.import("audio")

const icons = {
  101: "overamplified",
  67: "high",
  34: "medium",
  1: "low",
  0: "muted",
}

function getIcon() {
  const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
    threshold => threshold <= audio.speaker.volume * 100)

  return `audio-volume-${icons[icon]}-symbolic`
}

const icon = Widget.Icon({
  icon: Utils.watch(getIcon(), audio.speaker, getIcon),
})

// FIX: slider doesn't show, with or without revealer
// It loads since the cursor changes, but it's just not visible?

const slider = Widget.Slider({
  class_name: "volume-slider",
  cursor: "pointer",
  hexpand: true,
  vpack: "center",
  draw_value: false,
  on_change: ({ value }) => audio.speaker.volume = value,
  setup: self => self.hook(audio.speaker, () => {
    self.value = audio.speaker.volume || 0
  }),
})

/*  const slider = Widget.Revealer({
  child: Widget.Slider({
    class_name: "volume-slider",
    cursor: "pointer",
    hexpand: true,
    draw_value: false,
    on_change: ({ value }) => audio.speaker.volume = value,
    setup: self => self.hook(audio.speaker, () => {
      self.value = audio.speaker.volume || 0
    }),
  }),

  cursor: "pointer",
  revealChild: false,
  transitionDuration: 250,
  transition: 'slide_left',
})*/

/*const eventbox = Widget.EventBox({
  on_hover: () => {
    value.reveal_child = true;
    Utils.timeout(duration, () => open = true);
  },
  on_hover_lost: () => {
    value.reveal_child = false;
    open = false;
  },
  above_child: false,
  child: Widget.Box({
    children: [ icon, slider ],
  }),
});*/

export default () => Widget.Box({
  class_name: "volume",
  children: [ icon, slider ],
})
