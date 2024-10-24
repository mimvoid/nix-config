import { App } from "astal/gtk3"

export default function MediaIcon() {
  return <button
    className="media-button"
    onClicked={() => App.toggle_window("media")} >
      <icon icon="audio-x-generic-symbolic" />
  </button>
}
