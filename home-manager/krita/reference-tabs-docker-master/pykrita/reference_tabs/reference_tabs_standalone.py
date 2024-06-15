# Reference Tabs
# Copyright (C) 2022 Freya Lupen <penguinflyer2222@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

import sys
import argparse
from PyQt5.Qt import Qt
from PyQt5.QtWidgets import QApplication

from reference_tabs_widget import ReferenceTabsWidget

# This is a standalone app version of the docker for testing purposes.
# It depends only on Python and PyQt5.
# It has the same functionality, except for the Krita-dependent things:
# * Krita's icons.
# * Krita's extended image format support.
# * The ability to save configuration.

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("file_path", help="image file path(s)", type=str, nargs='*')
    parser.add_argument("--always_on_top", help="enables window always on top", action='store_true')
    args = parser.parse_args()
    paths = args.file_path
    alwaysOnTop = args.always_on_top

    QApplication.setAttribute(Qt.AA_EnableHighDpiScaling)
    QApplication.setHighDpiScaleFactorRoundingPolicy(Qt.HighDpiScaleFactorRoundingPolicy.PassThrough)
    app = QApplication([])

    app.setApplicationName("Reference Tabs")

    widget = ReferenceTabsWidget()
    # Similar to my usual size for the docker.
    widget.resize(400, 700)
    widget.setWindowFlag(Qt.WindowType.WindowStaysOnTopHint, alwaysOnTop)
    widget.show()

    for path in paths:
        widget.openImage(path)

    sys.exit(app.exec_())
