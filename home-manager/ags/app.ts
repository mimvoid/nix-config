#!/usr/bin/env gjs -m

import { App } from "astal/gtk4";
import GLib from "gi://GLib";

// Get root stylesheet
import style from "./style/style.scss";

// Get windows
import Bar from "./widgets/bar/bar";
import NotificationPopups from "./widgets/notifications/notificationPopups";
import SessionMenu from "./widgets/session";

App.start({
  css: style,
  iconTheme: "Adwaita",

  requestHandler(request, res) {
    print(request);
    res("ok");
  },

  main() {
    GLib.set_prgname(App.instanceName);

    // Map to every monitor
    for (const monitor of App.get_monitors()) {
      Bar(monitor);
      NotificationPopups(monitor);
    }

    SessionMenu();
  },
});
