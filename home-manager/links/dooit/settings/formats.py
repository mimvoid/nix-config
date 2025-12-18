from datetime import datetime
from dooit.api import Todo


def my_due(due: datetime | None, model: Todo) -> str:
    """
    Based on date_casual_format()
        - With the day before the month
        - And time outside parentheses

    Example: 12 Nov '25 22:15
    """

    if not due:
        return ""

    dt_format = "%d %b"

    if due.year != datetime.now().year:
        dt_format += " '%y"

    if due.hour != 0 or due.minute != 0:
        dt_format += " %H:%M"

    return due.strftime(dt_format)
