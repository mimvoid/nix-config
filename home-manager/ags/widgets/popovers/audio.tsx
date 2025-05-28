import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import Wp from "gi://AstalWp";
import { pointer, drawValuePercentage } from "@lib/utils";

const { START, CENTER, END, FILL } = Gtk.Align;

const wp = Wp.get_default();
const speaker = wp?.audio.defaultSpeaker!;
const microphone = wp?.audio.defaultMicrophone!;

function Section(endpoint: Wp.Endpoint, name: string) {
  const lowerName = name.toLowerCase();

  const Icon = (
    // Can mute or unmute
    <button
      setup={(self) => self.set_cursor_from_name("pointer")}
      cssClasses={bind(endpoint, "mute").as((m) => [
        "big-toggle",
        m ? "off" : "on",
      ])}
      onClicked={() => (endpoint.mute = !endpoint.mute)}
      tooltipText={bind(endpoint, "mute").as(
        (m) => `${m ? "Unmute" : "Mute"} ${lowerName}`,
      )}
    >
      <image
        iconName={bind(endpoint, "volumeIcon")}
        iconSize={Gtk.IconSize.LARGE}
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
    <slider
      setup={(self) => {
        self.set_cursor_from_name("pointer");
        drawValuePercentage(self);
      }}
      value={bind(endpoint, "volume")}
      onChangeValue={({ value }) => (endpoint.volume = value)}
      valign={CENTER}
      hexpand
    />
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
