import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk3";

import Popover from "@lib/widgets/Popover";
import { Calendar } from "@lib/astalified";
import { time, uptime } from "@lib/variables";

const { START, CENTER, END } = Gtk.Align;

function Time() {
  const getTime = (fmt: string, className: string) => (
    <label
      label={bind(time).as((t) => t?.format(fmt) || "")}
      className={`display ${className}`}
      valign={Gtk.Align.END}
      hexpand
      vexpand
    />
  );

  // Format time with seconds
  const times = [
    ["%H", "hour"],
    ["%M", "minute"],
    ["%S", "second"],
  ];

  return (
    <box className="big-clock" halign={CENTER} hexpand>
      {times.map((time) => getTime(time[0], time[1]))}
    </box>
  );
}

const Uptime = (
  <label
    label={bind(uptime).as((t) => `Uptime: ${Math.floor(t / 60)}h ${Math.floor(t % 60)}m` || "")}
    className="uptime"
    valign={END}
    hexpand
    vexpand
  />
)

const CalendarWidget = (
  <box className="calendar" vertical>
    <Time />
    {Uptime}
    <Calendar showHeading showDayNames showWeekNumbers />
  </box>
);

function CalendarWindow() {
  const visible = Variable(false);

  const Widget = (
    <Popover
      name="calendar"
      className="popover"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={START}
      halign={CENTER}
      marginTop={28}
    >
      {CalendarWidget}
    </Popover>
  );

  return {
    visible: visible,
    Widget: Widget
  }
}

export default CalendarWindow()
