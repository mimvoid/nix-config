import { App, Gtk } from "astal/gtk4";
import Icons from "@lib/icons";
import Wallpapers from "../../wallpapers";

const WallpapersLauncher = (
  <button
    setup={(self) => self.set_cursor_from_name("pointer")}
    onClicked={() => {
      const existingWin = App.get_window("wallpaperPicker");

      if (existingWin) {
        existingWin.visible = true;
      } else {
        const WpWindow = Wallpapers();
        App.add_window(WpWindow);
        WpWindow.visible = true;
      }
    }}
  >
    <box>
      <image iconName={Icons.mimetypes.image} iconSize={Gtk.IconSize.LARGE} />
      <label label="Change wallpaper" />
    </box>
  </button>
);

export default () => (
  <box cssClasses={["launchers", "section"]} spacing={10} hexpand>
    {WallpapersLauncher}
  </box>
);
