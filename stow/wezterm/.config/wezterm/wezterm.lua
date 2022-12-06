local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    wezterm.log_info(tab.active_pane)
    return {
      { Text = wezterm.nerdfonts.fa_chevron_right .. ' ' .. tab.active_pane.title .. ' ' },
    }
  end
)

return {
  audible_bell = "Disabled",
  color_scheme = "3024 (base16)",
  max_fps = 100,
  font = wezterm.font("FiraCode Nerd Font", {weight="Medium", stretch="Normal", style="Normal"}),
  font_rules = {
    {
      intensity = 'Bold',
      font = wezterm.font("FiraCode Nerd Font", {weight="Bold", stretch="Normal", style="Normal"}),
    },
  },
  font_size = 19.0,
  -- Disable font ligatures
  harfbuzz_features = {'calt=0', 'clig=0', 'liga=0'},

  hide_tab_bar_if_only_one_tab = true,
  inactive_pane_hsb = {
    brightness = 0.85,
  },

  keys = {
    { 
      key = 'p', 
      mods = 'CMD', 
      action = wezterm.action.ShowLauncherArgs { flags = 'FUZZY|TABS|WORKSPACES' },
    },
    { key = 'd', mods = 'ALT', action = wezterm.action.ShowDebugOverlay },

    -- Panes
    {
      key = 'd',
      mods = 'CMD',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'D',
      mods = 'SHIFT|CMD',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'w',
      mods = 'CMD',
      action = wezterm.action.CloseCurrentPane { confirm = true },
    },

    -- Activation
    {
      key = 'h',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Left',
    },
    {
      key = 'l',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Right',
    },
    {
      key = 'k',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Up',
    },
    {
      key = 'j',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Down',
    },
    {
      key = ']',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Next',
    },
    {
      key = '[',
      mods = 'CMD',
      action = act.ActivatePaneDirection 'Prev',
    },

    -- Size
    {
      key = 'H',
      mods = 'SHIFT|CMD',
      action = act.AdjustPaneSize { 'Left', 1 },
    },
    {
      key = 'J',
      mods = 'SHIFT|CMD',
      action = act.AdjustPaneSize { 'Down', 1 },
    },
    { 
      key = 'K',
      mods = 'SHIFT|CMD',
      action = act.AdjustPaneSize { 'Up', 1 } },
    {
      key = 'L',
      mods = 'SHIFT|CMD',
      action = act.AdjustPaneSize { 'Right', 1 },
    },

    -- Rotate
    {
      key = 'r',
      mods = 'ALT',
      action = act.RotatePanes 'CounterClockwise',
    },
    { 
      key = 'R',
      mods = 'SHIFT|ALT',
      action = act.RotatePanes 'Clockwise',
    },

    { 
      key = 'S', 
      mods = 'SHIFT|CTRL', 
      action = act.PaneSelect,
    },

    {
      key = 'S',
      mods = 'SHIFT|CMD',
      action = act.PaneSelect {
        mode = 'SwapWithActive',
      },
    },


    -- Tabs
    { key = ']', mods = 'SHIFT|CMD', action = wezterm.action.ShowTabNavigator },
    { key = 'Tab', mods = 'SHIFT|CTRL', action = act.ActivateTabRelative(-1) },
    { key = 'Tab', mods = 'CTRL', action = act.ActivateTabRelative(1) },

    {
      key = 'k',
      mods = 'CTRL',
      action = act.SendKey { key = 'k', mods = 'CTRL' },
    },

    {
      key = '0',
      mods = 'CTRL',
      action = wezterm.action.ResetFontAndWindowSize,
    },

    -- Utils
    {
      key = 'V',
      mods = 'SHIFT|CMD',
      action = wezterm.action.SplitPane {
        direction = 'Right',
        size = { Percent = 35 },
      },
    },

    -- Jump word to the left
    {
      key = 'LeftArrow',
      mods = 'OPT',
      action = act.SendKey {
        key = 'b',
        mods = 'ALT',
      },
    },

    -- Jump word to the right
    {
      key = 'RightArrow',
      mods = 'OPT',
      action = act.SendKey { key = 'f', mods = 'ALT' },
    },

    -- Go to beginning of line
    {
      key = 'LeftArrow',
      mods = 'CMD',
      action = act.SendKey {
        key = 'a',
        mods = 'CTRL',
      },
    },

    -- Go to end of line
    {
      key = 'RightArrow',
      mods = 'CMD',
      action = act.SendKey { key = 'e', mods = 'CTRL' },
    },

    { key = '/', mods = 'CTRL', action = act.SendKey { key = '/', mods = 'CTRL' } },
  },
  scrollback_lines = 6000,
  send_composed_key_when_left_alt_is_pressed = false,
  show_new_tab_button_in_tab_bar = false,
  switch_to_last_active_tab_when_closing_tab = true,
  tab_max_width = 60,

  window_decorations = "RESIZE",
  window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font { family = 'Fira Code', weight = 'Bold' },

    -- The size of the font in the tab bar.
    -- Default to 10. on Windows but 12.0 on other systems
    font_size = 14.0,

    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = '#1c1c1c',

    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = '#1c1c1c',
  },

  cursor_blink_rate = 400,
  default_cursor_style = "BlinkingBar",
  cursor_thickness = 1.5,

  colors = {
    background = "#1c1c1c",
    cursor_bg = '#fe5186',
    cursor_border = '#fe5186',
    selection_fg = '#1c1c1c',
    selection_bg = '#fe5186',
    tab_bar = {
      -- The color of the strip that goes along the top of the window
      -- (does not apply when fancy tab bar is in use)
      background = '#1c1c1c',
      inactive_tab_edge = '#1c1c1c',

      active_tab = {
        bg_color = '#1c1c1c',
        fg_color = '#c0c0c0',
      },

      -- Inactive tabs are the tabs that do not have focus
      inactive_tab = {
        bg_color = '#1c1c1c',
        fg_color = '#808080',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab`.
      },

      -- You can configure some alternate styling when the mouse pointer
      -- moves over inactive tabs
      inactive_tab_hover = {
        bg_color = '#1c1c1c',
        fg_color = '#808080',

        -- The same options that were listed under the `active_tab` section above
        -- can also be used for `inactive_tab_hover`.
      },
    },
  },
}
