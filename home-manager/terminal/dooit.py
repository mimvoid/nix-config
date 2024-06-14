# Rose Pine Moon palette

base = "#232136"
surface = "#2a273f"
overlay = "#393552"
muted = "#6e6a86"
subtle = "#908caa"
text = "#e0def4"
love = "#eb6f92"
gold = "#f6c177"
rose = "#ea9a97"
pine = "#3e8fb0"
foam = "#9ccfd8"
iris = "#c4a7e7"
hl-low = "#2a283e"
hl-med = "#44415a"
hl-high = "#56526e"

# Config
BACKGROUND = base
BAR-BACKGROUND = base
WORKSPACES_BACKGROUND = base
TODOS_BACKGROUND = base
BORDER_DIM = overlay
BORDER_LIT = rose

BORDER_TITLE_DIM = subtle, base # fg then bg
BORDER_TITLE_LIT = text, rose

SEARCH_COLOR = love
YANK_COLOR = pine

SAVE_ON_ESCAPE = False

USE_DATE_FIRST = True # True = dd-mm, False = mm-dd
DATE_FORMAT = "%d %h"
TIME_FORMAT = "%H:%M"

DASHBOARD = [ART, QUOTE, PAD, STATS]
# Art by Blazej Kozlowski
ART = print(r"""\
       _                        
       \`*-.                    
        )  _`-.                 
       .  : `. .                
       : _   '  \               
       ; *` _.   `*-._          
       `-.-'          `-.       
         ;       `       `.     
         :.       .        \    
         . \  .   :   .-'   .   
         '  `+.;  ;  '      :   
         :  '  |    ;       ;-. 
         ; '   : :`-:     _.`* ;
[bug] .*' /  .*' ; .*`- +'  `*' 
      `*-*   `*-*  `*-*'
            """)
QUOTE = [
    "can you feel your heart burning?",
    "can you feel the struggle within?",
    "the fear within me is beyond anything your soul can make.",
    "you cannot kill me in a way that matters",
]
PAD = " "
STATS = [
    f"Completed: {completed}",
    f"Pending: {pending}",
    f"Overdue: {overdue}",
]

EMPTY_WORKSPACE = [
    ":(",
    "No workspaces?",
    f"Press [{cyan}]'a'[/{cyan}] to add some!",
]
WORKSPACE = [
    "editing": pine,
    "pointer": "> ",
    "children_hint": " ›",
    "start_expanded": True,
]

# Todos
COLUMN_ORDER = ["description", "due", "urgency"]
EMPTY_TODO = [
    ":O",
    "Wow so empty!?",
    "Let's think of some stuff to do!"
]
TODO = [
    "color_todos": False, # color based on status
    "editing": pine,
    "pointer": "> ",

    "due_icon": "",

    "effort_icon": "󱐋 ",
    "effort_color": gold,

    "recurrence_icon": " 󰑏 ",
    "recurrence_color": foam,

    "tags_color": love,

    "completed_icon": "✕ ",
    "pending_icon": " ",
    "overdue_icon": " ",

    "urgency1_icon": "󰂎",
    "urgency2_icon": "󱊡",
    "urgency3_icon": "󱊢",
    "urgency4_icon": "󱊣!",

    "urgency1_color": pine,
    "urgency2_color": foam,
    "urgency3_color": gold,
    "urgency4_color": love,

    "children_hint": "({done}/{total})",
    "start_expanded": True,
]

#keybindings = [
#    "move down": ["j", "<down>"],
#    "shift down": ["J", "<shift+down>"],
#    "move up": ["k", "<up>"],
#    "shift up": ["K", "<shift+up>"],
#]
