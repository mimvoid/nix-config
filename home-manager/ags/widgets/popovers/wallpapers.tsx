import { Variable, bind } from "astal";
import { Gtk } from "astal/gtk3";

import Popover from "@lib/widgets/Popover";

import Wallpapers from "@services/wallpapers";

const wallpapers = Wallpapers.get_default();
const { CENTER, END } = Gtk.Align;

const Choices = bind(wallpapers, "wallpapers").as((ws) =>
  ws.map((w) => (
    <box className="item" vertical>
      <button onClick={() => wallpapers.setWallpaper(w.path)} cursor="pointer">
        <box vertical spacing={4}>
          <box className="with-bg-img" css={`background-image: url("${w.thumbnail || w.path}");`} />
          <label className="filename" label={w.name} />
        </box>
      </button>
    </box>
  ))
);

function WallpaperPicker() {
  const visible = Variable(false);

  const { EXTERNAL, NEVER } = Gtk.PolicyType;

  const Widget = (
    <Popover
      className="wallpaper-picker popover"
      name="wallpaperPicker"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={END}
      halign={CENTER}
      marginBottom={12}
    >
      <scrollable hscroll={EXTERNAL} vscroll={NEVER} widthRequest={1200}>
        <box spacing={8}>
          {Choices}
        </box>
      </scrollable>
    </Popover>
  )

  return {
    visible: visible,
    Widget: () => Widget
  }
}

export default WallpaperPicker()
