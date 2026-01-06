from .mimvoid_scripts import MimvoidScripts


# And add the extension to Krita's list of extensions:
ki = Krita.instance()

# Instantiate your class:
extension = MimvoidScripts(parent=ki)
ki.addExtension(extension)
