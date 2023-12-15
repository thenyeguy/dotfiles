local wezterm = require("wezterm")
local config = {}

--
-- Color scheme
config.color_scheme = "Gruvbox Dark (Gogh)"

--
-- Font config
config.font = wezterm.font("JetBrains Mono")
config.font_rules = {
    {
        intensity = "Bold",
        font = wezterm.font({ family = "JetBrains Mono Bold" }),
    },
}
config.freetype_load_target = "Light"
config.underline_thickness = "1pt"

--
-- Editor appearance
config.hide_tab_bar_if_only_one_tab = true
config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }
config.window_padding = {
  left = "0cell",
  right = "0cell",
  top = "0.0cell",
  bottom = "0cell",
}

--
-- Keybindings
local action = wezterm.action
config.keys = {
    -- App management
    { key="h", mods="CMD|SHIFT", action=action.HideApplication },
    -- Split management
    { key="s", mods="CMD", action=action.SplitVertical },
    { key="s", mods="CMD|SHIFT", action=action.SplitHorizontal },
    { key="w", mods="CMD", action=action.CloseCurrentPane { confirm=false } },
    { key="w", mods="CMD|SHIFT", action=action.CloseCurrentTab { confirm=true } },
    -- Pane navigation
    { key="[", mods="CMD", action=action.ActivatePaneDirection "Prev" },
    { key="]", mods="CMD", action=action.ActivatePaneDirection "Next" },
    { key="h", mods="CMD", action=action.ActivatePaneDirection "Left" },
    { key="j", mods="CMD", action=action.ActivatePaneDirection "Down" },
    { key="k", mods="CMD", action=action.ActivatePaneDirection "Up" },
    { key="l", mods="CMD", action=action.ActivatePaneDirection "Right" },
    { key="LeftArrow",  mods="CMD", action=action.ActivatePaneDirection "Left" },
    { key="DownArrow",  mods="CMD", action=action.ActivatePaneDirection "Down" },
    { key="UpArrow",    mods="CMD", action=action.ActivatePaneDirection "Up" },
    { key="RightArrow", mods="CMD", action=action.ActivatePaneDirection "Right" },
}

return config
