"""
A little file for defining and viewing settings in a quick way
It is not a replacement for a standard dooit config.py file
"""

from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup


# ------- COLORSCHEME -------

from moonfall_eve import MoonfallEve

@subscribe(Startup)
def setup_colorscheme(api: DooitAPI, _):
    api.css.set_theme(MoonfallEve)


# ------- DASHBOARD -------

# Art by Joan Stark
# Modified by mimvoid, inspired by Blazej Kozlowski
# source: https://www.asciiart.eu/animals/cats

ascii_art = r"""
               _ |\_
               \` _ \
         __,.-‟ =___Y=
       .‟        )
 _    /   ,    \/\_
((____|    )_-\ \_-`  bug
`------`-----` `--`
"""
ascii_hl = ["bug"]


# ------- WORKSPACES -------

ws_number_children = True


# ------- TODOS -------

# Descriptions
todo_number_children = True
strikethrough_complete = True

# Tags
highlight_tags = True

if highlight_tags:
    tags_format = " {}"

# Due
due_casual = True

# Icons
recurrence_icon = " "

status_icons = {
    "completed": " ",
    "pending": "● ",
    "overdue": " "
}

urgency_icons = {
    1: "   ",
    2: "  󱊡",
    3: "  󱊢",
    4: " !󱊣"
}

due_icons = {
    "completed": " ",
    "pending": " ",
    "overdue": " "
}


# ------- BAR -------

bar_icon = " 󰄛 "

mode = {
    "format_normal": " 󰆋 NORMAL ",
    "format_insert": "  INSERT "
}

ticker = " 󱎫 {} "

bar_status_icons = {
    "completed_icon": " ",
    "pending_icon": "󰔚 ",
    "overdue_icon": " "
}

date = {
    "fmt": " 󰧒 {} ",
    "format": "%b %d %H:%M"
}
