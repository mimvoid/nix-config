import { App } from "astal/gtk3";

export default function AppToggle(
  appName: string,
  className: string,
  icon: string,
) {
  return (
    <button
      className={className}
      onClicked={() => App.toggle_window(appName)}
      cursor="pointer"
    >
      <icon icon={icon} />
    </button>
  );
}
