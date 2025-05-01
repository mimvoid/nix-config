import { Gtk } from "astal/gtk4";

export default () => {
  const CoverArt = (
    <box cssClasses={["cover-art-box", "cover-art-container", "placeholder"]} />
  );

  const Title = (
    <label
      cssClasses={["title"]}
      label="Nothing Playing"
      justify={Gtk.Justification.CENTER}
    />
  );

  return (
    <box cssClasses={["with-cover-art"]} vertical>
      {CoverArt}
      {Title}
    </box>
  );
};
