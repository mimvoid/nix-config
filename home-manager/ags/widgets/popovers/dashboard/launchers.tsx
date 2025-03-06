import { App } from "astal/gtk4";
import Icons from "@lib/icons";
import { pointer } from "@lib/utils";

const Wallpapers = (
  <button setup={pointer} onClicked={() => App.toggle_window("wallpaperPicker")}>
    <box>
      <image iconName={Icons.mimetypes.image} cssClasses={["big-icon"]} />
      <label label="Change wallpaper" />
    </box>
  </button>
)

export default function Launchers() {
  return (
    <box cssClasses={["launchers", "section"]} hexpand>
      {Wallpapers}
    </box>
  );
}
