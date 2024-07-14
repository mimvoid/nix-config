const network = await Service.import('network');

// Wifi
const icon = Widget.Button({
  child: Widget.Icon({
    icon: network.wifi.bind('icon_name'),
  }),

  cursor: "pointer",
  // TODO: replace this with the nm-applet system tray item menu
  on_secondary_click: () => Utils.execAsync('nm-connection-editor'),
})

const label = Widget.Label({
  label: network.wifi.bind('strength').as(s => `${s}%`),

  // FIX: does not work
  // Only show if there's a connection to the internet
  visible: network.wifi.state === "activated",
})

const label_box = Widget.Revealer({
  child: label,

  revealChild: false,
  transitionDuration: 250,
  transition: 'slide_left',
})

const eventbox = Widget.EventBox({
  on_hover: () => {
    label_box.reveal_child = true;
  },
  on_hover_lost: () => {
    label_box.reveal_child = false;
  },

  child: Widget.Box({
    children: [icon, label_box],
  }), 
})


const Wifi = () => Widget.Box({
  child: eventbox,
  tooltip_text: network.wifi.bind('ssid'),
})

// Wired
const Wired = () => Widget.Icon({
  icon: network.wired.bind('icon_name'),
  tooltip_text: network.wired.bind('internet').as(i => i),
})

export default () => Widget.Stack({
  children: {
    wifi: Wifi(),
    wired: Wired()
  },
  class_name: "network",
  shown: network.bind('primary').as(p => p || 'wifi'),
})
