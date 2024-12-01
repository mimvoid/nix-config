from typing import Callable, Optional
from datetime import datetime
from dooit.api import Todo


def my_due(fmt="{}") -> Callable:
    def wrapper(due: Optional[datetime], _: Todo) -> str:
        """
        Based on date_casual_format()
            - With the day before the month
            - And time outside parentheses

        Example: 12 Nov '25 22:15
        """

        if not due:
            return ""

        current_year = datetime.now().year
        dt_format = "%d %b"

        if due.year != current_year:
            dt_format += " '%y"

        if due.hour != 0 or due.minute != 0:
            dt_format += " %H:%M"

        return fmt.format(due.strftime(dt_format))

    return wrapper
