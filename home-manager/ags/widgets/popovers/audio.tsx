import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Wp from "gi://AstalWp";
import { pointer } from "@lib/utils";

const { START, CENTER, END, FILL } = Gtk.Align;

const wp = Wp.get_default();
const speaker = wp?.audio.defaultSpeaker!;
const microphone = wp?.audio.defaultMicrophone!;

function Section(endpoint: Wp.Endpoint, name: string) {
  const lowerName = name.toLowerCase();

  const Icon = (
    // Can mute or unmute
    <button
      setup={pointer}
      onClicked={() => (endpoint.mute = !endpoint.mute)}
      tooltipText={bind(endpoint, "mute").as(
        (m) => `${m ? "Unmute" : "Mute"} ${lowerName}`,
      )}
    >
      <image
        cssClasses={["big-icon"]}
        iconName={bind(endpoint, "volumeIcon")}
      />
    </button>
  );

  const Label = (
    <label
      cssClasses={["description"]}
      label={bind(endpoint, "description").as((d) => d || endpoint.name || "")}
      halign={START}
      hexpand
    />
  );

  const Slider = (
    <box>
      <slider
        setup={pointer}
        value={bind(endpoint, "volume")}
        onChangeValue={({ value }) => (endpoint.volume = value)}
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
    <box
      cssClasses={["section", lowerName]}
      halign={FILL}
      valign={CENTER}
      hexpand
      vexpand
    >
      <box vertical>
        <label cssClasses={["title"]} label={name} halign={START} />
        <box>
          {Icon}
          <box vertical valign={CENTER} hexpand vexpand>
            {Label}
            {Slider}
          </box>
        </box>
      </box>
    </box>
  );
}

const Speaker = Section(speaker, "Speaker");
const Microphone = Section(microphone, "Microphone");

export default (
  <popover cssClasses={["audio-popover"]} hasArrow={false}>
    <box vertical>
      {Speaker}
      {Microphone}
    </box>
  </popover>
);
