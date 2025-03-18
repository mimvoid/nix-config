from dooit.ui.api import DooitAPI
from dooit.api import Todo

from rich.style import Style
from rich.text import Text


# ------- DASHBOARD -------


def ascii_art(api: DooitAPI) -> Text:
    """
    A helper function.

    Will be called during an @subscribe(Setup) decorated function in config.py
    to pass in the api argument.
    """

    theme = api.vars.theme

    primary = theme.cyan
    secondary = theme.red

    # Art by Joan Stark
    # Modified by mimvoid, inspired by Blazej Kozlowski
    # source: https://www.asciiart.eu/animals/cats

    art = r"""
               _ |\_
               \` _ \
         __,.-‟ =___Y=
       .‟        )
 _    /   ,    \/\_
((____|    )_-\ \_-`  bug
`------`-----` `--`
    """

    ascii = Text(art, style=primary)
    ascii.highlight_words(["bug"], style=secondary)

    return ascii


def dashboard_text(api: DooitAPI) -> list[Text]:
    theme = api.vars.theme

    text = [
        "The fear within me is beyond anything your soul can make.",
        "You cannot kill me in a way that matters.",
    ]

    hl_words = [["anything"], ["cannot kill me", "way that matters"]]
    colors = [theme.green, theme.red]

    formatted_lines = []
    for t, w, c in zip(text, hl_words, colors):
        lines = Text(t, style=Style(color=theme.foreground2, bold=True, italic=True))
        lines.highlight_words(w, style=c)
        formatted_lines.append(lines)

    return formatted_lines


def dashboard_statuses(api: DooitAPI) -> list[Text]:
    theme = api.vars.theme

    due_today = [
        1 for i in Todo.all() if (i.due is not None) and i.is_due_today and i.is_pending
    ]

    overdue = sum([1 for i in Todo.all() if i.is_overdue])

    statuses = [
        Text("󰔚 Tasks today: {}".format(sum(due_today)), style=theme.green),
        Text(" Tasks overdue: {}".format(overdue), style=theme.red),
    ]

    return statuses


# ------- TODOS -------

TAGS_FORMAT = " {}"

# Icons
RECURRENCE_ICON = " "

STATUS_ICONS = {"completed": " ", "pending": "● ", "overdue": " "}

URGENCY_ICONS = {1: "   ", 2: "  󱊡", 3: "  󱊢", 4: " !󱊣"}


def urgency_colors(api: DooitAPI) -> dict[int, str]:
    theme = api.vars.theme
    return {1: theme.blue, 2: theme.green, 3: theme.yellow, 4: theme.red}


DUE_ICONS = {"completed": " ", "pending": " ", "overdue": " "}


# ------- BAR -------

BAR_ICON = " 󰄛 "

MODE = {"format_normal": " 󰆋 NORMAL ", "format_insert": "  INSERT "}

TICKER = " 󱎫 {} "

BAR_STATUS_ICONS = {"completed_icon": " ", "pending_icon": "󰔚 ", "overdue_icon": " "}

DATE = {"fmt": " 󰧒 {} ", "format": "%b %d %H:%M"}
