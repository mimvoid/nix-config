from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup

from dooit.api import Todo
from dooit.ui.api.widgets import TodoWidget

from dooit_extras.formatters import (
    description_children_count,
    description_highlight_tags,
    description_strike_completed,
    due_casual_format,
    due_icon,
    # recurrence_icon,
    status_icons,
    urgency_icons
)
from dooit_extras.bar_widgets import (
    Date,
    Mode,
    Spacer,
    StatusIcons,
    TextBox,
    Ticker
)
# from dooit_extras.scripts import (
#     toggle_workspaces
# )

from rich.style import Style
from rich.text import Text

import theme

@subscribe(Startup)
def setup_colorscheme(api: DooitAPI, _):
    api.css.set_theme(theme.MoonfallEve)

@subscribe(Startup)
def setup_formatters(api: DooitAPI, _):
    fmt = api.formatter
    theme = api.vars.theme

    # ------- DEFINITIONS -------

    show_children = True
    children_format = (" ({}) ", theme.primary)

    # --- Todos only ---

    desc_format = ("{completed_count}/{total_count}", theme.foreground2)
    strikethrough_complete = True

    highlight_tags = True
    tags_format = " {}"

    # Due format
    due_casual = True

    # Icons
    todo_status_icons = {
        "completed": " ",
        "pending": "● ",
        "overdue": " "
    }

    todo_urgency_icons = {
        1: "   ",
        2: "  󱊡",
        3: "  󱊢",
        4: " !󱊣"
    }

    todo_due_icons = {
        "completed": " ",
        "pending": " ",
        "overdue": " "
    }

    # --------- LOGIC ---------

    # Format workspaces & todos to display children count
    if show_children:
        for i in [fmt.workspaces.description, fmt.todos.description]:
            format = Text(children_format[0], style=children_format[1]).markup
            i.add(description_children_count(format))

    # Set icons
    fmt.todos.status.add(status_icons(**todo_status_icons))
    fmt.todos.urgency.add(urgency_icons(icons=todo_urgency_icons))
    fmt.todos.due.add(due_icon(**todo_due_icons))

    # Description
    format = Text(desc_format[0], style=desc_format[1]).markup

    # Casual due date format
    if due_casual:
        fmt.todos.due.add(due_casual_format())

    # Iconify tags
    if highlight_tags:
        fmt.todos.description.add(description_highlight_tags(fmt=tags_format))

    # Strikethrough completed todos
    if strikethrough_complete:
        fmt.todos.description.add(description_strike_completed())


# Layout
@subscribe(Startup)
def setup_layout(api: DooitAPI, _):
    api.layouts.todo_layout = [
        TodoWidget.status,
        TodoWidget.description,
        TodoWidget.recurrence,
        TodoWidget.due,
        TodoWidget.urgency,
    ]


# Bar
@subscribe(Startup)
def setup_bar(api: DooitAPI, _):
    theme = api.vars.theme

    bar_status_icons = {
        "completed_icon": " ",
        "pending_icon": "󰔚 ",
        "overdue_icon": " "
    }

    widgets = [
        TextBox(api, " 󰄛 ", bg=theme.magenta),
        Spacer(api, width=1),
        Mode(api, format_normal=" 󰆋 NORMAL ", format_insert="  INSERT "),
        Spacer(api, width=1),
        Ticker(api,
               fmt=" 󱫚 {} ",
               fg=theme.cyan,
               bg=theme.background2),
        Spacer(api, width=0),
        StatusIcons(api, **bar_status_icons, bg=theme.background2),
        Spacer(api, width=1),
        Date(api, fmt=" 󰧒 {} ", format="%b %d %H:%M"),
    ]
    api.bar.set(widgets)


# Dashboard
@subscribe(Startup)
def setup_dashboard(api: DooitAPI, _):
    theme = api.vars.theme

    # Art by Joan Stark
    # Modified by mimvoid, inspired by Blazej Kozlowski
    # source: https://www.asciiart.eu/animals/cats

    # Define the ascii art
    ascii_art = r"""
               _ |\_
               \` _ \
         __,.-‟ =___Y=
       .‟        )
 _    /   ,    \/\_
((____|    )_-\ \_-`  bug
`------`-----` `--`
    """
    ascii_color = theme.cyan
    ascii_hl = (["bug"], theme.red)

    lines = [
        (
            "The fear within me is beyond anything your soul can make.",
            ["anything"],
            theme.green
        ),
        (
            "You cannot kill me in a way that matters.",
            ["cannot kill me", "way that matters"],
            theme.red
        )
    ]

    # Implement the ascii art
    ascii_art = Text(ascii_art, style=ascii_color)
    ascii_art.highlight_words(ascii_hl[0], style=ascii_hl[1])

    # Parse the lines
    formatted_lines = []
    for i in lines:
        text = Text(i[0], style=Style(color=theme.foreground2, bold=True, italic=True))
        text.highlight_words(i[1], style=i[2])
        formatted_lines.append(text)

    due_today = sum([1 for i in Todo.all() if i.is_due_today and i.is_pending])
    overdue = sum([1 for i in Todo.all() if i.is_overdue])

    items = [
        ascii_art,
        ""
    ] + formatted_lines + [
        "",
        "",
        Text("󰔚 Tasks today: {}".format(due_today), style=theme.green),
        Text(" Tasks overdue: {}".format(overdue), style=theme.red),
    ]
    api.dashboard.set(items)
