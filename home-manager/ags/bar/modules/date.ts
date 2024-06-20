const date = Variable("", {
  poll: [1000, 'date "+%A %b %d / %H:%M"'],
})

export default () => Widget.Label({
  class_name: "clock",
  label: date.bind(),
})
