const hyprland = await Service.import("hyprland");

const activeId = hyprland.active.workspace.bind("id");

const workspaces = hyprland.bind("workspaces").as((ws) =>
  ws.map(({ id }) =>
    Widget.Button({
      on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
      child: Widget.Label(`${id}`),
      class_name: activeId.as((i) => `${i === id ? "focused" : ""}`),
      cursor: "pointer",
    }),
  ),
);

export default () =>
  Widget.Box({
    class_name: "workspaces",
    children: workspaces,
  });
