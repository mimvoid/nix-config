// TODO: change icon based on if wlsunset is running or not
// off icon weather-clear-night-symbolic

const icon = Widget.Icon("display-brightness-symbolic")

export default () => Widget.Button({
  class_name: "wlsunset-toggle",
  cursor: "pointer",
  tooltip_text: "Toggle wlsunset",

  on_clicked: () => {Utils.subprocess(
    ['bash', '-c', `${App.configDir}/scripts/wlsunset-toggle.sh`],
    (output) => print(output),
    (err) => logError(err),
  )},

  child: icon
})
