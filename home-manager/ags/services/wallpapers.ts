import { execAsync } from "astal";
import GObject, { register, property } from "astal/gobject";
import GLib from "gi://GLib";
import Gio from "gi://Gio";

const attrDisplayName = Gio.FILE_ATTRIBUTE_STANDARD_DISPLAY_NAME;
const attrFastContentType = Gio.FILE_ATTRIBUTE_STANDARD_FAST_CONTENT_TYPE;
const attrThumbnailPath = Gio.FILE_ATTRIBUTE_THUMBNAIL_PATH;

const wpPath = GLib.get_user_config_dir() + "/wallpapers/";

@register({ GTypeName: "Wallpapers" })
export default class Wallpapers extends GObject.Object {
  static instance: Wallpapers;

  static get_default() {
    if (!this.instance) this.instance = new Wallpapers();
    return this.instance;
  }

  #wallpapers = this.fileInfo() || [];
  #wallpaperDir = wpPath;

  @property()
  get wallpapers() {
    return this.#wallpapers;
  }

  @property(String)
  get wallpaperDir() {
    return this.#wallpaperDir;
  }

  setWallpaper(path: string) {
    execAsync(`swww img -t grow --transition-pos 0.95,0.95 --transition-step 90 ${path}`)
      .catch(console.error);
  }

  private wallpapersEnum() {
    const wpGFile = Gio.File.new_for_path(wpPath);

    try {
      // Get childen with a Gio.FileEnumerator object
      const attrs = `${attrDisplayName},${attrFastContentType},${attrThumbnailPath}`;
      return wpGFile.enumerate_children(attrs, Gio.FileQueryInfoFlags.NONE, null);
    } catch (err) {
      if (err === Gio.IOErrorEnum.NOT_FOUND) {
        wpGFile.make_directory();
        return;
      }

      console.error(err);
      return;
    }
  }

  private fileInfo() {
    const enumerator = this.wallpapersEnum();
    if (!enumerator) return;

    let fileInfo = [];

    let file = enumerator.next_file(null);
    while (file !== null) {
      const type = file.get_attribute_as_string(attrFastContentType);

      if (type && type.startsWith("image")) {
        fileInfo.push([
          file.get_display_name(),
          file.get_attribute_as_string(attrThumbnailPath)
        ])
      }

      file = enumerator.next_file(null);
    }

    return fileInfo;
  }
}
