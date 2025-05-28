import { bind } from "astal";
import { Gtk, hook } from "astal/gtk4";
import Wp from "gi://AstalWp";
import { drawValuePercentage } from "@lib/utils";

const { START, CENTER, FILL } = Gtk.Align;

const wp = Wp.get_default();
const speaker = wp?.audio.defaultSpeaker!;
const microphone = wp?.audio.defaultMicrophone!;

function Section(endpoint: Wp.Endpoint, name: string) {
  const lowerName = name.toLowerCase();

  const Icon = (
    // Can mute or unmute
    <button
      setup={(self) => {
        self.set_cursor_from_name("pointer");

        function muteHook() {
          const m = endpoint.mute;
          self.tooltipText = `${m ? "Unmute" : "Mute"} ${lowerName}`;
          m ? self.add_css_class("off") : self.remove_css_class("off");
        }

        muteHook();
        hook(self, endpoint, "notify::mute", muteHook);
      }}
      cssClasses={["big-toggle"]}
      onClicked={() => (endpoint.mute = !endpoint.mute)}
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
      vertical
    >
      <label cssClasses={["title"]} label={name} halign={START} />
      <box>
        {Icon}
        <box vertical valign={CENTER} hexpand vexpand>
          {Label}
          {Slider}
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
