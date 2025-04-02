import Gdk from "gi://Gdk";

export function newGdkRgba(value: string) {
  const color = new Gdk.RGBA();

  if (color.parse(value)) {
    return color;
  }
}

function colorToInts(g: Gdk.RGBA) {
  return {
    red: g.red * 255,
    green: g.green * 255,
    blue: g.blue * 255,
  };
}

export function hexToRgb(value: string) {
  const gRgba = newGdkRgba(value);
  if (!gRgba) return;

  return gRgba.to_string();
}

function asHex(n: number) {
  return n.toString(16).padStart(2, "0");
}

export function gRgbaToHex(g: Gdk.RGBA) {
  const { red, green, blue } = colorToInts(g);
  const main = "#" + asHex(red) + asHex(green) + asHex(blue);

  if (g.alpha == 1.0) return main;
  return main + asHex(g.alpha * 255);
}

export function rgbToHex(value: string) {
  const gRgba = newGdkRgba(value);
  if (!gRgba) return;

  return gRgbaToHex(gRgba);
}

export function gRgbaToHsl(g: Gdk.RGBA) {
  const { red, green, blue } = g;

  const cmax = Math.max(red, green, blue);
  const cmin = Math.min(red, green, blue);
  const diff = cmax - cmin;

  let l = (cmax + cmin) / 2;
  let s = diff == 0 ? 0 : diff / (1 - Math.abs(2 * l - 1));

  let h = 0;
  if (diff == 0) {
    h = 0;
  } else {
    switch (cmax) {
      case red:
        h = ((green - blue) / diff) % 6;
        break;
      case green:
        h = (blue - green) / diff + 2;
        break;
      default:
        h = (red - green) / diff + 4;
        break;
    }
  }

  h = Math.round(h * 60);
  if (h < 0) h += 360;

  s = Math.round(+(s * 100).toFixed(1));
  l = Math.round(+(l * 100).toFixed(1));

  if (g.alpha == 1.0) return `hsl(${h},${s}%,${l}%)`;
  return `hsla(${h},${s}%,${l}%,${g.alpha})`;
}

export function hexToHsl(value: string) {
  const gRgba = newGdkRgba(value);
  if (!gRgba) return;

  return gRgbaToHsl(gRgba);
}
