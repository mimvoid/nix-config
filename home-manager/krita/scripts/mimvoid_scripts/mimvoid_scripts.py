from krita import Extension, Krita, Node, InfoObject, Selection
from collections.abc import Generator, Iterable


# ---------------- #
# Helper functions #
# ---------------- #


def create_layer(doc, name: str, kind="paintLayer") -> Node:
    return doc.createNode(name, kind)

def create_layers(doc, names: Iterable[str], kind="paintLayer") -> Generator:
    return (doc.createNode(name, kind) for name in names)


# ------- #
# Actions #
# ------- #

def setup_layers():
    doc = Krita.instance().activeDocument()
    if not doc:
        return

    sketch1 = create_layer(doc, "Sketch 1")
    sketch2 = create_layer(doc, "Sketch 2")

    # Background
    bg = doc.createGroupLayer("Background")
    bg.addChildNode(create_layer(doc, "Background"), None)

    # Character group layer
    char = doc.createGroupLayer("Character")

    lineart = create_layer(doc, "Lineart")
    highlight = create_layer(doc, "Highlight")
    char.setChildNodes([lineart, highlight])

    # Colorize mask for lineart layer
    color = doc.createColorizeMask("Base")
    color.setLimitToDeviceBounds(True)
    lineart.addChildNode(color, None)

    children = [
        sketch1,
        sketch2,
        bg,
        char,
        create_layer(doc, "Watermark")
    ]

    # Add all layers
    root = doc.rootNode()
    root.setChildNodes(root.childNodes() + children)

    # Change active node
    doc.waitForDone()
    doc.setActiveNode(sketch1)

    doc.refreshProjection()

def add_render():
    doc = Krita.instance().activeDocument()
    if not doc:
        return

    # Find the currently selected node and its parent
    base = doc.activeNode()
    parent = base.parentNode()

    # Define layers
    renders = create_layers(doc, ["Light", "Shade 3", "Shade 2", "Shade"])

    for i, render in enumerate(renders):
        render.setBlendingMode("hard_light" if i == 0 else "multiply")
        render.setInheritAlpha(True)
        parent.addChildNode(render, base)

    doc.refreshProjection()

def add_noise():
    ki = Krita.instance()
    doc = ki.activeDocument()
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
    noise = ki.filter("noise")
    noise.apply(layer, 0, 0, doc.width(), doc.height())

    doc.refreshProjection()


def number_layers():
    window = Krita.instance().activeWindow()
    if not window:
        return

    view = window.activeView()
    if view == 0:
        return

    for i, node in enumerate(view.selectedNodes(), start=1):
        # Check if the split name is not empty
        if split_name := node.name().split():
            split_name[0] = str(i)
            node.setName(" ".join(split_name))



class MimvoidScripts(Extension):
    def __init__(self, parent):
        super().__init__(parent)

    def setup(self):
        """Executed at Krita's startup"""
        pass

    def createActions(self, window):
        ki = Krita.instance()
        prefix = "pykrita_mimvoid_scripts"

        setup = window.createAction(prefix + "_setup", "Setup Layers", "tools")
        setup.setIcon(ki.icon("paintLayer"))
        setup.triggered.connect(setup_layers)

        render = window.createAction(prefix + "_render", "Add Render Layers", "tools")
        render.setIcon(ki.icon("wheel-light"))
        render.triggered.connect(add_render)

        noise = window.createAction(prefix + "_noise", "Noise", "tools")
        noise.setIcon(ki.icon("spraybrush"))
        noise.triggered.connect(add_noise)

        number = window.createAction(prefix + "_number_layers", "Number layers", "tools")
        number.setIcon(ki.icon("view-list-text"))
        number.triggered.connect(number_layers)
