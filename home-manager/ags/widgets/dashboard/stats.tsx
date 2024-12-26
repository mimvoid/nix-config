import { Gtk } from "astal/gtk3";
import Icons from "../../lib/icons";

// TODO: get actual values

function Cpu() {
  const Icon = <icon icon={Icons.cpu} />;
  const CpuBar = <levelbar value={0.5} />;

  return (
    <box className="cpu stat">
      {Icon}
      {CpuBar}
    </box>
  );
}

function Memory() {
  const Icon = <icon icon={Icons.memory} />;
  const MemoryBar = <levelbar value={0.5} />;

  return (
    <box className="memory stat">
      {Icon}
      {MemoryBar}
    </box>
  );
}

function Disk() {
  const Icon = <icon icon={Icons.disk} />;
  const DiskBar = <levelbar value={0.5} />;

  return (
    <box className="disk stat">
      {Icon}
      {DiskBar}
    </box>
  );
}

export default function Stats() {
  return (
    <box className="stat-box in-box">
      <box halign={Gtk.Align.CENTER} hexpand vertical>
        <Cpu />
        <Memory />
        <Disk />
      </box>
    </box>
  );
}
