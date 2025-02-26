import AppToggle from "@lib/widgets/AppToggle";
import Icon from "@lib/icons";

// Toggle mpris media widget menu
export const Media = AppToggle("media", "media-launch", Icon.music)

// Toggle the dashboard
export const Dashboard = AppToggle("dashboard", "dashboard-launch", Icon.overview)

// Toggle buttons for logging out, shutting down, etc.
export const Session = AppToggle("session", "session-launch", Icon.powermenu.indicator)
