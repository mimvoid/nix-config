import { App, exec } from "astal"

const WlSunset = <button
  className="wlsunset-toggle"
  onClicked={() => exec(`bash -c ${SRC}/scripts/wlsunset-toggle.sh`)
    .then((out) => console.log(out))
    .catch((err) => console.log(err))}
  cursor="pointer"
  tooltipText="Toggle wlsunset" >
    <icon icon="display-brightness-symbolic" />
</button>

export default function Brightness() {
  return <box>
    {WlSunset}
  </box>
}
