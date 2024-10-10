import { exec } from "astal"

// TODO: replace wlogout

export default function Power() {
  return <button
    className="power-actions"
    cursor="pointer"
    onClicked={() => exec("wlogout -b 2")} >
      <icon icon="system-shutdown-symbolic" />
  </button>
}
