from krita import Extension, Krita, Node, InfoObject, Selection


ID = "pykrita_mimvoid_scripts"


class MimvoidScripts(Extension):
    def __init__(self, parent):
        super().__init__(parent)

    def setup(self):
        """Executed at Krita's startup"""
        pass

    def createActions(self, window):
        app = Krita.instance()

        setup = window.createAction(f"{ID}_setup", "Setup Layers", "tools")
        setup.setIcon(app.icon("paintLayer"))
        setup.triggered.connect(self.setup_layers)

        render = window.createAction(f"{ID}_render", "Add Render Layers", "tools")
        render.setIcon(app.icon("wheel-light"))
        render.triggered.connect(self.add_render)

        noise = window.createAction(f"{ID}_noise", "Noise", "tools")
        noise.setIcon(app.icon("spraybrush"))
        noise.triggered.connect(self.add_noise)

    # Helper functions
    def create_layer(self, name: str, kind: str = "paintLayer") -> Node:
        doc = Krita.instance().activeDocument()
        return doc.createNode(name, kind)

    def create_layers(self, names: list[str], kind: str = "paintLayer") -> list[Node]:
        result = map(lambda i: self.create_layer(i, kind), names)
        return list(result)

    # Actions
    def setup_layers(self):
        doc = Krita.instance().activeDocument()
        root = doc.rootNode()

        # Sketch layers at root level
        layers = self.create_layers(["Sketch 1", "Sketch 2"])

        for i in layers:
            root.addChildNode(i, None)

        # Background group layer
        bg = doc.createGroupLayer("Background")
        root.addChildNode(bg, None)

        bg_layer = self.create_layer("Background")
        bg.addChildNode(bg_layer, None)

        # Character group layer
        char = doc.createGroupLayer("Character")
        root.addChildNode(char, None)

        char_children = ["Lineart", "Highlight"]
        char_layer_children = self.create_layers(char_children)
        for i in char_layer_children:
            char.addChildNode(i, None)

        # Colorize mask for lineart layer
        color = doc.createColorizeMask("Base")
        color.setLimitToDeviceBounds(True)

        doc.nodeByName("Lineart").addChildNode(color, None)

        # Top layers
        watermark = self.create_layer("Watermark")
        root.addChildNode(watermark, None)

        # Change active node
        doc.refreshProjection()
        doc.setActiveNode(doc.nodeByName("Sketch 1"))

    def add_render(self):
        doc = Krita.instance().activeDocument()

        # Find the currently selected node and its parent
        base = doc.activeNode()
        parent = base.parentNode()

        # Define layers
        renders = self.create_layers(["Light", "Shade 3", "Shade 2", "Shade"])

        # Set blending modes
        renders[0].setBlendingMode("hard_light")

        for i in renders[1:]:
            i.setBlendingMode("multiply")

        # Add the layers above the active node
        for i in renders:
            i.setInheritAlpha(True)
            parent.addChildNode(i, base)

        doc.refreshProjection()

    def add_noise(self):
        doc = Krita.instance().activeDocument()
        root = doc.rootNode()

        # Create a black fill layer
        i = InfoObject()
        i.setProperty("color", "#000")

        s = Selection()
        s.select(0, 0, doc.width(), doc.height(), 255)

        layer = doc.createFillLayer("Noise", "color", i, s)

        # Set layer properties
        layer.setBlendingMode("soft_light")
        layer.setOpacity(102)  # 40% opacity

        root.addChildNode(layer, None)

        # Filter with random noise
        target = doc.nodeByName("Noise")

        noise = Krita.instance().filter("noise")
        noise.apply(target, 0, 0, doc.width(), doc.height())

        doc.refreshProjection()
