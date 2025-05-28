import { App, Gtk } from "astal/gtk4";
import Icon from "@lib/icons";

import DashboardPopover from "../popovers/dashboard";
import MediaPopover from "../popovers/media";

// Toggle mpris media widget menu
export const Media = (
  <menubutton>
    <button
      setup={(self) => self.set_cursor_from_name("pointer")}
      cssClasses={["media-launch"]}
      onClicked={() => (MediaPopover.visible = true)}
      iconName={Icon.mimetypes.audio}
    />
    {MediaPopover}
  </menubutton>
);

// Toggle the dashboard
export const Dashboard = (
  <menubutton>
    <button
      setup={(self) => self.set_cursor_from_name("pointer")}
      cssClasses={["dashboard-launch"]}
      onClicked={() => (DashboardPopover.visible = true)}
      iconName={Icon.overview}
    />
    {DashboardPopover}
  </menubutton>
);

// Toggle buttons for logging out, shutting down, etc.
export const Session = (
  <button
    setup={(self) => self.set_cursor_from_name("pointer")}
    cssClasses={["session-launch"]}
    onClicked={() => App.toggle_window("session")}
    iconName={Icon.powermenu.indicator}
  />
);
