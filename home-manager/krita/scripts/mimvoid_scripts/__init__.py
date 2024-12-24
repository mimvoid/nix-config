from .mimvoid_scripts import MimvoidScripts


# And add the extension to Krita's list of extensions:
app = Krita.instance()

# Instantiate your class:
extension = MimvoidScripts(parent=app)
app.addExtension(extension)
