import { App } from "astal/gtk3";
import Icon from "@lib/icons";

import DashboardPopover from "../popovers/dashboard";
import MediaPopover from "../popovers/media";

// Toggle mpris media widget menu
export const Media = (
  <button
    className="media-launch"
    cursor="pointer"
    onClicked={() => MediaPopover.visible.set(true)}
  >
    <icon icon={Icon.mimetypes.audio} />
  </button>
)

// Toggle the dashboard
export const Dashboard = (
  <button
    className="dashboard-launch"
    cursor="pointer"
    onClicked={() => DashboardPopover.visible.set(true)}
  >
    <icon icon={Icon.overview} />
  </button>
)

// Toggle buttons for logging out, shutting down, etc.
export const Session = (
  <button
    className="session-launch"
    cursor="pointer"
    onClicked={() => App.toggle_window("session")}
  >
    <icon icon={Icon.powermenu.indicator} />
  </button>
);
