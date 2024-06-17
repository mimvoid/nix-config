const hyprland = await Service.import("hyprland")
const notifications = await Service.import("notifications")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")

const date = Variable("", {
  poll: [1000, 'date "+%A %b %d / %H:%M"'],
})

App.config({
  style: "./style.scss",
  windows: [
    Bar(),
  ],
})

/*-----*/
/* BAR */
/*-----*/

function Bar(monitor = 0) {
  return Widget.Window({
    name: `bar-${monitor}`,
    class_name: "bar",
    monitor,
    anchor: ["top", "left", "right"],
    exclusivity: "exclusive",
  
    child: Widget.CenterBox({
      start_widget: Left(),
      center_widget: Center(),
      end_widget: Right(),
    }),
  })
}

// Layout
function Left() {
  return Widget.Box({
    class_name: "left",
    hpack: "start",
    children: [
      Workspaces(),
      ClientTitle(),
    ],
  })
}

function Center() {
  return Widget.Box({
    class_name: "center",
    children: [
      Clock(),
      //Media(), 
    ],
  })
}

function Right() {
  return Widget.Box({
    class_name: "right",
    hpack: "end",
    children: [
      Volume(),
      BatteryLabel(),
      SysTray(),
      //Notification(),
      PowerActions(),
    ],
  })
}


/*--------------*/
/* Left widgets */
/*--------------*/

function Workspaces() {
  const activeId = hyprland.active.workspace.bind("id")
  const workspaces = hyprland.bind("workspaces")
  .as(ws => ws.map(({ id }) => Widget.Button({
    on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
    child: Widget.Label(`${id}`),
    class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
    cursor: "pointer",
  })))

  return Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  })
}

function ClientTitle() {
  return Widget.Label({
    class_name: "client-title",
    label: hyprland.active.client.bind("title"),
    truncate: 'end',
    maxWidthChars: 32,
  })
}


/*----------------*/
/* Center widgets */
/*----------------*/

function Clock() {
  return Widget.Label({
    class_name: "clock",
    label: date.bind(),
  })
}

//function Media() {
//  const label = Utils.watch("", mpris, "player-changed", () => {
//    if (mpris.players[0]) {
//      const { track_artists, track_title } = mpris.players[0]
//      return `${track_artists.join(", ")} - ${track_title}`
//    }
//    else {
//      return "Nothing is playing"
//    }
//  })
//
//  return Widget.Button({
//    class_name: "media",
//    on_primary_click: () => mpris.getPlayer("")?.playPause(),
//    on_scroll_up: () => mpris.getPlayer("")?.next(),
//    on_scroll_down: () => mpris.getPlayer("")?.previous(),
//    child: Widget.Label({ label }),
//  })
//}


/*---------------*/
/* Right widgets */
/*---------------*/

function Volume() {
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
  const slider = Widget.Revealer({
    child: Widget.Slider({
      hexpand: true,
      draw_value: false,
      on_change: ({ value }) => audio.speaker.volume = value,
      setup: self => self.hook(audio.speaker, () => {
        self.value = audio.speaker.volume || 0
      }),
    }),

    cursor: "pointer",
    revealChild: false,
    transitionDuration: 500,
    transition: 'slide_left',
    setup: self => self.poll(2000, () => {
      self.reveal_child = !self.reveal_child;
    }),
  })

  return Widget.Box({
    class_name: "volume",
    children: [icon, slider],
  })
}

function BatteryLabel() {
  // TODO: battery percentage label does't show up right.
  const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
  const icon = battery.bind("percent").as(p =>
    `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

  return Widget.Box({
    class_name: "battery",
    visible: battery.bind("available"),
    children: [
      Widget.Icon({ icon }),
      Widget.Label({
        label: ` ${value}`,
        vpack: "center",
      }),
    ],
  })
}

function SysTray() {
  const items = systemtray.bind("items")
    .as(items => items.map(item => Widget.Button({
      child: Widget.Icon({ icon: item.bind("icon") }),
      on_primary_click: (_, event) => item.activate(event),
      on_secondary_click: (_, event) => item.openMenu(event),
      tooltip_markup: item.bind("tooltip_markup"),
    })))

  return Widget.Box({
    class_name: "system-tray",
    children: items,
  })
}

// FIX: Notifications also don't work

//function Notification() {
//  const popups = notifications.bind("popups")
//  return Widget.Box({
//    class_name: "notification",
//    visible: popups.as(p => p.length > 0),
//    children: [
//      Widget.Icon({
//        icon: "preferences-system-notifications-symbolic",
//      }),
//      Widget.Label({
//        label: popups.as(p => p[0]?.summary || ""),
//      }),
//    ],
//  })
//}

function PowerActions() {
  return Widget.Button({
    class_name: "power-actions",
    child: Widget.Icon("system-shutdown-symbolic"),
    cursor: "pointer",

    // TODO: replace with an AGS widget at some point

    on_clicked: () => { Utils.execAsync('wlogout -b 2') },
  })
}

export {};
