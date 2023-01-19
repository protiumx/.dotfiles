local wezterm = require 'wezterm'
local act = wezterm.action
local mux = wezterm.mux

local colors = {
  rosewater = '#F5E0DC',
  flamingo = '#F2CDCD',
  pink = '#F5C2E7',
  mauve = '#CBA6F7',
  red = '#F38BA8',
  maroon = '#EBA0AC',
  peach = '#FAB387',
  yellow = '#F9E2AF',
  green = '#A6E3A1',
  teal = '#94E2D5',
  sky = '#89DCEB',
  sapphire = '#74C7EC',
  blue = '#89B4FA',
  lavender = '#B4BEFE',

  text = '#CDD6F4',
  subtext1 = '#BAC2DE',
  subtext0 = '#A6ADC8',
  overlay2 = '#9399B2',
  overlay1 = '#7F849C',
  overlay0 = '#6C7086',
  surface2 = '#585B70',
  surface1 = '#45475A',
  surface0 = '#313244',

  base = '#1E1E2E',
  mantle = '#181825',
  crust = '#11111B',
}

local process_icons = {
  ['docker'] = {
    { Foreground = { Color = colors.blue } },
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['docker-compose'] = {
    { Foreground = { Color = colors.blue } },
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['nvim'] = {
    { Foreground = { Color = colors.green } },
    { Text = wezterm.nerdfonts.custom_vim },
  },
  ['vim'] = {
    { Foreground = { Color = colors.green } },
    { Text = wezterm.nerdfonts.dev_vim },
  },
  ['node'] = {
    { Foreground = { Color = colors.green } },
    { Text = wezterm.nerdfonts.mdi_hexagon },
  },
  ['zsh'] = {
    { Foreground = { Color = colors.peach } },
    { Text = wezterm.nerdfonts.dev_terminal },
  },
  ['bash'] = {
    { Foreground = { Color = colors.subtext0 } },
    { Text = wezterm.nerdfonts.cod_terminal_bash },
  },
  ['btm'] = {
    { Foreground = { Color = colors.yellow } },
    { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
  },
  ['htop'] = {
    { Foreground = { Color = colors.yellow } },
    { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
  },
  ['cargo'] = {
    { Foreground = { Color = colors.peach } },
    { Text = wezterm.nerdfonts.dev_rust },
  },
  ['go'] = {
    { Foreground = { Color = colors.sapphire } },
    { Text = wezterm.nerdfonts.mdi_language_go },
  },
  ['lazydocker'] = {
    { Foreground = { Color = colors.blue } },
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['git'] = {
    { Foreground = { Color = colors.peach } },
    { Text = wezterm.nerdfonts.dev_git },
  },
  ['lua'] = {
    { Foreground = { Color = colors.blue } },
    { Text = wezterm.nerdfonts.seti_lua },
  },
  ['wget'] = {
    { Foreground = { Color = colors.yellow } },
    { Text = wezterm.nerdfonts.mdi_arrow_down_box },
  },
  ['curl'] = {
    { Foreground = { Color = colors.yellow } },
    { Text = wezterm.nerdfonts.mdi_flattr },
  },
  ['gh'] = {
    { Foreground = { Color = colors.mauve } },
    { Text = wezterm.nerdfonts.dev_github_badge },
  },
}


local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

  return current_dir == HOME_DIR and "  ~"
      or string.format("  %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

local function get_process(tab)
  local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

  return wezterm.format(
    process_icons[process_name]
    or { { Foreground = { Color = colors.sky } }, { Text = string.format("[%s]", process_name) } }
  )
end

wezterm.on('gui-startup', function(cmd)
  ---@diagnostic disable-next-line: unused-local
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    return wezterm.format({
      { Attribute = { Intensity = "Half" } },
      { Text = string.format(" %s  ", wezterm.nerdfonts.fa_chevron_right) },
      "ResetAttributes",
      { Text = get_process(tab) },
      { Text = " ~ " },
      { Text = get_current_working_dir(tab) },
      { Foreground = { Color = colors.base } },
      { Text = "  ▕" },
    })
  end
)

wezterm.on("update-right-status", function(window)
  window:set_right_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.strftime(" %A, %d %B %Y %I:%M %p ") },
  }))
end)

return {
  audible_bell = "Disabled",
  color_scheme = "3024 (base16)",
  max_fps = 100,
  font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Medium", stretch = "Normal", style = "Normal" }),
  font_rules = {
    {
      intensity = 'Bold',
      font = wezterm.font("CaskaydiaCove Nerd Font", { weight = "Bold", stretch = "Normal", style = "Normal" }),
    },
  },
  font_size = 19.0,
  -- Disable font ligatures
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

  hide_tab_bar_if_only_one_tab = true,
  inactive_pane_hsb = {
    saturation = 1.0,
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
      action = act.AdjustPaneSize { 'Up', 1 }
    },
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
      mods = 'SHIFT|ALT',
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

    { key = 'f', mods = 'SHIFT|CMD', action = act.TogglePaneZoomState },

    { key = 'c', mods = 'SHIFT|CMD', action = act.ActivateCopyMode },
  },

  mouse_bindings = {
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'PrimarySelection',
    },

    -- and make CTRL-Click open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
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
    font = wezterm.font { family = 'CaskaydiaCove Nerd Font', weight = 'Bold' },

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
  underline_position = -3,
  use_fancy_tab_bar = true,


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
