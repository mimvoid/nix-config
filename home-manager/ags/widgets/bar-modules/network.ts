const network = await Service.import('network');

// Wifi
const wifi_icon = Widget.Button({
  child: Widget.Icon({
    icon: network.wifi.bind('icon_name'),
  }),

  cursor: "pointer",
  // TODO: replace this with the nm-applet system tray item menu
  on_secondary_click: () => Utils.execAsync('nm-connection-editor'),
})

const wifi_label = Widget.Label({
  label: network.wifi.bind('strength').as(s => `${s}%`),

  // Only show if there's a connection to the internet
  visible: network.wifi.state === "activated",
})

const wifi_label_box = Widget.Revealer({
  child: wifi_label,

  revealChild: false,
  transitionDuration: 250,
  transition: 'slide_left',
})

const wifi_eventbox = Widget.EventBox({
  on_hover: () => {
    wifi_label_box.reveal_child = true;
    open = true;
  },
  on_hover_lost: () => {
    wifi_label_box.reveal_child = false;
    open = false;
  },

  child: Widget.Box({
    children: [wifi_icon, wifi_label_box],
  }), 
})


const Wifi = () => Widget.Box({
  child: wifi_eventbox,
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
