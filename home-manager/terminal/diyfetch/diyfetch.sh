#!/bin/sh

# System information ------------------------------------------------------

# Username
USERNAME=${USER:-$(whoami)}

# Hostname
if [ -f /etc/hostname ]; then
  HOST=$(cat /etc/hostname)
else
  HOST=$(uname -n)
fi

OS=$(. /etc/os-release && echo "$NAME" "$VERSION_ID" |
  tr '[:upper:]' '[:lower:]')

KERNEL=$(uname -r | tr '[:upper:]' '[:lower:]')

DESKTOP=$(echo "${XDG_CURRENT_DESKTOP:-$DESKTOP_SESSION}" |
  tr '[:upper:]' '[:lower:]')

UPTIME=$(uptime | cut -f1 -d "," | sed -E -e 's/^[^,]*up *//' \
  -e 's/, *[[:digit:]]* users.*//; s/min/minutes/' \
  -e 's/([[:digit:]]+):0?([[:digit:]]+)/\1h \2m/' |
  xargs)

PACKAGES=$(nix-store -q --requisites ~/.nix-profile 2>/dev/null | wc -l)


# Print information -------------------------------------------------------

prefix=$(gum style --border rounded --border-foreground 6 --padding '0 1' \
"[1;38;5;1m user
[1;38;5;3m󰌽 os
[1;38;5;6m kernel
[1;38;5;2m desktop
[1;38;5;4m shell
[1;38;5;5m󰥔 uptime
[1;38;5;3m󰏔 packages")

info=$(gum style --padding '1 1' \
"[0m$USERNAME[38;5;8m@[0m$HOST
[0m$OS
[0m$KERNEL
[0m$DESKTOP
[0m$(basename "${SHELL}")
[0m$UPTIME
[0m$PACKAGES")

palette=$(printf '\033[0m '
for i in 1 2 3 4 5 6 7;  
  do
    printf '\033[9%sm%s' "$i" " "
  done
printf '\033[0m\n')

#art=$(gum style --bold --foreground 6 '
#       [1;38;5;4m\\    [1;38;5;6m\\  //
#        [1;38;5;4m\\    [1;38;5;6m\\//
#    [1;38;5;4m::::://====[1;38;5;6m\\  [1;38;5;6m//
#       ///      \\[1;38;5;4m//
#  """"//[1;38;5;4m\\      ///"""" 
#     //  [1;38;5;4m\\[1;38;5;6m====//:::::
#        [1;38;5;4m//\\    [1;38;5;6m\\
#       [1;38;5;4m//  \\    [1;38;5;6m\\')

art=$(printf '\033[96m                        \n' &&
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
  printf '\033[96m                        \n')

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

full_info=$(gum join --horizontal "${prefix}" "${info}")
full_info_colors=$(gum join --vertical "${full_info}" "${palette}")

# Default layout
print_test "$(printf "\n" &&
  gum join --horizontal "${art}" "${full_info_colors}" &&
  printf "\n")"

# Other layout
print_test "${full_info_colors}"

exit 1
