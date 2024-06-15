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

from PyQt5.QtCore import QFileInfo, QMimeDatabase, pyqtSignal
from PyQt5.QtGui import QImage, QImageReader
from PyQt5.QtWidgets import QWidget, QVBoxLayout, QMenuBar, QTabWidget, \
                            QAction, QActionGroup, QFileDialog

# This is just a weird workaround for standalone vs. docker import
if __name__ == "reference_tabs_widget":
    from reference_view_widget import ReferenceViewWidget
else:
    from .reference_view_widget import ReferenceViewWidget


# The main widget, containing the menu bar and tab bar.
class ReferenceTabsWidget(QWidget):

    currentFolderChanged = pyqtSignal('QString')
    currentFolder = ""

    def __init__(self):
        super().__init__()

        self.setAcceptDrops(True)

        layout = QVBoxLayout()
        self.setLayout(layout)

        menubar = QMenuBar()

        # - File menu
        fileMenu = menubar.addMenu("File")
        fileMenu.addAction("Open", self.openImage)
        fileMenu.addAction("Load", self.loadImage)
        fileMenu.addAction("Add Tab", self.addTab)

        closeMenu = fileMenu.addMenu("Close Tabs...")
        closeMenu.addAction("Close Current Tab", self.closeTab)
        closeMenu.addAction("Close All Tabs", self.closeAllTabs)
        closeMenu.addAction("Close Tabs to the Left", self.closeTabsLeft)
        closeMenu.addAction("Close Tabs to the Right", self.closeTabsRight)

        # - Image Setting menu
        settingsMenu = menubar.addMenu("Image Settings")

        zoomSettingsMenu = settingsMenu.addMenu("Zoom Setting")
        self.fitSettingGroup = QActionGroup(self)
        fitPageAction = QAction("Fit Page", self.fitSettingGroup)
        fitPageAction.setCheckable(True)
        fitPageAction.setData(1)
        fitWidthAction = QAction("Fit Width", self.fitSettingGroup)
        fitWidthAction.setCheckable(True)
        fitWidthAction.setData(2)
        fitHeightAction = QAction("Fit Height", self.fitSettingGroup)
        fitHeightAction.setCheckable(True)
        fitHeightAction.setData(3)
        fitFullsizeAction = QAction("Zoom 100%", self.fitSettingGroup)
        fitFullsizeAction.setCheckable(True)
        fitFullsizeAction.setData(4)

        fitPageAction.setChecked(True)
        self.fitSettingGroup.triggered.connect(self.changeFitSetting)
        zoomSettingsMenu.addActions(self.fitSettingGroup.actions())

        scaleSettingsMenu = settingsMenu.addMenu("Scaling Mode Setting")
        self.scaleSettingGroup = QActionGroup(self)
        scaleSmoothAction = QAction("Smooth Scaling", self.scaleSettingGroup)
        scaleSmoothAction.setCheckable(True)
        scaleSmoothAction.setData(1)
        scaleFastAction = QAction("Sharp Scaling", self.scaleSettingGroup)
        scaleFastAction.setCheckable(True)
        scaleFastAction.setData(2)

        scaleSmoothAction.setChecked(True)
        self.scaleSettingGroup.triggered.connect(self.changeScaleSetting)
        scaleSettingsMenu.addActions(self.scaleSettingGroup.actions())

        settingsMenu.addAction("Change Background Color...", self.changeBGColor)

        layout.setMenuBar(menubar)
        # Don't overwrite Krita's application menubar on macOS.
        menubar.setNativeMenuBar(False)

        # Tab bar
        self.tabWidget = QTabWidget(self)
        self.tabWidget.setTabsClosable(True)
        self.tabWidget.tabCloseRequested.connect(self.closeRequestedTab)
        self.tabWidget.setMovable(True)
        self.tabWidget.setDocumentMode(True)
        self.tabWidget.currentChanged.connect(self.checkCorrectFitSetting)
        self.tabWidget.currentChanged.connect(self.checkCorrectScaleSetting)
        layout.addWidget(self.tabWidget)

        self.filter = generateFiletypeFilter()

    # Menu functions
    def openImage(self, filePath=False):
        self.addTab()
        self.tabWidget.setCurrentIndex(self.tabWidget.count()-1)
        self.loadImage(filePath)

    def loadImage(self, filePath=False):
        # Make sure there's a tab open first
        if self.tabWidget.count() == 0:
            self.addTab()

        # Attempt to load supported formats,
        # then return nothing if it's not valid
        if not filePath:
            filePath, _filter = QFileDialog.getOpenFileName(None, "Open an image", filter=self.filter, directory=self.currentFolder)
            self.setCurrentFolder(QFileDialog().directoryUrl().toLocalFile())
            if not filePath:
                return
        reader = QImageReader(filePath)
        # Automatically use rotation metadata (typically found in photographs)
        reader.setAutoTransform(True)
        image = reader.read()
        if image.isNull():
            return
        
        tabIdx = self.tabWidget.currentIndex()
        tab = self.tabWidget.widget(tabIdx)
        tab.setImage(image)
        tab.setFit(True)
        # Label the tab with the filename (sans path),
        # and tooltip with full path
        self.tabWidget.setTabText(tabIdx, QFileInfo(filePath).fileName())
        self.tabWidget.setTabToolTip(tabIdx, filePath)

    def setCurrentFolder(self, folder):
        self.currentFolder = folder
        self.currentFolderChanged.emit(self.currentFolder)

    def addTab(self):
        tab = ReferenceViewWidget(self.tabWidget)
        self.tabWidget.addTab(tab, "Empty")
        for action in self.fitSettingGroup.actions():
            if action.isChecked():
                tab.setFitSetting(action.data())
        for action in self.scaleSettingGroup.actions():
            if action.isChecked():
                tab.setScaleSetting(action.data())

    def closeTab(self):
        idx = self.tabWidget.currentIndex()
        self.closeRequestedTab(idx)

    def closeRequestedTab(self, idx):
        tab = self.tabWidget.widget(idx)
        if tab:
            self.tabWidget.removeTab(idx)
            tab.close()

    def closeAllTabs(self):
       while True:
            idx = self.tabWidget.currentIndex()
            if idx == -1:
                return
            self.closeRequestedTab(idx)

    def closeTabsLeft(self):
       while True:
            idxLeft = self.tabWidget.currentIndex() - 1
            if not self.tabWidget.widget(idxLeft):
                return
            self.closeRequestedTab(idxLeft)

    def closeTabsRight(self):
       while True:
            idxRight = self.tabWidget.currentIndex() + 1
            if not self.tabWidget.widget(idxRight):
                return
            self.closeRequestedTab(idxRight)

    def changeBGColor(self):
        tab = self.tabWidget.currentWidget()
        if tab:
            tab.changeBGColor()

    # Drag and drop support
    def dragEnterEvent(self, event):
        if event.mimeData().hasUrls():
            event.acceptProposedAction()

    def dropEvent(self, event):
        filePaths = event.mimeData().urls()
        # for now, always open in new tab
        for path in filePaths:
            # toLocalFile removes "file:///" on Windows
            # and "file://" on other OSes
            self.openImage(path.toLocalFile())

    def changeFitSetting(self, action):
        tab = self.tabWidget.currentWidget()
        if tab:
            tab.setFitSetting(action.data())

    def checkCorrectFitSetting(self):
        tab = self.tabWidget.currentWidget()
        if not tab:
            return
        for action in self.fitSettingGroup.actions():
            if action.data() == tab.fitSetting:
                action.setChecked(True)

    def changeScaleSetting(self, action):
        tab = self.tabWidget.currentWidget()
        if tab:
            tab.setScaleSetting(action.data())

    def checkCorrectScaleSetting(self):
        tab = self.tabWidget.currentWidget()
        if not tab:
            return
        for action in self.scaleSettingGroup.actions():
            if action.data() == tab.scalingMode:
                action.setChecked(True)

# Generate the formats filter for the file dialog.
def generateFiletypeFilter():
    # Ask QImage what files it can load.
    # With Krita, this will return more formats than standard Qt.
    imgFormats = QImageReader.supportedImageFormats()

    formatList = []
    filterList = []
    db = QMimeDatabase()

    for formatBytes in imgFormats:
        # convert QByteArray to string and prepend "*."
        formatList.append(f"*.{str(formatBytes, 'utf-8')}")

    for format in formatList:
        formatDesc = db.mimeTypeForFile(format).comment()
        # Some formats (camera raw) don't have proper entries, so hide those.
        # They're still listed in "All supported formats".
        if formatDesc != "unknown":
            # "Krita document (*.kra)", etc
            filterList.append(f"{formatDesc} ({format})")

    formatAllString = " ".join(formatList)
    # Alphabetical by description,
    # then "All supported formats (*.bmp *.kra *.png ...)" first.
    filterList.sort()
    filterList.insert(0, f"All supported formats ({formatAllString})")

    return ";;".join(filterList)
