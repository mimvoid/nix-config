import Workspaces from "./bar-modules/workspaces";
import ClientTitle from "./bar-modules/title";

import Clock from "./bar-modules/date";

import SysTray from "./bar-modules/tray";
import Network from "./bar-modules/network.ts";
import Bluetooth from "./bar-modules/bluetooth";
import Volume from "./bar-modules/sound";
import Battery from "./bar-modules/battery";
import Brightness from "./bar-modules/brightness";
import PowerActions from "./bar-modules/power-actions";

export default (monitor: number) =>
  Widget.Window({
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
  });

// Layout
function Left() {
  return Widget.Box({
    class_name: "left",
    hpack: "start",
    children: [Workspaces(), ClientTitle()],
  });
}

function Center() {
  return Widget.Box({
    class_name: "center",
    children: [
      Clock(),
      //Media(),
    ],
  });
}

function Right() {
  return Widget.Box({
    class_name: "right",
    hpack: "end",
    children: [
      SysTray(),
      Network(),
      Bluetooth(),
      Volume(),
      Battery(),
      Brightness(),
      PowerActions(),
    ],
  });
}
