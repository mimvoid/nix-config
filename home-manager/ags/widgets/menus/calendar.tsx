import { bind } from "astal";
import { App, Astal, Gtk } from "astal/gtk3";

import { Calendar } from "@lib/astalified";
import { time, uptime } from "@lib/variables";

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
    <box className="big-clock" halign={Gtk.Align.CENTER} hexpand>
      {times.map((time) => getTime(time[0], time[1]))}
    </box>
  );
}

const Uptime = (
  <label
    label={bind(uptime).as((t) => `Uptime: ${Math.floor(t / 60)}h ${Math.floor(t % 60)}m` || "")}
    className="uptime"
    valign={Gtk.Align.END}
    hexpand
    vexpand
  />
)

const CalendarWidget = (
  <box className="calendar box" vertical>
    <Time />
    {Uptime}
    <Calendar showHeading showDayNames showWeekNumbers />
  </box>
);

export default function CalendarWindow() {
  return (
    <window
      name="calendar"
      visible={false}
      exclusivity={Astal.Exclusivity.NORMAL}
      anchor={Astal.WindowAnchor.TOP}
      layer={Astal.Layer.OVERLAY}
      margin-top={2}
      application={App}
    >
      {CalendarWidget}
    </window>
  );
}
