import { bind } from "astal";
import { Gtk, Widget } from "astal/gtk4";

import { Calendar } from "@lib/astalified";
import { time, uptime } from "@lib/variables";
import { pointer } from "@lib/utils";
import Icon from "@lib/icons";

const { START, CENTER, END } = Gtk.Align;

interface TimeLabelProps extends Widget.LabelProps {
  cssClass: string;
  fmt: string;
}

function TimeLabel({ cssClass, fmt, ...props }: TimeLabelProps) {
  return (
    <label
      label={bind(time).as((time) => time.format(fmt) || "")}
      cssClasses={["display", cssClass]}
      {...props}
    />
  );
}

function Time() {
  const MajorTime = (
    <overlay>
      <TimeLabel cssClass="hour" fmt="%H" halign={START} valign={START} />
      <TimeLabel
        type="overlay measure"
        cssClass="minute"
        fmt="%M"
        halign={END}
        valign={END}
      />
    </overlay>
  );

  const Uptime = (
    <label
      label={bind(uptime).as(
        (t) => `Up: ${Math.floor(t / 60)}h ${Math.floor(t % 60)}m` || "",
      )}
      cssClasses={["uptime"]}
      halign={START}
    />
  );

  return (
    <box cssClasses={["big-clock"]} halign={CENTER} hexpand>
      {MajorTime}
      <box cssClasses={["minor-time"]} valign={END} vertical>
        <TimeLabel cssClass="second" fmt="%S" halign={START} valign={END} />
        {Uptime}
      </box>
    </box>
  );
}

function CalendarWidget() {
  const Cal = (
    <Calendar showHeading={false} showDayNames showWeekNumbers />
  ) as Gtk.Calendar;

  const Header = (
    <box cssClasses={["header"]}>
      <box cssClasses={["month-switcher"]} hexpand>
        <button
          setup={pointer}
          onClicked={() => {
            if (Cal.month > 0) {
              Cal.month--;
            } else {
              Cal.year--;
              Cal.month = 11;
            }
          }}
          iconName={Icon.nav.previous}
        />
        <button
          setup={pointer}
          onClicked={() => {
            if (Cal.month < 11) {
              Cal.month++;
            } else {
              Cal.year++;
              Cal.month = 0;
            }
          }}
          iconName={Icon.nav.next}
        />
        <label
          label={bind(Cal, "month").as(() => Cal.get_date().format("%B") || "")}
        />
      </box>
      <box cssClasses={["year-switcher"]}>
        <label label={bind(Cal, "year").as((y) => String(y))} />
        <button
          setup={pointer}
          onClicked={() => Cal.year--}
          iconName={Icon.nav.previous}
        />
        <button
          setup={pointer}
          onClicked={() => Cal.year++}
          iconName={Icon.nav.next}
        />
      </box>
    </box>
  );

  return (
    <box cssClasses={["calendar-wrapper"]} vertical>
      {Header}
      {Cal}
    </box>
  );
}

export default (
  <popover name="calendar" hasArrow={false}>
    <box cssClasses={["calendar"]} halign={CENTER} vertical>
      <Time />
      <CalendarWidget />
    </box>
  </popover>
);
