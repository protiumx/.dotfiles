local wezterm = require('wezterm')
local act = wezterm.action
-- https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html
local is_windows = wezterm.target_triple == 'x86_64-pc-windows-msvc'
local cascadia_font = is_windows and 'CaskaydiaCove NF' or 'CaskaydiaCove Nerd Font'
local key_mod_panes = is_windows and 'ALT' or 'CMD'

local keys = {
  {
    key = 'p',
    mods = key_mod_panes,
    action = act.ShowLauncherArgs { flags = 'FUZZY|TABS|WORKSPACES' },
  },
  {
    key = 'Enter',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.ToggleFullScreen,
  },
  { key = ':', mods = 'SHIFT|' .. key_mod_panes,      action = act.ShowDebugOverlay },

  -- Panes
  {
    key = 'd',
    mods = key_mod_panes,
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'D',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'w',
    mods = key_mod_panes,
    action = act.CloseCurrentPane { confirm = true },
  },
  { key = 'z', mods = key_mod_panes,                  action = act.TogglePaneZoomState },
  { key = 'c', mods = 'CTRL|' .. key_mod_panes,       action = act.ActivateCopyMode },
  { key = 'c', mods = 'CTRL|SHIFT|' .. key_mod_panes, action = act.QuickSelect },
  {
    key = '!',
    mods = 'SHIFT|' .. key_mod_panes,
    action = wezterm.action_callback(function(_win, pane)
      pane:move_to_new_tab()
    end),
  },

  -- Activation
  {
    key = 'h',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection 'Down',
  },

  -- Size
  {
    key = 'H',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize { 'Left', 1 },
  },
  {
    key = 'J',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize { 'Down', 1 },
  },
  {
    key = 'K',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize { 'Up', 1 }
  },
  {
    key = 'L',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize { 'Right', 1 },
  },

  -- Rotate
  {
    key = 'r',
    mods = 'CMD',
    action = act.RotatePanes 'CounterClockwise',
  },
  {
    key = 'R',
    mods = 'SHIFT|CMD',
    action = act.RotatePanes 'Clockwise',
  },

  {
    key = 'S',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.PaneSelect,
  },

  -- Tabs
  {
    key = 't',
    mods = 'CMD',
    action = act.SpawnTab('DefaultDomain')
  },
  { key = 'T', mods = 'SHIFT|' .. key_mod_panes, action = act.ShowTabNavigator },
  { key = '[', mods = key_mod_panes,             action = act.ActivateTabRelative(-1) },
  { key = ']', mods = key_mod_panes,             action = act.ActivateTabRelative(1) },
  {
    key = '`',
    mods = 'CMD',
    action = act.ActivateLastTab,
  },


  {
    key = '0',
    mods = key_mod_panes,
    action = act.ResetFontAndWindowSize,
  },

  -- Utils
  {
    key = 'P',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.SplitPane {
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

  -- Bypass
  { key = '/', mods = 'CTRL', action = act.SendKey { key = '/', mods = 'CTRL' } },
  { key = 'q', mods = 'CTRL', action = act.SendKey { key = 'q', mods = 'CTRL' } },
  { key = 'k', mods = 'CTRL', action = act.SendKey { key = 'k', mods = 'CTRL' } },

}

local process_icons = {
  ['docker'] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['docker-compose'] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['kuberlr'] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['kubectl'] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['nvim'] = {
    { Text = wezterm.nerdfonts.custom_vim },
  },
  ['vim'] = {
    { Text = wezterm.nerdfonts.dev_vim },
  },
  ['node'] = {
    { Text = wezterm.nerdfonts.mdi_hexagon },
  },
  ['zsh'] = {
    { Text = wezterm.nerdfonts.dev_terminal },
  },
  ['bash'] = {
    { Text = wezterm.nerdfonts.cod_terminal_bash },
  },
  ['btm'] = {
    { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
  },
  ['htop'] = {
    { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
  },
  ['cargo'] = {
    { Text = wezterm.nerdfonts.dev_rust },
  },
  ['go'] = {
    { Text = wezterm.nerdfonts.mdi_language_go },
  },
  ['lazydocker'] = {
    { Text = wezterm.nerdfonts.linux_docker },
  },
  ['git'] = {
    { Text = wezterm.nerdfonts.dev_git },
  },
  ['lua'] = {
    { Text = wezterm.nerdfonts.seti_lua },
  },
  ['wget'] = {
    { Text = wezterm.nerdfonts.mdi_arrow_down_box },
  },
  ['curl'] = {
    { Text = wezterm.nerdfonts.mdi_flattr },
  },
  ['gh'] = {
    { Text = wezterm.nerdfonts.dev_github_badge },
  },
}


local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format('file://%s', os.getenv('HOME'))

  return current_dir == HOME_DIR and '.'
      or string.gsub(current_dir, '(.*[/\\])(.*)', '%2')
end

local function get_process(tab)
  local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
  if string.find(process_name, 'kubectl') then
    process_name = 'kubectl'
  end

  return wezterm.format(
    process_icons[process_name]
    or { { Text = string.format('[%s]', process_name) } }
  )
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local has_unseen_output = false
    if not tab.is_active then
      for _, pane in ipairs(tab.panes) do
        if pane.has_unseen_output then
          has_unseen_output = true
          break
        end
      end
    end

    local title = string.format(' %s  %s ~ %s  ', wezterm.nerdfonts.fa_chevron_right, get_process(tab),
      get_current_working_dir(tab))

    if has_unseen_output then
      return {
        { Foreground = { Color = 'Orange' } },
        { Text = title },
      }
    end

    return {
      { Text = title },
    }
  end
)

wezterm.on('update-right-status', function(window)
  if not window:get_dimensions().is_full_screen then
    window:set_right_status("")
    return
  end

  window:set_right_status(wezterm.format({
    { Attribute = { Intensity = 'Bold' } },
    { Foreground = { Color = '#808080' } },
    { Text = wezterm.strftime(' %R ') },
  }))
end)

local colors = {
  background = '#1c1c1c',
  cursor_bg = '#fe5186',
  cursor_border = '#fe5186',
  selection_fg = '#1c1c1c',
  selection_bg = '#fe5186',
  tab_bar = {
    -- The color of the strip that goes along the top of the window
    -- (does not apply when fancy tab bar is in use)
    -- background = '#1c1c1c',
    background = 'rgba(28, 28, 28, 0.9)',
    inactive_tab_edge = 'rgba(28, 28, 28, 0.9)',
    active_tab = {
      bg_color = 'rgba(28, 28, 28, 0.9)',
      fg_color = '#c0c0c0',
    },
    -- Inactive tabs are the tabs that do not have focus
    inactive_tab = {
      bg_color = 'rgba(28, 28, 28, 0.9)',
      fg_color = '#808080',
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab`.
    },
    -- You can configure some alternate styling when the mouse pointer
    -- moves over inactive tabs
    inactive_tab_hover = {
      bg_color = 'rgba(28, 28, 28, 0.9)',
      fg_color = '#808080',
      -- The same options that were listed under the `active_tab` section above
      -- can also be used for `inactive_tab_hover`.
    },
  },
}

local config = {
  audible_bell = 'Disabled',
  canonicalize_pasted_newlines = 'LineFeed',
  color_scheme = '3024 (base16)',
  colors = colors,
  command_palette_font_size = 16.0,
  cursor_blink_rate = 500,
  cursor_thickness = 1.5,
  default_cursor_style = 'BlinkingBar',
  default_cwd = wezterm.home_dir,
  font = wezterm.font(cascadia_font,
    { weight = is_windows and 'Regular' or 'DemiBold', stretch = 'Normal', style = 'Normal', italic = false }
  ),
  font_rules = {
    {
      intensity = 'Bold',
      font = wezterm.font(cascadia_font, { weight = 'Bold', stretch = 'Normal', style = 'Normal' }),
    },
    {
      intensity = 'Normal',
      font = wezterm.font(cascadia_font, { weight = 'DemiBold', stretch = 'Normal', style = 'Normal', italic = false }),
    },
  },
  font_size = is_windows and 14.0 or 18.6,
  -- Disable font ligatures
  harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  hide_tab_bar_if_only_one_tab = true,
  hyperlink_rules = wezterm.default_hyperlink_rules(),
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.85,
  },
  keys = keys,
  key_tables = {
    copy_mode = {
      {
        key = 'e',
        mods = 'NONE',
        action = act.CopyMode 'MoveForwardWordEnd',
      },
    },
  },
  max_fps = 120,
  mouse_bindings = {
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection 'PrimarySelection',
    },

    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
  },
  scrollback_lines = 10000,
  send_composed_key_when_left_alt_is_pressed = false,
  show_new_tab_button_in_tab_bar = false,
  switch_to_last_active_tab_when_closing_tab = true,
  tab_max_width = 60,
  underline_position = -3,
  use_fancy_tab_bar = true,
  window_background_opacity = 1,
  window_decorations = 'RESIZE',
  window_frame = {
    -- The font used in the tab bar.
    -- Roboto Bold is the default; this font is bundled
    -- with wezterm.
    -- Whatever font is selected here, it will have the
    -- main font setting appended to it to pick up any
    -- fallback fonts you may have used there.
    font = wezterm.font { family = cascadia_font, weight = 'Bold' },
    -- The size of the font in the tab bar.
    -- Default to 10. on Windows but 12.0 on other systems
    font_size = 16.0,
    -- The overall background color of the tab bar when
    -- the window is focused
    active_titlebar_bg = colors.background,
    -- The overall background color of the tab bar when
    -- the window is not focused
    inactive_titlebar_bg = colors.background,
  },
}

if is_windows then
  config.default_prog = { 'wsl.exe', '-d', 'Ubuntu-20.04', '--cd', '~' }
  config.wsl_domains = {
    {
      name = 'WSL:Ubuntu-20.04',
      distribution = 'Ubuntu-20.04',
      default_cwd = '~'
    },
  }
end

return config
