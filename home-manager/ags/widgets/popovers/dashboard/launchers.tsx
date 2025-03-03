import Icons from "@lib/icons";
import WallpaperPicker from "../wallpapers";
import visible from "./visible";

const Wallpapers = (
  <button
    onClick={() => {
      visible.set(false);
      WallpaperPicker.visible.set(true);
    }}
    cursor="pointer"
  >
    <box>
      <icon icon={Icons.mimetypes.image} className="big-icon" />
      <label label="Change wallpaper" />
    </box>
  </button>
)

export default function Launchers() {
  return (
    <box className="launchers section" hexpand>
      {Wallpapers}
    </box>
  );
}
