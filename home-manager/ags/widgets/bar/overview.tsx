import { App } from "astal/gtk3"
import Icon from "../../lib/icons"

export default function Overview() {
  return <button
    className="overview"
    onClicked={() => App.toggle_window("dashboard")} >
      <icon icon={Icon.overview} />
  </button>
}
