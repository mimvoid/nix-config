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

from PyQt5.QtCore import Qt, QPointF, QRectF
from PyQt5.QtGui import QImage, QPixmap, QPalette, QPainter
from PyQt5.QtWidgets import QWidget, QHBoxLayout, QVBoxLayout, \
                            QSpinBox, QToolButton, QPushButton, \
                            QColorDialog, QDialog, \
                            QGraphicsView, QGraphicsScene, QGraphicsPixmapItem, \
                            qApp
from math import radians, sin, cos
 
# Zoom percent constants
MAX_ZOOM = 800
MIN_ZOOM = 10
ZOOM_STEP = 10

IS_KRITA = __name__ != "reference_view_widget"

useAngleSelector = False

if IS_KRITA:
    (majorVer, minorVer, _tmp) = Krita.version().split(".")

    # AngleSelector is available in 5.3
    useAngleSelector = int(majorVer) >= 5 and int(minorVer) >= 3
    if useAngleSelector:
        from krita import AngleSelector

    from krita import ManagedColor


class ImageView(QGraphicsView):
    def __init__(self, parent=None, flags=None):
        super().__init__(parent)

    # Just here to give the input events to the correct place
    def keyReleaseEvent(self, event):
        self.parent().keyReleaseEvent(event)
    def mouseMoveEvent(self, event):
        self.parent().mouseMoveEvent(event)
    def mouseReleaseEvent(self, event):
        self.parent().mouseReleaseEvent(event)

    def getColorAt(self, pos):
        paintDevice = QImage(self.size(), QImage.Format_ARGB32)
        painter = QPainter(paintDevice)
        self.render(painter)

        # End painter, otherwise:
        # "QPaintDevice: Cannot destroy paint device that is being painted"
        painter.end()

        return paintDevice.pixelColor(pos)

