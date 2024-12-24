import { exec, execAsync, Variable } from "astal";

// Fetch brightness value from brightnessctl
export function getBrightness() {
  const current = Number(exec("brightnessctl get"));
  const max = Number(exec("brightnessctl max"));

  return current / max;
}

// Wrap brightness as a Variable
export const brightness = Variable(getBrightness());

// Set the brightness and its Variable
export function setBrightness(value: number) {
  execAsync(`brightnessctl set ${Math.floor(value * 100)}% -q`).catch();
  brightness.set(value);
}
