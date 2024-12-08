from dooit.ui.api import DooitAPI, subscribe
from dooit.ui.api.events import Startup, DooitEvent
from dooit.ui.api.widgets import TodoWidget

from dooit_extras.formatters import (
    description_children_count,
    description_highlight_tags,
    description_strike_completed,
    todo_description_progress,
    due_icon,
    recurrence_icon,
    status_icons,
    urgency_icons,
)
from dooit_extras.bar_widgets import Date, Mode, Spacer, StatusIcons, TextBox, Ticker

from rich.text import Text

# Config helpers
from settings.ui import (
    ascii_art,
    dashboard_text,
    dashboard_statuses,
    TAGS_FORMAT,
    RECURRENCE_ICON,
    STATUS_ICONS,
    URGENCY_ICONS,
    DUE_ICONS,
    BAR_ICON,
    MODE,
    TICKER,
    BAR_STATUS_ICONS,
    DATE,
)
from settings.formats import my_due
# from settings.vars import show_workspace_children
from settings.themes import MoonfallEve


# --------------
# Theme & Layout
# --------------


@subscribe(Startup)
def setup_layout(api: DooitAPI, _):
    api.css.set_theme(MoonfallEve)

    api.layouts.todo_layout = [
        TodoWidget.status,
        TodoWidget.description,
        TodoWidget.recurrence,
        TodoWidget.due,
        TodoWidget.urgency,
    ]


@subscribe(DooitEvent)
def define_vars(api: DooitAPI, event: DooitEvent):
    # Disable confirmation check
    api.vars.show_confirm = False


# @subscribe(Startup)
# def setup_vars(api: DooitAPI, _):
#     show_workspace_children(api)


# ----------
# Formatting
# ----------


@subscribe(Startup)
def format_workspaces(api: DooitAPI, _):
    theme = api.vars.theme
    w = api.formatter.workspaces

    # Children count
    children = Text(" ({}) ", style=theme.primary)
    w.description.add(description_children_count(children.markup))


@subscribe(Startup)
def format_todos(api: DooitAPI, _):
    theme = api.vars.theme
    t = api.formatter.todos

    # Children count
    children = Text(" ({completed_count}/{total_count}) ", style=theme.primary)
    t.description.add(todo_description_progress(children.markup))

    # Set icons
    t.status.add(status_icons(**STATUS_ICONS))
    t.urgency.add(urgency_icons(icons=URGENCY_ICONS))
    t.due.add(due_icon(**DUE_ICONS))
    t.recurrence.add(recurrence_icon(icon=RECURRENCE_ICON))

    # Modified casual due date format
    t.due.add(my_due)

    # Iconify tags
    t.description.add(description_highlight_tags(fmt=TAGS_FORMAT))

    # Strikethrough completed todos
    t.description.add(description_strike_completed())


# ---
# Bar
# ---


@subscribe(Startup)
def setup_bar(api: DooitAPI, _):
    theme = api.vars.theme

    widgets = [
        TextBox(api, BAR_ICON, bg=theme.magenta),
        Spacer(api, width=1),
        Mode(api, **MODE),
        Spacer(api, width=1),
        Ticker(api, fmt=TICKER, fg=theme.cyan, bg=theme.background2),
        Spacer(api, width=0),
        StatusIcons(api, **BAR_STATUS_ICONS, bg=theme.background2),
        Spacer(api, width=1),
        Date(api, **DATE),
    ]

    api.bar.set(widgets)


# ---------
# Dashboard
# ---------


@subscribe(Startup)
def setup_dashboard(api: DooitAPI, _):
    items = [ascii_art(api), ""] + dashboard_text(api) + ["", ""] + dashboard_statuses(api)
    api.dashboard.set(items)
