import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk3";

import Popover from "@lib/widgets/Popover";
import { Calendar } from "@lib/astalified";
import { time, uptime } from "@lib/variables";

const { START, CENTER, END } = Gtk.Align;

function Time() {
  const times = [
    { fmt: "%H", class: "hour" },
    { fmt: "%M", class: "minute" },
    { fmt: "%S", class: "second" },
  ];

  return (
    <box className="big-clock" halign={CENTER} hexpand>
      {times.map((t) => (
        <label
          label={bind(time).as((time) => time.format(t.fmt) || "")}
          className={`display ${t.class}`}
          valign={END}
          expand
        />
      ))}
    </box>
  );
}

const Uptime = (
  <label
    label={bind(uptime).as((t) => `Uptime: ${Math.floor(t / 60)}h ${Math.floor(t % 60)}m` || "")}
    className="uptime"
    valign={END}
    expand
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
    Widget: () => Widget
  }
}

export default CalendarWindow()
