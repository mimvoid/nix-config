import AppToggle from "../../lib/widgets/AppToggle";
import Icon from "../../lib/icons";

// Toggle mpris media widget menu
export const MediaIcon = AppToggle("media", "media-button", Icon.music)

// Toggle the dashboard
export const Overview = AppToggle("dashboard", "overview", Icon.overview)

// Toggle buttons for logging out, shutting down, etc.
export const Power = AppToggle("session", "power-actions", Icon.powermenu.indicator)