class ReferenceViewWidget(QWidget):

    def __init__(self, parent=None, flags=None):

        super().__init__(parent)
        self.setAttribute(Qt.WA_DeleteOnClose)
        layout = QVBoxLayout()
        self.setLayout(layout)

        # variables
        self.previous_scale_factor = 1.0
        self.zoomMode = False
        self.panMode = False
        self.rotateMode = False
        self.prevMousePos = False
        self.fitSetting = 1
        self.scalingMode = 1
        self.isSamplingColor = False

        # Layout init:
        # - image
        # Custom class for a hacky way to make sure input events are sent to the right place
        self.view = ImageView(self) #QGraphicsView()
        self.view.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOn)
        self.view.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOn)
        # Disabling interactive mode prevents it from taking the drop events
        self.view.setInteractive(False)
        self.scene = QGraphicsScene()
        self.view.setScene(self.scene)
        self.imageItem = QGraphicsPixmapItem()
        self.scene.addItem(self.imageItem)

        # For consistency with previous plugin behavior;
        # otherwise defaults to the base color.
        self.setBackgroundColor(qApp.palette().window().color())

        # - zoom level
        self.zoomSpinBox = QSpinBox()
        self.zoomSpinBox.setRange(MIN_ZOOM, MAX_ZOOM)
        self.zoomSpinBox.setSingleStep(ZOOM_STEP)
        self.zoomSpinBox.setSuffix("%")
        self.zoomSpinBox.setValue(99) # workaround to make sure 100% mode gets initialized properly
        self.zoomSpinBox.setToolTip("Zoom")
        self.zoomSpinBox.valueChanged.connect(self.reloadTransforms)

        # - page fit status
        self.fitButton = QToolButton()
        if IS_KRITA:
            self.fitButton.setIcon(Krita.instance().icon("zoom-fit"))
        else:
            self.fitButton.setText("F")
        self.fitButton.setToolTip("Fit to page")
        self.fitButton.setCheckable(True)
        self.fitButton.setChecked(False)
        self.fitButton.toggled.connect(self.enactFit)

        # - hmirrored status
        self.hMirrorButton = QToolButton()
        if IS_KRITA:
            self.hMirrorButton.setIcon(Krita.instance().icon("transform_icons_mirror_x"))
        else:
            self.hMirrorButton.setText("H")
        self.hMirrorButton.setToolTip("Horizontal mirroring")
        self.hMirrorButton.setCheckable(True)
        self.hMirrorButton.setChecked(False)
        self.hMirrorButton.toggled.connect(self.reloadTransforms)

        # - vmirrored status
        self.vMirrorButton = QToolButton()
        if IS_KRITA:
            self.vMirrorButton.setIcon(Krita.instance().icon("transform_icons_mirror_y"))
        else:
            self.vMirrorButton.setText("V")
        self.vMirrorButton.setToolTip("Vertical mirroring")
        self.vMirrorButton.setCheckable(True)
        self.vMirrorButton.setChecked(False)
        self.vMirrorButton.toggled.connect(self.reloadTransforms)

        # - rotate status
        if useAngleSelector:
            self.rotateSelector = AngleSelector()
            self.rotateSelector.setFlipOptionsMode("ContextMenu")
            self.rotateSelector.angleChanged.connect(self.reloadTransforms)
        else:
            self.rotateSpinBox = QSpinBox()
            self.rotateSpinBox.setRange(0,360)
            self.rotateSpinBox.setSingleStep(90)
            self.rotateSpinBox.setSuffix("°")
            self.rotateSpinBox.setValue(0)
            self.rotateSpinBox.setWrapping(True)
            self.rotateSpinBox.setToolTip("Rotation")
            self.rotateSpinBox.valueChanged.connect(self.enactRotation)

        self.centerButton = QPushButton()
        self.centerButton.setToolTip("Center view")
        self.centerButton.pressed.connect(self.centerScrollbars)
        self.view.horizontalScrollBar().rangeChanged.connect(self.toggleEnableCenterScroll)
        self.view.verticalScrollBar().rangeChanged.connect(self.toggleEnableCenterScroll)
        self.centerButton.setEnabled(False)

        # - color picker
        self.colorSamplerButton = QToolButton()
        if IS_KRITA:
            self.colorSamplerButton.setIcon(Krita.instance().icon("krita_tool_color_sampler"))
        else:
            self.colorSamplerButton.setText("C")
        self.colorSamplerButton.setToolTip("Sample color from image")
        self.colorSamplerButton.setCheckable(True)
        self.colorSamplerButton.setChecked(False)
        self.colorSamplerButton.toggled.connect(self.toggleSampleColor)
        self.colorSamplerButton.setEnabled(False)

        # add to layout
        self.view.setCornerWidget(self.centerButton)
        layout.addWidget(self.view)
        self.view.setVisible(True)
        #
        toolLayout = QHBoxLayout()
        toolLayout.addWidget(self.zoomSpinBox, stretch=1)
        toolLayout.addWidget(self.fitButton)
        toolLayout.addWidget(self.hMirrorButton)
        toolLayout.addWidget(self.vMirrorButton)
        toolLayout.addWidget(self.rotateSelector.widget() if useAngleSelector else self.rotateSpinBox, stretch=0)
        toolLayout.addWidget(self.colorSamplerButton)
        layout.addLayout(toolLayout)

        self.toggleButtonsEnabled(False)

    def zoomBy(self, deltaX, deltaY):
        currentZoom = self.zoomSpinBox.value()
        viewSize = self.view.maximumViewportSize()
        zoomX = 100 * deltaX / viewSize.width()
        zoomY = 100 * deltaY / viewSize.height()
        # Inverted: Mouse up/left zooms in, down/right zooms out
        self.setZoom(currentZoom - int(zoomX + zoomY))
    def panBy(self, deltaX, deltaY):
        hBar = self.view.horizontalScrollBar()
        vBar = self.view.verticalScrollBar()
        viewSize = self.view.maximumViewportSize()
        # Inverted: Mouse up/left moves scrollbar to the bottom/right
        hBar.setValue(hBar.value() - int(deltaX / viewSize.width() * hBar.maximum()))
        vBar.setValue(vBar.value() - int(deltaY / viewSize.height() * vBar.maximum()))
    def rotateBy(self, deltaX, deltaY):
        currentRotation = self.rotation()
        # From 90 to 270, increasing = left instead of right
        if 90 <= currentRotation < 270:
            deltaX *= -1
        # From 180 to 360, increasing = up instead of down
        if 180 <= currentRotation < 360:
            deltaY *= -1
        self.setRotation(currentRotation + deltaX + deltaY)

    def keyPressEvent(self, event):
        if event.key() == Qt.Key_Space:
            if event.modifiers() == Qt.NoModifier:
                self.panMode = True
            elif event.modifiers() == Qt.ControlModifier:
                self.zoomMode = True
            elif event.modifiers() == Qt.ShiftModifier:
                self.rotateMode = True

        return QWidget.keyPressEvent(self, event)

    def keyReleaseEvent(self, event):
        if event.key() == Qt.Key_Space:
            self.zoomMode = False
            self.panMode = False
            self.rotateMode = False
            self.prevMousePos = False

        return QWidget.keyReleaseEvent(self, event)

    def mouseMoveEvent(self, event):
        if self.needsMousePos():
            if self.prevMousePos:
                deltaMousePosX = event.pos().x() - self.prevMousePos.x()
                deltaMousePosY = event.pos().y() - self.prevMousePos.y()
                if self.zoomMode:
                    self.zoomBy(deltaMousePosX, deltaMousePosY)
                elif self.panMode:
                    self.panBy(deltaMousePosX, deltaMousePosY)
                elif self.rotateMode:
                    self.rotateBy(deltaMousePosX, deltaMousePosY)
            self.prevMousePos = event.pos()
        elif self.isSamplingColor:
            self.selectColor(self.getColorAt(event.pos()))

    def mouseReleaseEvent(self, event):
        if (self.isSamplingColor):
            self.colorSamplerButton.setChecked(False)
            self.selectColor(self.getColorAt(event.pos()))

    def needsMousePos(self):
        return self.zoomMode or self.panMode or self.rotateMode

    def reloadTransforms(self):
        self.view.resetTransform()
        scale = self.zoomSpinBox.value() / 100
        scaleX = scale if not self.hMirrorButton.isChecked() else -scale
        scaleY = scale if not self.vMirrorButton.isChecked() else -scale
        self.view.rotate(self.rotation())
        self.view.scale(scaleX, scaleY)

        # we don't know if it's fitting the window, unless...
        self.setFit(False)

    def enactFit(self):
        if self.fitButton.isChecked():
            if self.fitSetting == 4:
                self.setZoom(100)
            else:
                self.scaleToFit()
                # ...we flag that it is set to fit afterward
                self.setFit(True)

    def enactRotation(self):
        # Don't try to fit to view while rotating, it just
        # causes a lot of annoying resizes.
        # The user can manually turn it back on when they're done, if they want.
        self.setFit(False)
        self.reloadTransforms()

    def setFitSetting(self, setting):
        self.fitSetting = setting
    def setScaleSetting(self, setting):
        self.scalingMode = setting
        if setting == 1:
            self.imageItem.setTransformationMode(Qt.SmoothTransformation)
        elif setting == 2:
            self.imageItem.setTransformationMode(Qt.FastTransformation)

    def centerScrollbars(self):
        hBar = self.view.horizontalScrollBar()
        vBar = self.view.verticalScrollBar()
        hBar.setValue(int(hBar.maximum()/2))
        vBar.setValue(int(vBar.maximum()/2))

    def toggleEnableCenterScroll(self, min, max):
        hBar = self.view.horizontalScrollBar()
        vBar = self.view.verticalScrollBar()
        if hBar.maximum() == 0 and vBar.maximum() == 0:
            self.centerButton.setEnabled(False)
        else:
            self.centerButton.setEnabled(True)


    def setZoom(self, value):
        self.zoomSpinBox.setValue(value)

    def setFit(self, value):
        self.fitButton.setChecked(value)

    def setImage(self,image=QImage()):
        self.imageItem.setPixmap(QPixmap.fromImage(image))
        self.toggleButtonsEnabled(image != QImage())

    # get the available size and scale it to fit
    def scaleToFit(self):
        if not self.imageItem.pixmap():
            return

        max_x = self.view.maximumViewportSize().width()
        max_y = self.view.maximumViewportSize().height()
        # Need to account for the rotated dimensions
        rotatedRect = self.rotateRect()
        image_x = rotatedRect.width()
        image_y = rotatedRect.height()

        scale_x = max_x/image_x
        scale_y = max_y/image_y
        
        scale = 1
        if self.fitSetting == 1:
            scale = scale_x
            if scale_y < scale_x:
                scale = scale_y
        elif self.fitSetting == 2:
            scale = scale_x
        elif self.fitSetting == 3:
            scale = scale_y

        self.setZoom(int(scale*100))

    def resizeEvent(self, event):
        # if it should fit, resize it
        if not self.fitSetting == 4:
            self.enactFit()


    def toggleButtonsEnabled(self, value):
        self.zoomSpinBox.setEnabled(value)
        self.fitButton.setEnabled(value)
        self.hMirrorButton.setEnabled(value)
        self.vMirrorButton.setEnabled(value)
        (self.rotateSelector.widget() if useAngleSelector else self.rotateSpinBox).setEnabled(value)
        self.colorSamplerButton.setEnabled(value)

    def changeBGColor(self):
        oldColor = self.view.palette().base().color()
        colorPicker = QColorDialog(oldColor)
        colorPicker.currentColorChanged.connect(self.setBackgroundColor)
        result = colorPicker.exec()
        if result == QDialog.Rejected:
            self.setBackgroundColor(oldColor)

    def setBackgroundColor(self, color):
        palette = self.view.palette()
        palette.setColor(QPalette.Base, color)
        self.view.setPalette(palette)

    def setRotation(self, angle):
        if useAngleSelector:
            self.rotateSelector.setAngle(angle)
        else:
            self.rotateSpinBox.setValue(angle)
    def rotation(self):
        if useAngleSelector:
            return self.rotateSelector.angle()
        else:
            return self.rotateSpinBox.value()

    def rotateRect(self):
        rads = radians(self.rotation())
        c = cos(rads)
        s = sin(rads)
        def rotatePt(x, y):
            x2 = x * c - y * s
            y2 = x * s + y * c
            return QPointF(x2, y2)
        # Put 0,0 as the center
        halfWidth = self.imageItem.pixmap().width() / 2
        halfHeight = self.imageItem.pixmap().height() / 2
        pts = [rotatePt(-halfWidth, -halfHeight), rotatePt(halfWidth, -halfHeight),
               rotatePt(-halfWidth, halfHeight), rotatePt(halfWidth, halfHeight)]
        # Make a copy, not a reference...
        smallPt = QPointF(pts[0])
        largePt = QPointF(pts[0])
        for pt in pts[1:]:
            if pt.x() < smallPt.x():
                smallPt.setX(pt.x())
            if pt.y() < smallPt.y():
                smallPt.setY(pt.y())
            if pt.x() > largePt.x():
                largePt.setX(pt.x())
            if pt.y() > largePt.y():
                largePt.setY(pt.y())
        rotatedRect = QRectF(smallPt, largePt)
        # Put back to 0,0 as topleft
        # (unneeded as we are only using the width/height)
        #rotatedRect.translate(-smallPt)

        return rotatedRect

    def toggleSampleColor(self, value):
        self.isSamplingColor = value

    def getColorAt(self, pos):
        return self.view.getColorAt(pos)

    def selectColor(self, color):
        if IS_KRITA:
            color = ManagedColor.fromQColor(color)
            Krita.instance().activeWindow().activeView().setForeGroundColor(color)
        else:
            print("Your color is:", color.name())
