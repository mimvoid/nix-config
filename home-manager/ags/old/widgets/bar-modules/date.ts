const date = Variable("", {
  poll: [1000, 'date "+%A %b %d / %H:%M"'],
});

export default () =>
  Widget.Button({
    child: Widget.Label({ label: date.bind() }),
    class_name: "clock",
    on_clicked: () => App.toggleWindow("calendar"),
    cursor: "pointer",
  });
