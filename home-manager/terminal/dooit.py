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
BORDER_TITLE_LIT = base, rose

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
    f"[{rose}]bug[/{rose}]   .·  .  .·' ; .·`- +'  `· ॱ",
    "      `·-·   `·-·  `·-·'        ",
]

# Didn't use an array since I wanted them centered
# TODO: is there a shorthand for this?
QUOTE1 = f"can you feel your [{love}]heart[/{love}] burning?"
QUOTE2 = "can you feel the struggle within?"
QUOTE3 = f"the fear within me is beyond [{pine}]anything[/{pine}] your soul can make."
QUOTE4 = f"you [{love}]cannot kill me[/{love}] in a [{love}]way that matters[/{love}]"

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
    f"               \` ..\  [{rose}]?[/{rose}]",
    "         __,.-‟ =___Y= ",
    "       .‟        )     ",
    " _    /   ,    \/\_    ",
    "((____|    )_-\ \_-`   ",
    "`------`-----` `--`    ",
]

# TODO: get stats working
#STATS = [
#    f"Completed: {done}",
#    f"Pending: {pending}",
#    f"Overdue: {overdue}",
#]

EMPTY_TODO = [
    ART_T,
    PAD,
    "Wow so empty!?",
    "Let's think of some stuff to do!",
    #STATS
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

#keybindings = [
#    "move down": ["j", "<down>"],
#    "shift down": ["J", "<shift+down>"],
#    "move up": ["k", "<up>"],
#    "shift up": ["K", "<shift+up>"],
#]
