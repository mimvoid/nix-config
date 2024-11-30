import { App } from "astal/gtk3"
import Icon from "../../lib/icons"

// A button to toggle the dashboard

export default function Overview() {
  return <button
    className="overview"
    onClicked={() => App.toggle_window("dashboard")} >
      <icon icon={Icon.overview} />
  </button>
}
