from dooit.api.theme import DooitThemeBase
from dooit.api import Todo

from rich.text import Text


# ------- DASHBOARD -------


def ascii_art(theme: DooitThemeBase) -> Text:
    """
    A helper function.

    Will be called during an @subscribe(Setup) decorated function in config.py
    to pass in the api argument.
    """

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


def dashboard_text(theme: DooitThemeBase) -> list[Text]:
    return [
        Text.assemble(
            ("The fear within me is beyond ", theme.foreground2),
            ("anything", theme.green),
            (" your soul can make.", theme.foreground2),
        ),
        Text.assemble(
            ("You ", theme.foreground2),
            ("cannot kill me", theme.red),
            (" in a ", theme.foreground2),
            ("way that matters", theme.red),
            (".", theme.foreground2),
        ),
    ]


def dashboard_statuses(theme: DooitThemeBase) -> list[Text]:
    due_today = 0
    overdue = 0

    for i in Todo.all():
        if i.is_overdue:
            overdue += 1
        elif i.is_due_today and i.is_pending and (i.due is not None):
            due_today += 1

    return [
        Text(f"󰔚 Tasks today: {due_today}", style=theme.green),
        Text(f" Tasks overdue: {overdue}", style=theme.red),
    ]


# ------- TODOS -------

TAGS_FORMAT = " {}"

# Icons
RECURRENCE_ICON = " "

STATUS_ICONS = {"completed": " ", "pending": "● ", "overdue": " "}

URGENCY_ICONS = {1: "   ", 2: "  󱊡", 3: "  󱊢", 4: " !󱊣"}


def urgency_colors(theme: DooitThemeBase) -> dict[int, str]:
    return {1: theme.blue, 2: theme.green, 3: theme.yellow, 4: theme.red}


DUE_ICONS = {"completed": " ", "pending": " ", "overdue": " "}


# ------- BAR -------

MODE = {"format_normal": " 󰆋 NORMAL ", "format_insert": "  INSERT "}

TICKER = " 󱎫 {} "

BAR_STATUS_ICONS = {"completed_icon": " ", "pending_icon": "󰔚 ", "overdue_icon": " "}

DATE = {"fmt": " 󰧒 {} ", "format": "%b %d %H:%M"}
