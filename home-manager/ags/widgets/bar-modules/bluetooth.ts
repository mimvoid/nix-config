const bluetooth = await Service.import('bluetooth');

const indicator = Widget.Button({
  child: Widget.Icon({
    // Icon changes if bluetooth is on or off
    // `bluetooth-active-symbolic` or `bluetooth-disabled-symbolic`
    icon: bluetooth.bind('enabled').as(on => `bluetooth-${on ? 'active' : 'disabled'}-symbolic`),
  }),
  
  // Toggle bluetooth
  cursor: "pointer",
  on_clicked: () => bluetooth.enabled = !bluetooth.enabled,
  
  // Show status of bluetooth
  tooltip_text: bluetooth.bind('enabled').as(on => `Bluetooth ${on ? 'on' : 'off'}`),
})

// FIX: there's some inconsistency as to if it actually displays?
const list = Widget.Box({
  setup: self => self.hook(bluetooth, self => {
    self.children = bluetooth.connected_devices
    .map(({ icon_name, name }) => Widget.Box([
        Widget.Icon(icon_name + '-symbolic'),
        Widget.Label(name),
    ]));
    self.visible = bluetooth.connected_devices.length > 0;
  },

  'notify::connected-devices'),
})

const list_box = Widget.Revealer({
  child: list,
  
  revealChild: false,
  transition_duration: 250,
  transition: 'slide_left',
})

const eventbox = Widget.EventBox({
  on_hover: () => {
    list_box.reveal_child = true;
  },
  on_hover_lost: () => {
    list_box.reveal_child = false;
  },

  child: Widget.Box({
    children: [ indicator, list_box ],
  }), 
})

export default () => Widget.Box({
  class_name: "bluetooth",
  child: eventbox,
})
