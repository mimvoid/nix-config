local M = {}
local H = {}

---@class Config
---@field col { active_border: string, inactive_border: string, shadow: string }
---@field cursor { size: string, name: string }

---@param cfg Config
function M.setup(cfg)
  hl.on("hyprland.start", H.on_start)
  H.set_bindings()

  hl.config({
    xwayland = { force_zero_scaling = true },

    general = {
      layout = "dwindle",
      gaps_in = 4,
      gaps_out = { top = 4, right = 12, bottom = 12, left = 12 },
      border_size = 1,
      resize_on_border = true,
      ["col.active_border"] = cfg.col.active_border,
      ["col.inactive_border"] = cfg.col.inactive_border,
    },

    decoration = {
      rounding = 4,
      active_opacity = 0.85,
      inactive_opacity = 0.7,
      fullscreen_opacity = 1.0,

      shadow = {
        enabled = true,
        offset = { 2, 2 },
        range = 4,
        render_power = 1,
      },

      blur = {
        enabled = true,
        xray = true,
        size = 1,
        passes = 2,
        contrast = 1.2,
        noise = 0.02,
      },
    },

    ecosystem = {
      no_update_news = true,
      no_donation_nag = true,
    },

    misc = {
      force_default_wallpaper = 0,
      disable_hyprland_logo = true,
      disable_splash_rendering = true,
    },
  })

  H.set_env(cfg.cursor)
  H.set_window_rules()
  H.set_layer_rules()
  H.set_animations()
end

function H.on_start()
  hl.exec_cmd("mega-cmd-server")
  hl.exec_cmd("fcitx -d")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("ags run")
  hl.exec_cmd("nm-applet --indicator")
end

function H.set_animations()
  local beziers = {
    overshoot = { { 0.05, 0.9 }, { 0.1, 1.1 } },
    overshootMini = { { 0.1, 0.9 }, { 0.1, 1.02 } },
    easeInOutBack = { { 0.6, -0.1 }, { 0.3, 1.1 } },
  }
  for name, points in pairs(beziers) do
    hl.curve(name, { type = "bezier", points = points })
  end

  local animations = {
    windows = { speed = 3, bezier = "overshoot" },
    windowsOut = { speed = 2, style = "popin 80%" },
    layersIn = { speed = 5, bezier = "overshoot" },
    border = { speed = 3 },
    borderangle = { speed = 2 },
    fade = { speed = 2 },
    workspaces = { speed = 2, style = "fade" },
  }

  for leaf, props in pairs(animations) do
    hl.animation({
      leaf = leaf,
      enabled = true, 
      speed = props.speed,
      bezier = props.bezier or "default",
      style = props.style,
    })
  end
end

function H.set_window_rules()
  hl.window_rule({ match = { class = "*astal" }, float = true })
  hl.window_rule({ match = { class = "tauon" }, workspace = 9 })

  local high_opacity = {
    "Anki",
    "kitty",
    ".*rnote",
    ".*zathura",
  }
  local focused_opaque = {
    "FFPWA.*",
    "firefox",
    "FreeTube",
    "Godot",
    "org.godotengine.Editor",
    "zen",
  }
  local opaque = {
    ".*digikam",
    ".*Inkscape",
    "krita",
    "org.kde.krita",
    "virt-manager",
  }

  for i = 1, #high_opacity do
    hl.window_rule({ match = { class = high_opacity[i] }, opacity = "0.9 override 0.75 override" })
  end
  for i = 1, #focused_opaque do
    hl.window_rule({ match = { class = focused_opaque[i] }, opacity = "1.0 override 0.85 override" })
  end
  for i = 1, #opaque do
    hl.window_rule({ match = { class = opaque[i] }, opaque = true })
  end

  -- For some Krita plugin windows.
  hl.window_rule({
    match = { class = "org.kde.krita", float = true },
    border_size = 0,
    xray = false,
    no_initial_focus = true,
    no_blur = true,
    no_shadow = true,
  })

  -- Shimejis
  hl.window_rule({
    match = { class = "Shijima-Qt", float = true },
    border_size = 0,
    rounding = 0,
    decorate = false,
    opaque = true,
    xray = false,
    no_initial_focus = true,
    no_blur = true,
    no_shadow = true,
  })
