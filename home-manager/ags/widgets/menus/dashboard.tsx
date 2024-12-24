import { exec } from "astal";
import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import Mpris from "gi://AstalMpris";

const User = () => {
  //const Avatar =
  const Username = <label label={exec("whoami")} />;

  return <box className="in-box">{Username}</box>;
};

//function Media() {

//}

//function Stats() {
//  const Cpu =
//  return <box className="box" >
//
//  </box>
//}

export default function Dashboard() {
  return (
    <window
      name="dashboard"
      className="dashboard"
      visible={false}
      exclusivity={Astal.Exclusivity.NORMAL}
      anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT}
      layer={Astal.Layer.OVERLAY}
      margin-top={2}
      margin-left={2}
      application={App}
    >
      <box className="box" vertical>
        <User />
      </box>
    </window>
  );
}
