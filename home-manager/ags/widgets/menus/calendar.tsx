import { Variable } from "astal";
import { App, Astal, Gtk, astalify, type ConstructProps } from "astal/gtk3";
import GObject from "gi://GObject";

const CalendarWidget = () => {
  // Format time with seconds
  function Time() {
    function getTime(time: string, className: string) {
      const polled = Variable<string>("").poll(1000, `date '+${time}'`);
      return (
        <label
          label={polled()}
          className={`display ${className}`}
          valign={Gtk.Align.END}
          hexpand
          vexpand
        />
      );
    }

    const times = [
      ["%H", "hour"],
      ["%M", "minute"],
      ["%S", "second"],
    ]

    return (
      <box className="big-clock" halign={Gtk.Align.CENTER} hexpand>
        {times.map((time) => getTime(time[0], time[1]))}
      </box>
    );
  }

  function Calendar() {
    // Set up calendar widget
    class Calendar extends astalify(Gtk.Calendar) {
      static {
        GObject.registerClass(this);
      }

      constructor(
        props: ConstructProps<Calendar, Gtk.Calendar.ConstructorProps, {}>,
      ) {
        super(props as any);
      }
    }

    return <Calendar showHeading showDayNames showWeekNumbers />;
  }

  return (
    <box className="calendar box" vertical>
      <Time />
      <Calendar />
    </box>
  );
};

export default function Calendar() {
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
      <CalendarWidget />
    </window>
  );
}