end

function H.set_layer_rules()
  hl.layer_rule({
    match = { namespace = "launcher" },
    blur = true,
    ignore_alpha = 1,
    no_anim = true,
    xray = false,
  })
end

function H.set_bindings()
  -- Resize windows with left mouse button
  hl.bind("SUPER + mouse:272", hl.dsp.window.resize(), { mouse = true })
  -- Move windows with right mouse button
  hl.bind("SUPER + mouse:273", hl.dsp.window.drag(), { mouse = true })

  hl.bind("SUPER + F", hl.dsp.window.fullscreen())
  hl.bind("SUPER + Q", hl.dsp.window.close())

  -- Workspaces
  for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
  end

  local vim_motions = {
    { key = "H", direction = "l", x = -10, y = 0 },
    { key = "L", direction = "r", x = 10, y = 0 },
    { key = "K", direction = "u", x = 0, y = -10 },
    { key = "J", direction = "d", x = 0, y = 10 },
  }
  for i = 1, #vim_motions do
    local dir = vim_motions[i]

    -- Switch focus
    hl.bind("SUPER + " .. dir.key, hl.dsp.focus({ direction = dir.direction }))

    -- Move window
    hl.bind("SUPER + SHIFT + " .. dir.key, hl.dsp.window.move({ direction = dir.direction }))

    -- Repeated resize
    hl.bind(
      "SUPER + ALT + " .. dir.key,
      hl.dsp.window.resize({ x = dir.x, y = dir.y, relative = true }),
      { repeating = true }
    )
  end

  -- Application bindings
  hl.bind("SUPER + Return", hl.dsp.exec_cmd("kitty"))
  hl.bind("SUPER + E", hl.dsp.exec_cmd("thunar"))
  hl.bind("SUPER + space", hl.dsp.exec_cmd("fuzzel"))
  hl.bind("SUPER + W", hl.dsp.exec_cmd("firefox"))
  hl.bind("SUPER + D", hl.dsp.exec_cmd("kitty dooit"))
  hl.bind("SUPER + M", hl.dsp.exec_cmd("tauon"))
  hl.bind("SUPER + A", hl.dsp.exec_cmd("krita"))
  hl.bind("SUPER + O", hl.dsp.exec_cmd("obsidian"))
  hl.bind("SUPER + N", hl.dsp.exec_cmd("networkmanager_dmenu"))

  hl.bind("SUPER + C", hl.dsp.exec_cmd("hyprpicker --autocopy --format=hex"))

  local hyprshot = {
    output = "Print",
    window = "SUPER + Print",
    region = "SUPER + SHIFT + Print",
  }
  for mode, keys in pairs(hyprshot) do
    hl.bind(keys, hl.dsp.exec_cmd("hyprshot -m " .. mode .. "--freeze -o ~/Pictures/Screenshots -f $(date +%F_%H-%M-%S).png"))
  end

  -- AGS
  hl.bind("SUPER + SHIFT + Q", hl.dsp.exec_cmd("ags toggle 'session'"))

  -- I use this binding to manually reload config changes.
  -- Having AGS reload also serves as a good visual indicator.
  -- You can replace it with any bar (e.g. waybar) you like.
  hl.bind("SUPER + R", hl.dsp.exec_cmd("hyprctl reload config-only ; ags quit && ags run"))
end

function H.set_env(cursor)
  hl.env("GDK_BACKEND", "wayland,x11,*")
  hl.env("GDK_scale", "1")

  hl.env("QT_QPA_PLATFORM", "wayland;xcb")
  hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
  hl.env("QT_QPA_scale", "2")
  hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

  -- Enable Ozone Wayland for electron apps
  hl.env("NIXOS_OZONE_WL", "1")
  hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

  hl.env("MOZ_ENABLE_WAYLAND", "1")
  hl.env("ANKI_WAYLAND", "1")

  -- Fcitx adjustments
  hl.env("QT_IM_MODULES", "wayland;fcitx")

  hl.env("XCURSOR_SIZE", cursor.size)
  hl.env("XCURSOR_THEME", cursor.theme)
  hl.env("HYPRCURSOR_SIZE", cursor.size)
  hl.env("HYPRCURSOR_THEME", cursor.theme)
end

return M
