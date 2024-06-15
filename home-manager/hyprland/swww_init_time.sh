#!/bin/sh

case $(date +%H) in
	00 | 01 | 02 | 03 | 04 | 05 | 06) # 0:00 to 6:59, early morning

		swww img "$HOME"/NixOS/wallpapers/gracile_twilight.jpg
		;;
	07 | 08 | 09 | 10 | 11 | 12 | 13 | 14) # 7:00 to 14:59, morning/midday

		swww img "$HOME"/NixOS/wallpapers/aeuna_under-the-blue-sky-4.jpg
		;;
	15 | 16 | 17 | 18 | 19 | 20) # 15:00 to 19:59, late afternoon/evening

    swww img "$HOME"/NixOS/wallpapers/axle_end-of-the-summer.jpg
    ;;
  21 | 22 | 23) # 20:00 to 23:59, evening/nighttime

		swww img "$HOME"/NixOS/wallpapers/gracile_overgrown.jpg
		;;
esac
