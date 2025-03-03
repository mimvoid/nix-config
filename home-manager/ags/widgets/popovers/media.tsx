import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";

import Popover from "@lib/widgets/Popover";

import Actions from "./media/Actions";
import Progress from "./media/Progress";
import Info from "./media/Info";

const mpris = Mpris.get_default();
const { START, CENTER } = Gtk.Align;

// Pass the mpris player to the widget modules
function Input() {
  function Popup(player: Mpris.Player) {
    return (
      <box vertical>
        {Actions(player)}
        {Progress(player)}
        {Info(player)}
      </box>
    );
  }

  const Default = <box>Nothing Playing</box>

  // Draw the widget modules if there is a player
  // Only displays the first player
  return bind(mpris, "players").as((ps) =>
    ps[0] ? Popup(ps[0]) : Default,
  );
}

function MediaBox() {
  const visible = Variable(false);

  const Widget = (
    <Popover
      name="media"
      className="media popover"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={START}
      halign={CENTER}
      marginTop={28}
    >
      {Input()}
    </Popover>
  );

  return {
    visible: visible,
    Widget: () => Widget
  }
}

export default MediaBox()
