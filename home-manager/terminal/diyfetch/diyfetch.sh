#!/bin/sh

# This is a severe work in progress,
# it's very messy

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

PACKAGES=$(nix-store -q --requisites ~/.nix-profile 2>/dev/null | wc -l)


# Print information -------------------------------------------------------

set -- \
'31m user    ' \
'33m󰌽 os      ' \
'36m kernel  ' \
'32m desktop ' \
'34m shell   ' \
'35m󰥔 uptime  ' \
'33m󰏔 packages'

prefix=$(printf '\033[36m╭────────────╮\n' &&
  for i in "$@";
  do
    printf '\033[36m│ '
    printf '\033[%s' "$i"
    printf '\033[36m │\n'
    shift
  done
  printf '\033[36m╰────────────╯\n')


info=$(printf '             \n'
  printf '\033[0m%s' " $USR" &&
  printf '\033[97m@' &&
  printf '\033[0m%s\n' "$HOST"

  for i in "$OS" "$KERNEL" "$DESKTOP" "$(basename "$SHELL")" "$UPTIME" "$PACKAGES";
  do
    printf '\033[0m%s\n' " $i"
  done

  printf '             \n')


palette=$(printf '\033[0m '
for i in 1 2 3 4 5 6 7;  
  do
    printf '\033[9%sm%s' "$i" " "
  done
printf '\033[0m\n')


art=$(printf '                        \n' &&
  printf '\033[1;94m       \\\    '       &&
  printf '\033[96m\\\  //     \n'         &&
  printf '\033[1;94m        \\\    '      &&
  printf '\033[96m\\\//      \n'          &&
  printf '\033[1;94m    ::::://===='      &&
  printf '\033[96m\\\  //   \n'           &&
  printf '\033[1;96m       ///      \\\'  &&
  printf '\033[94m//    \n'               &&
  printf '\033[1;96m  """"//'             &&
  printf '\033[94m\\\      ///"""" \n'    &&
  printf '\033[1;96m     //  '            &&
  printf '\033[1;94m\\\'                  &&
  printf '\033[96m====//:::::  \n'        &&
  printf '\033[1;94m        //\\\    '    &&
  printf '\033[96m\\\      \n'            &&
  printf '\033[1;94m       //  \\\    '   &&
  printf '\033[96m\\\     \n'             &&
  printf '                        \n')

# Display ------------------------------------------------------------------------------------------

terminal_size=$(stty size)
terminal_height=${terminal_size% *}
terminal_width=${terminal_size#* }

prompt_height=${PROMPT_HEIGHT:-1}
prompt_width=${PROMPT_WIDTH:-51}

print_test() {
	no_color=$(printf '%b' "${1}" | sed -e 's/\x1B\[[0-9;]*[JKmsu]//g')

	[ "$(printf '%s' "${no_color}" | wc --lines)" -gt $(( terminal_height - prompt_height )) ] && return 1
	[ "$(printf '%s' "${no_color}" | wc --max-line-length)" -gt "${terminal_width}" ] && return 1

	gum style --align left --width="${prompt_width}" "${1}" ''
	printf '%b' "\033[A"

	exit 0
}

full_info=$(gum join --horizontal "${prefix}" "${info}" && echo "$palette")

# Default layout
print_test "$(printf "\n" &&
  gum join --horizontal "${art}" "${full_info}" &&
  printf "\n")"

# Other layout
print_test "${full_info}"

exit 1
