from krita import Extension, Krita, Node, InfoObject, Selection
from collections.abc import Generator, Iterable


KI = Krita.instance()
ID = "pykrita_mimvoid_scripts"


class MimvoidScripts(Extension):
    def __init__(self, parent):
        super().__init__(parent)

    def setup(self):
        """Executed at Krita's startup"""
        pass

    def createActions(self, window):
        setup = window.createAction(f"{ID}_setup", "Setup Layers", "tools")
        setup.setIcon(KI.icon("paintLayer"))
        setup.triggered.connect(self.setup_layers)

        render = window.createAction(f"{ID}_render", "Add Render Layers", "tools")
        render.setIcon(KI.icon("wheel-light"))
        render.triggered.connect(self.add_render)

        noise = window.createAction(f"{ID}_noise", "Noise", "tools")
        noise.setIcon(KI.icon("spraybrush"))
        noise.triggered.connect(self.add_noise)

    # ---------------- #
    # Helper functions #
    # ---------------- #

    @staticmethod
    def create_layer(doc, name: str, kind="paintLayer") -> Node:
        return doc.createNode(name, kind)

    @staticmethod
    def create_layers(doc, names: Iterable[str], kind="paintLayer") -> Generator:
        return (doc.createNode(name, kind) for name in names)

    # ------- #
    # Actions #
    # ------- #

    def setup_layers(self):
        doc = KI.activeDocument()
        if not doc:
            return

        root = doc.rootNode()

        # Sketch layers at root level
        sketch1 = MimvoidScripts.create_layer(doc, "Sketch 1")
        sketch2 = MimvoidScripts.create_layer(doc, "Sketch 2")
        for i in (sketch1, sketch2):
            root.addChildNode(i, None)

        # Background group layer
        bg = doc.createGroupLayer("Background")
        root.addChildNode(bg, None)

        bg_layer = MimvoidScripts.create_layer(doc, "Background")
        bg.addChildNode(bg_layer, None)

        # Character group layer
        char = doc.createGroupLayer("Character")
        root.addChildNode(char, None)

        lineart = MimvoidScripts.create_layer(doc, "Lineart")
        highlight = MimvoidScripts.create_layer(doc, "Highlight")
        for i in (lineart, highlight):
            char.addChildNode(i, None)

        # Colorize mask for lineart layer
        color = doc.createColorizeMask("Base")
        color.setLimitToDeviceBounds(True)

        lineart.addChildNode(color, None)

        # Top layers
        watermark = MimvoidScripts.create_layer(doc, "Watermark")
        root.addChildNode(watermark, None)

        # Change active node
        doc.waitForDone()
        doc.setActiveNode(sketch1)

        doc.refreshProjection()

    def add_render(self):
        doc = KI.activeDocument()
        if not doc:
            return

        # Find the currently selected node and its parent
        base = doc.activeNode()
        parent = base.parentNode()

        # Define layers
        renders = MimvoidScripts.create_layers(
            doc, ["Light", "Shade 3", "Shade 2", "Shade"]
        )

        for i, render in enumerate(renders):
            if i == 0:
                render.setBlendingMode("hard_light")
            else:
                render.setBlendingMode("multiply")

            render.setInheritAlpha(True)
            parent.addChildNode(render, base)

        doc.refreshProjection()

    def add_noise(self):
        doc = KI.activeDocument()
        if not doc:
            return

        # Create a black fill layer
        info = InfoObject()
        info.setProperty("color", "#000")

        selection = Selection()
        selection.select(0, 0, doc.width(), doc.height(), 255)

        layer = doc.createFillLayer("Noise", "color", info, selection)
        doc.rootNode().addChildNode(layer, None)

        # Set layer properties
        layer.setBlendingMode("soft_light")
        layer.setOpacity(102)  # 40% opacity

        # Filter with random noise
        noise = KI.filter("noise")
        noise.apply(layer, 0, 0, doc.width(), doc.height())

        doc.refreshProjection()
