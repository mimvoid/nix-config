import { App, Astal, Gtk, Gdk, Widget, astalify, type ConstructProps } from "astal/gtk3"
import GObject from "gi://GObject"

// Set up calendar widget
class Calendar extends astalify(Gtk.Calendar) {
  static { GObject.registerClass(this) }

  constructor(props: ConstructProps<
    Calendar,
    Gtk.Calendar.ConstructorProps,
    {}
  >) {
    super(props as any)
  }
}

function CalendarWidget() {
  const Content = <Calendar
    showHeading
    showDayNames
    showWeekNumbers
  />

  return <box className="calendar box" >
    {Content}
  </box>
}

export default function Cal(monitor: Gdk.Monitor) {
  return <window
    name="calendar"
    visible={false}
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.NORMAL}
    anchor={Astal.WindowAnchor.TOP}
    layer={Astal.Layer.OVERLAY}
    margin-top={2}
    application={App} >
      <CalendarWidget />
  </window>
}
