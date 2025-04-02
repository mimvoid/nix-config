import { bind } from "astal";
import { Gtk } from "astal/gtk4";

import { Calendar } from "@lib/astalified";
import { time, uptime } from "@lib/variables";

const { CENTER, END } = Gtk.Align;

function Time() {
  const times = [
    { fmt: "%H", class: "hour" },
    { fmt: "%M", class: "minute" },
    { fmt: "%S", class: "second" },
  ];

  return (
    <box cssClasses={["big-clock"]} halign={CENTER} hexpand>
      {times.map((t) => (
        <label
          label={bind(time).as((time) => time.format(t.fmt) || "")}
          cssClasses={["display", t.class]}
          valign={END}
          vexpand
        />
      ))}
    </box>
  );
}

const Uptime = (
  <label
    label={bind(uptime).as(
      (t) => `Uptime: ${Math.floor(t / 60)}h ${Math.floor(t % 60)}m` || "",
    )}
    cssClasses={["uptime"]}
    valign={END}
    hexpand
    vexpand
  />
);

const CalendarWidget = (
  <box cssClasses={["calendar"]} halign={CENTER} vertical>
    <Time />
    {Uptime}
    <Calendar showHeading showDayNames showWeekNumbers />
  </box>
);

export default (
  <popover name="calendar" hasArrow={false}>
    {CalendarWidget}
  </popover>
);
