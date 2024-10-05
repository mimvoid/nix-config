#!/bin/sh

# Based on disfetch, fetchutils, and diyfetch
# https://github.com/q60/disfetch
# https://github.com/kiedtl/fetchutils
# https://github.com/info-mono/diyfetch

# Shorthands --------------------------------------------------------------

elem () {
  # shellcheck disable=SC2059 # the only way
  printf "$2" | sed "$1!d"
}

# System information ------------------------------------------------------

# Username
USR=${USERNAME:-${USER:-${LOGNAME:-$(whoami)}}}

# Hostname
if [ -f /etc/hostname ]; then
  HOST=$(cat /etc/hostname)
else
  HOST=$(uname -n)
fi

# Operating system
if [ -f /etc/os-release ]; then
  OS=$(. /etc/os-release && echo "$NAME" "$VERSION_ID" |
    tr '[:upper:]' '[:lower:]')
else
  OS=$(uname -s | tr '[:upper:]' '[:lower:]')
fi

KERNEL=$(uname -r | tr '[:upper:]' '[:lower:]')

DESKTOP=$(echo "${XDG_CURRENT_DESKTOP:-$DESKTOP_SESSION}" |
  awk -F/ '{ print tolower($NF) }')

UPTIME=$(uptime | cut -f1 -d "," | sed -E -e 's/^[^,]*up *//' \
  -e 's/, *[[:digit:]]* users.*//; s/min/minutes/' \
  -e 's/([[:digit:]]+):0?([[:digit:]]+)/\1h \2m/' |
  xargs)

# Packages (from disfetch)
# note for nixos: display only current user installed packages
packages_apk() { apk info 2>/dev/null | wc -l; }
packages_dpkg() { dpkg -l 2>/dev/null | grep -c "^ii"; }
packages_haiku() { pkgman search -ia  2>/dev/null |
  awk 'FNR > 2 { print }' | wc -l; }
packages_nix() { nix-store -q --requisites ~/.nix-profile 2>/dev/null | wc -l; }
packages_pacman() { pacman -Qq 2>/dev/null | wc -l; }
packages_rpm() { rpm -qa 2>/dev/null | wc -l; }
packages_slack() { find /var/log/packages -mindepth 1 -maxdepth 1 2>/dev/null |
  wc -l; }
packages_xbps() { xbps-query -l 2>/dev/null | wc -l; }
packages_emerge() { find /var/db/pkg -mindepth 2 -maxdepth 2 2>/dev/null |
  wc -l; }

# shellcheck disable=SC2034 # actually used in eval
PACKAGES="$(
  case $OS in
    alpine*|postm*) packages_apk;;
    android*|astra*|*bian*|elementary*|*mint*|mx*|*ubuntu*|zorin*|kali*)
      packages_dpkg;;
    arc*|artix*|endeavour*|manjaro*|garuda*|msys2*|parabola*)
      packages_pacman;;
    fedora*|qubes*|cent*|redhat*|opensuse*) packages_rpm;;
    gentoo*) packages_emerge;;
    haiku*) packages_haiku;;
    nixos*) packages_nix;;
    slack*) packages_slack;;
    void*) packages_xbps;;
  esac
)"

# Components -----------------------------------------------------------

# Colors
r="\033[31m"  # red
g="\033[32m"  # green
y="\033[33m"  # yellow
b="\033[34m"  # blue
m="\033[35m"  # magenta
c="\033[36m"  # cyan
#w="\033[37m"  # white

br="\033[91m" # bright red
bg="\033[92m" # bright green
by="\033[93m" # bright yellow
bb="\033[94m" # bright blue
bm="\033[95m" # bright magenta
bc="\033[96m" # bright cyan
gr="\033[97m" # white (gray)

bo="\033[1m"  # bold
x="\033[0m"   # reset

read -r info <<EOF
$c╭────────────╮\n\
$c│ $r$bo user     $x$c│ $x$USR$gr@$x$HOST\n\
$c│ $y󰌽$bo os       $x$c│ $x$OS\n\
$c│ $c$bo kernel   $x$c│ $x$KERNEL\n\
$c│ $g$bo desktop  $x$c│ $x$DESKTOP\n\
$c│ $b$bo shell    $x$c│ $x$(basename "$SHELL")\n\
$c│ $m󰥔$bo uptime   $x$c│ $x$UPTIME\n\
$c│ $y󰏔$bo packages $x$c│ $x$PACKAGES\n\
$c╰────────────╯\n\
$x $br $bg $by $bb $bm $bc $gr $x\n
EOF

# Art ---------------------------------------------------------------------

IFS= # from disfetch, preserve leading and trailing whitespaces
case $OS in
  nixos*)
    read -r art <<EOF
$x                        \n\
$bo$bb       \\\\\\\\    $bc\\\\\\\\  //     $x\n\
$bo$bb        \\\\\\\\    $bc\\\\\\\\//      $x\n\
$bo$bb    ::::://====$bc\\\\\\\\  $bb//   $x\n\
$bo$bc       ///      \\\\\\\\$bb//    $x\n\
$bo$bc  """"//$bb\\\\\\\\      ///"""" $x\n\
$bo$bc     //  $bb\\\\\\\\$bc====//:::::  $x\n\
$bo$bb        //\\\\\\\\    $bc\\\\\\\\      $x\n\
$bo$bb       //  \\\\\\\\    $bc\\\\\\\\     $x\n\
$x                        \n
EOF
    ;;
esac
unset IFS

# Combining --------------------------------------------------------------

printf "\n" # add spacing around
for i in $(seq 10); do
  # shellcheck disable=SC2059
  echo "$(elem "$i" "$art")" "$(elem "$i" "$info")"
done
printf "\n"
