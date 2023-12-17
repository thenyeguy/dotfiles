local wezterm = require("wezterm")
local config = {}

--
-- Color scheme
config.color_scheme = "Gruvbox Dark (Gogh)"
config.colors = {
    tab_bar = {
        active_tab = { fg_color="#ddd", bg_color='#444', intensity="Bold" },
    },
}

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
config.inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 }
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_padding = { top="3pt", bottom="3pt", left="0pt", right="0pt" }
config.use_resize_increments = true

--
-- Keybindings
local action = wezterm.action
local RenameTabInteractive = wezterm.action.PromptInputLine({
    description = wezterm.format({{Attribute={Intensity="Bold"}}, {Text="Rename tab:"}}),
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:active_tab():set_title(line)
      end
    end),
})

config.keys = {
    -- App management
    { key="h", mods="CMD|SHIFT", action=action.HideApplication },
    { key="r", mods="CMD|SHIFT", action=action.ReloadConfiguration },
    -- Tab management
    { key="r", mods="CMD", action=RenameTabInteractive },
    { key="[", mods="CMD|OPT", action=action.MoveTabRelative(-1) },
    { key="]", mods="CMD|OPT", action=action.MoveTabRelative(1) },
    -- Split management
    { key="s", mods="CMD", action=action.SplitVertical },
    { key="s", mods="CMD|SHIFT", action=action.SplitHorizontal },
    { key="w", mods="CMD", action=action.CloseCurrentPane { confirm=false } },
    { key="w", mods="CMD|SHIFT", action=action.CloseCurrentTab { confirm=true } },
    { key="z", mods="CMD", action=action.TogglePaneZoomState },
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
