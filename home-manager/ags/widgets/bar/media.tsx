import { App } from "astal/gtk3"
import Icon from "../../lib/icons"

export default function MediaIcon() {
  return <button
    className="media-button"
    onClicked={() => App.toggle_window("media")} >
      <icon icon={Icon.music} />
  </button>
}
