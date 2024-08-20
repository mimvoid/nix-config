from extra import *

base = "#25223a"
muted = "#5d5573"
text = "#e8dfdd"
red = "#f281a6"
green = "#6990d6"
yellow = "#efa4b7"
blue = "#9673de"
magenta = "#c37ac9"
cyan = "#b1b5e4"

# Config
BACKGROUND = base
BAR_BACKGROUND = base
WORKSPACES_BACKGROUND = base
TODOS_BACKGROUND = base
BORDER_DIM = blue + " 50%"
BORDER_LIT = yellow

BORDER_TITLE_DIM = muted, base # fg then bg
BORDER_TITLE_LIT = yellow, base

SEARCH_COLOR = red
YANK_COLOR = green

SAVE_ON_ESCAPE = False

USE_DATE_FIRST = True # True = dd-mm, False = mm-dd
DATE_FORMAT = "%d %h"
TIME_FORMAT = "%H:%M"

# Dashboard
# Art by Blazej Kozlowski
# Modified by mimvoid
# source: https://www.asciiart.eu/animals/cats
ART_D = [
    "      .                         ",
    "      \  ॱ` -.                  ",
    "       .  ,-. `.                ",
    "       : _   `  \               ",
    "     _ ) *   .   `·-._          ",
    "     ‾ `-.- '         `-.       ",
    "         ;       `       `.     ",
    "         :.       .        \    ",
    "         . \  .   :   .-'   .   ",
    "         '  `+.;  ;  '      :   ",
    "         :  '  |    ;       ;-. ",
    "        .  '   :  :`:     _.`· ;",
    f"{col('bug',yellow)}   .·  .  .·' ; .·`- +'  `· ॱ",
    "      `·-·   `·-·  `·-·'        ",
]

# Didn't use an array since I wanted them centeyellow
QUOTE1 = f"can you feel your {col('heart',red)} burning?"
QUOTE2 = "can you feel the struggle within?"
QUOTE3 = f"the fear within me is beyond {col('anything',green)} your soul can make."
QUOTE4 = f"you {col('cannot kill me',red)} in a {col('way that matters',red)}"



PAD = " "

DASHBOARD = [ART_D, PAD, QUOTE1, QUOTE2, QUOTE3, QUOTE4]

# Workspaces
EMPTY_WORKSPACE = [
    ":O",
    "No workspaces?",
    f"Press [{cyan}]'a'[/{cyan}] to add some!",
]
WORKSPACE = {
    "editing": green,
    "pointer": ">",
    "children_hint": " ›",
    "start_expanded": True,
}

# Todos
# Art by Joan Stark
# source: https://www.asciiart.eu/animals/cats
ART_T = [
    "               _ |\_   ",
    f"               \` ..\  {col('?', yellow)}",
    "         __,.-‟ =___Y= ",
    "       .‟        )     ",
    " _    /   ,    \/\_    ",
    "((____|    )_-\ \_-`   ",
    "`------`-----` `--`    ",
]

EMPTY_TODO = [
    ART_T,
    PAD,
    "Wow so empty!?",
    "Let's think of some stuff to do!",
]

COLUMN_ORDER = ["description", "due", "urgency"]
TODO = {
    "color_todos": False, # color based on status
    "editing": green,
    "pointer": ">",

    "due_icon": "󰃭 ",

    "effort_icon": " ",
    "effort_color": magenta,

    "recurrence_icon": "  ",
    "recurrence_color": cyan,

    "tags_color": red,

    "completed_icon": " ",
    "pending_icon": "● ",
    "overdue_icon": " ",

    # Urgency
    "initial_urgency": 1,

    "urgency1_icon": " ",
    "urgency2_icon": "󱊡",
    "urgency3_icon": "󱊢",
    "urgency4_icon": "󱊣!",

    "urgency1_color": "green",
    "urgency2_color": "blue",
    "urgency3_color": "magenta",
    "urgency4_color": "red",

    # Children
    "children_hint": col(" [{done}/{total}]", muted),
    "start_expanded": True,
}

# Status bar

status_icons = {
    "NORMAL": ["󰆋 ", green],
    "INSERT": [" ", yellow],
    "DATE": ["󰃭 ", red],
    "SEARCH": [" ", cyan],
    "SORT": [" ", blue],
    "K PENDING": [" ", magenta],
}

def status(status):
    icon, color = status_icons[status]
    return blk(icon + status, color)

def get_message(message):
    return " " + message

def get_clock() -> str:
    return blk('󰥔', magenta) + col(f"{datetime.now().time().strftime(' %H:%M ')}", magenta)

def get_username():
    try:
        username = os.getlogin()
    except OSError:
        uid = os.getuid()
        import pwd

        username = pwd.getpwuid(uid).pw_name
    return blk('', green) + col(f" {username}", green)

# TODO: get stats working
#STATS = [
#     f"Completed: {get_total_completed()}",
#     f"Pending: {get_total_pending()}",
#     f"Overdue: {get_total_overdue()}",
#]

bar = {
    "A": [(status, 0.1), get_message],
    "C": [(get_clock, 1), get_username],
}
