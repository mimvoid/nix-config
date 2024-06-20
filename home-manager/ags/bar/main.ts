import Workspaces from "./workspaces/workspaces.ts";
import ClientTitle from "./title/title.ts";

import Clock from "./date/date.ts";

import Volume from "./sound/sound.ts";
import Battery from "./battery/battery.ts";
import SysTray from "./tray/tray.ts";
import PowerActions from "./power-actions/power-actions.ts";


export default (monitor: number) => Widget.Window({
  monitor,
  name: `bar-${monitor}`,
  class_name: "bar",
  anchor: ["top", "left", "right"],
  exclusivity: "exclusive",
  
  child: Widget.CenterBox({
    start_widget: Left(),
    center_widget: Center(),
    end_widget: Right(),
  }),
})

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
      Battery(),
      SysTray(),
      //Notification(),
      PowerActions(),
    ],
  })
}
