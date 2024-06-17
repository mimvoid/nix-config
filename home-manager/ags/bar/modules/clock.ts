import { Utils, Widget } from "../../imports.js";

export default () => Widget.EventBox({
  child: Widget.Label({ className: "date module" })
    .poll(1000,
      (self) =>
        Utils.execAsync(["date", "+%A %b %d / %H:%M"]).then((r) =>
          self.label = r
        ),
    ),
});
