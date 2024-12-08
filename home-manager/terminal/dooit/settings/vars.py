from dooit.ui.api import DooitAPI
from dooit.api import manager, Workspace


def show_workspace_children(api: DooitAPI):
    manager.connect()
    workspaces = Workspace.all()

    workspace_tree = api.vars.workspaces_tree

    for i in workspaces:
        workspace_tree.expanded_nodes[i.uuid] = True
