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

  @property()
  get wallpapers() {
    return this.#wallpapers;
  }

  setWallpaper(path: string) {
    execAsync(`swww img ${path}`).catch(console.error);
  }

  private wallpapersEnum() {
    const wpGFile = Gio.File.new_for_path(wpPath);

    // Get childen with a Gio.FileEnumerator object
    const enumChildren = ((gFile: Gio.File) => {
      const attrs = [ attrDisplayName, attrFastContentType, attrThumbnailPath ].join(",");
      return gFile.enumerate_children(attrs, Gio.FileQueryInfoFlags.NONE, null);
    });

    try {
      return enumChildren(wpGFile);
    } catch (err) {
      if (err === Gio.IOErrorEnum.NOT_FOUND) {
        // Make the directory and try again

        wpGFile.make_directory();

        try {
          return enumChildren(wpGFile);
        } catch (createErr) {
          console.error(err);
          return;
        }
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
        const name = file.get_display_name();

        fileInfo.push({
          name: name,
          path: wpPath + name,
          thumbnail: file.get_attribute_as_string(attrThumbnailPath),
        })
      }

      file = enumerator.next_file(null);
    }

    return fileInfo;
  }
}
