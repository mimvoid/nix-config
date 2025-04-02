import { bind } from "astal";
import Mpris from "gi://AstalMpris";

import Actions from "./media/Actions";
import Progress from "./media/Progress";
import Info from "./media/Info";

const mpris = Mpris.get_default();

// Pass the mpris player to the widget modules
function Input() {
  const Popup = (player: Mpris.Player) => (
    <box vertical>
      {Actions(player)}
      {Progress(player)}
      {Info(player)}
    </box>
  );

  const Default = <box>Nothing Playing</box>;

  // Draw the widget modules if there is a player
  // Only displays the first player
  return bind(mpris, "players").as((ps) => (ps[0] ? Popup(ps[0]) : Default));
}

export default (
  <popover name="media" cssClasses={["media", "box"]} hasArrow={false}>
    {Input()}
  </popover>
);
