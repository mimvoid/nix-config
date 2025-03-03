import { bind, Variable } from "astal";
import { Gtk } from "astal/gtk3";
import Wp from "gi://AstalWp";
import Popover from "@lib/widgets/Popover";

const { START, CENTER, END, FILL } = Gtk.Align;

const wp = Wp.get_default();
const speaker = wp?.audio.defaultSpeaker!;
const microphone = wp?.audio.defaultMicrophone!;

function Section(endpoint: Wp.Endpoint, name: string) {
  const lowerName = name.toLowerCase();

  const Icon = (
    // Can mute or unmute
    <button
      cursor="pointer"
      onClicked={() => (endpoint.mute = !endpoint.mute)}
      tooltipText={bind(endpoint, "mute").as((m) => `${m ? "Unmute" : "Mute"} ${lowerName}`)}
    >
      <icon className="big-icon" icon={bind(endpoint, "volumeIcon")} />
    </button>
  );

  const Label = (
    <label
      className="description"
      label={bind(endpoint, "description").as((d) => d || endpoint.name || "")}
      halign={START}
      hexpand
    />
  );

  const Slider = (
    <box>
      <slider
        value={bind(endpoint, "volume")}
        onDragged={({ value }) => (endpoint.volume = value)}
        cursor="pointer"
        valign={CENTER}
        hexpand
      />
      <label
        label={bind(endpoint, "volume").as((i) => `${Math.floor(i * 100)}%`)}
        halign={END}
        valign={CENTER}
      />
    </box>
  );

  return (
    <box className={`section ${lowerName}`} halign={FILL} valign={CENTER} expand>
      <box vertical>
        <label className="title" label={name} halign={START} />
        <box>
          {Icon}
          <box vertical valign={CENTER} expand>
            {Label}
            {Slider}
          </box>
        </box>
      </box>
    </box>
  )
}

const Speaker = Section(speaker, "Speaker");
const Microphone = Section(microphone, "Microphone");

function AudioPopover() {
  const visible = Variable(false);

  const Widget = (
    <Popover
      className="audio-popover popover"
      visible={visible()}
      onClose={() => visible.set(false)}
      valign={START}
      halign={END}
      marginTop={28}
      marginRight={12}
    >
      <box vertical>
        {Speaker}
        {Microphone}
      </box>
    </Popover>
  )

  return {
    visible: visible,
    Widget: Widget
  }
}

export default AudioPopover()
