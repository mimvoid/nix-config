from extra import *

# Rose Pine Moon palette

base = "#232136"
muted = "#908caa"
text = "#e0def4"
love = "#eb6f92"
gold = "#f6c177"
rose = "#ea9a97"
pine = "#3e8fb0"
foam = "#9ccfd8"
iris = "#c4a7e7"

# dooit's colors
red = love
yellow = gold
green = pine

# Config
BACKGROUND = base
BAR_BACKGROUND = base
WORKSPACES_BACKGROUND = base
TODOS_BACKGROUND = base
BORDER_DIM = iris + " 50%"
BORDER_LIT = rose

BORDER_TITLE_DIM = muted, base # fg then bg
BORDER_TITLE_LIT = rose, base

SEARCH_COLOR = love
YANK_COLOR = pine

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
    f"{col('bug',rose)}   .·  .  .·' ; .·`- +'  `· ॱ",
    "      `·-·   `·-·  `·-·'        ",
]

# Didn't use an array since I wanted them centered
QUOTE1 = f"can you feel your {col('heart',love)} burning?"
QUOTE2 = "can you feel the struggle within?"
QUOTE3 = f"the fear within me is beyond {col('anything',pine)} your soul can make."
QUOTE4 = f"you {col('cannot kill me',love)} in a {col('way that matters',love)}"



PAD = " "

DASHBOARD = [ART_D, PAD, QUOTE1, QUOTE2, QUOTE3, QUOTE4]

# Workspaces
EMPTY_WORKSPACE = [
    ":O",
    "No workspaces?",
    f"Press [{foam}]'a'[/{foam}] to add some!",
]
WORKSPACE = {
    "editing": pine,
    "pointer": ">",
    "children_hint": " ›",
    "start_expanded": True,
}

# Todos
# Art by Joan Stark
# source: https://www.asciiart.eu/animals/cats
ART_T = [
    "               _ |\_   ",
    f"               \` ..\  {col('?', rose)}",
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
    "editing": pine,
    "pointer": ">",

    "due_icon": "󰃭 ",

    "effort_icon": " ",
    "effort_color": gold,

    "recurrence_icon": "  ",
    "recurrence_color": foam,

    "tags_color": love,

    "completed_icon": "✕ ",
    "pending_icon": " ",
    "overdue_icon": " ",

    # Urgency
    "initial_urgency": 1,

    "urgency1_icon": " ",
    "urgency2_icon": "󱊡",
    "urgency3_icon": "󱊢",
    "urgency4_icon": "󱊣!",

    "urgency1_color": "pine",
    "urgency2_color": "foam",
    "urgency3_color": "gold",
    "urgency4_color": "love",

    # Children
    "children_hint": "({done}/{total})",
    "start_expanded": True,
}

# Status bar

status_icons = {
    "NORMAL": ["󰆋 ", pine],
    "INSERT": [" ", rose],
    "DATE": ["󰃭 ", love],
    "SEARCH": [" ", foam],
    "SORT": [" ", iris],
    "K PENDING": [" ", gold],
}

def status(status):
    icon, color = status_icons[status]
    return blk(icon + status, color)

def get_message(message):
    return " " + message

def get_clock() -> str:
    return blk('󰥔', foam) + col(f"{datetime.now().time().strftime(' %H:%M ')}", foam)

def get_username():
    try:
        username = os.getlogin()
    except OSError:
        uid = os.getuid()
        import pwd

        username = pwd.getpwuid(uid).pw_name
    return blk('', pine) + col(f" {username}", pine)

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
