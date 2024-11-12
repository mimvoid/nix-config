from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup

from dooit.api import Todo
from dooit.ui.api.widgets import TodoWidget

from dooit_extras.formatters import (
    description_children_count,
    description_highlight_tags,
    description_strike_completed,
    todo_description_progress,
    due_casual_format,
    due_icon,
    recurrence_icon,
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

from rich.style import Style
from rich.text import Text


# Get colorscheme
import moonfall_eve

# Get variables
import settings as my


@subscribe(Startup)
def setup_colorscheme(api: DooitAPI, _):
    api.css.set_theme(moonfall_eve.MoonfallEve)


@subscribe(Startup)
def setup_formatters(api: DooitAPI, _):
    fmt = api.formatter
    theme = api.vars.theme

    # A bit of a mess here... beware!

    # Format workspaces & todos to display children count
    if my.ws_number_children:
        children_format = Text(" ({}) ", style=theme.primary).markup
        fmt.workspaces.description.add(description_children_count(children_format))

    if my.todo_number_children:
        desc_format = Text(" ({completed_count}/{total_count}) ", style=theme.primary).markup
        fmt.todos.description.add(todo_description_progress(desc_format))

    # Set icons
    fmt.todos.status.add(status_icons(**my.status_icons))
    fmt.todos.urgency.add(urgency_icons(icons=my.urgency_icons))
    fmt.todos.due.add(due_icon(**my.due_icons))
    api.formatter.todos.recurrence.add(recurrence_icon(icon=my.recurrence_icon))

    # Description
    format = Text(desc_format[0], style=desc_format[1]).markup

    # Casual due date format
    if my.due_casual:
        fmt.todos.due.add(due_casual_format())

    # Iconify tags
    if my.highlight_tags:
        fmt.todos.description.add(description_highlight_tags(fmt=my.tags_format))

    # Strikethrough completed todos
    if my.strikethrough_complete:
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

    widgets = [
        TextBox(api, " 󰄛 ", bg=theme.magenta),
        Spacer(api, width=1),
        Mode(api, **my.mode),
        Spacer(api, width=1),
        Ticker(api,
               fmt=my.ticker,
               fg=theme.cyan,
               bg=theme.background2),
        Spacer(api, width=0),
        StatusIcons(api, **my.bar_status_icons, bg=theme.background2),
        Spacer(api, width=1),
        Date(api, **my.date)
    ]
    api.bar.set(widgets)


# Dashboard
@subscribe(Startup)
def setup_dashboard(api: DooitAPI, _):
    theme = api.vars.theme

    ascii_primary = theme.cyan
    ascii_secondary = theme.red

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
    ascii_art = Text(my.ascii_art, style=ascii_primary)
    ascii_art.highlight_words(my.ascii_hl, style=ascii_secondary)

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
