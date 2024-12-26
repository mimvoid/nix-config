// Taken from hyprpanel:
// https://github.com/Jas-SinghFSU/HyprPanel/blob/master/src/lib/variables.ts

import { Variable } from "astal";
import GLib from "gi://GLib";

export const time = Variable(GLib.DateTime.new_now_local()).poll(
  1000,
  (): GLib.DateTime => GLib.DateTime.new_now_local(),
)

export const uptime = Variable(0).poll(
    60_00,
    'cat /proc/uptime',
    (line): number => Number.parseInt(line.split('.')[0]) / 60,
);
