---@diagnostic disable: unused-local
local wezterm = require('wezterm')
local act = wezterm.action
-- https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html
local is_windows = wezterm.target_triple == 'x86_64-pc-windows-msvc'
local font = 'MonoLisa'
local key_mod_panes = is_windows and 'ALT' or 'CMD'

local keys = {
  {
    key = ',',
    mods = 'CMD',
    action = act.PromptInputLine({
      description = 'Launch',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:perform_action(
            act.SpawnCommandInNewWindow({
              args = wezterm.shell_split(line),
            }),
            pane
          )
        end
      end),
    }),
  },

  { key = 'PageUp', mods = 'SHIFT', action = act.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT', action = act.ScrollByPage(1) },

  {
    key = 'p',
    mods = key_mod_panes,
    action = act.ShowLauncherArgs({ flags = 'FUZZY|TABS|WORKSPACES' }),
  },

  {
    key = '.',
    mods = 'CMD',
    action = wezterm.action.ActivateCommandPalette,
  },

  {
    key = 'Enter',
    mods = key_mod_panes,
    action = act.ToggleFullScreen,
  },

  {
    key = ':',
    mods = key_mod_panes,
    action = act.ShowDebugOverlay,
  },

  -- Panes
  {
    key = 'd',
    mods = key_mod_panes,
    action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
  },
  {
    key = 'D',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
  },

  {
    key = 'w',
    mods = key_mod_panes,
    action = act.CloseCurrentPane({ confirm = true }),
  },

  { key = 'z', mods = key_mod_panes, action = act.TogglePaneZoomState },
  { key = 'x', mods = 'SHIFT|' .. key_mod_panes, action = act.ActivateCopyMode },

  {
    key = '1',
    mods = key_mod_panes,
    action = wezterm.action_callback(function(_win, pane)
      pane:move_to_new_tab()
    end),
  },

  {
    key = '!',
    mods = 'SHIFT|' .. key_mod_panes,
    action = wezterm.action_callback(function(_win, pane)
      pane:move_to_new_window()
    end),
  },

  -- Activation
  {
    key = 'h',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection('Left'),
  },

  {
    key = 'l',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection('Right'),
  },

  {
    key = 'k',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection('Up'),
  },

  {
    key = 'j',
    mods = key_mod_panes,
    action = act.ActivatePaneDirection('Down'),
  },

  -- Size
  {
    key = 'H',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize({ 'Left', 1 }),
  },

  {
    key = 'J',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize({ 'Down', 1 }),
  },

  {
    key = 'K',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize({ 'Up', 1 }),
  },

  {
    key = 'L',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.AdjustPaneSize({ 'Right', 1 }),
  },

  -- Rotate
  {
    key = 'r',
    mods = 'CMD',
    action = act.RotatePanes('CounterClockwise'),
  },

  {
    key = 'R',
    mods = 'SHIFT|CMD',
    action = act.RotatePanes('Clockwise'),
  },

  {
    key = 's',
    mods = key_mod_panes,
    action = act.PaneSelect({
      mode = 'SwapWithActive',
    }),
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
    action = act.SpawnTab('DefaultDomain'),
  },

  { key = 'T', mods = 'SHIFT|' .. key_mod_panes, action = act.ShowTabNavigator },
  { key = 'H', mods = 'SHIFT|' .. key_mod_panes, action = act.ActivateTabRelative(-1) },
  { key = 'L', mods = 'SHIFT|' .. key_mod_panes, action = act.ActivateTabRelative(1) },

  {
    key = 'o',
    mods = key_mod_panes,
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
    action = act.SplitPane({
      direction = 'Right',
      size = { Percent = 35 },
    }),
  },

  -- Jump word to the left
  {
    key = 'LeftArrow',
    mods = 'OPT',
    action = act.SendKey({
      key = 'b',
      mods = 'ALT',
    }),
  },

  -- Jump word to the right
  {
    key = 'RightArrow',
    mods = 'OPT',
    action = act.SendKey({ key = 'f', mods = 'ALT' }),
  },

  -- Go to beginning of line
  {
    key = 'LeftArrow',
    mods = 'CMD',
    action = act.SendKey({
      key = 'a',
      mods = 'CTRL',
    }),
  },

  -- Go to end of line
  {
    key = 'RightArrow',
    mods = 'CMD',
    action = act.SendKey({ key = 'e', mods = 'CTRL' }),
  },

  -- Bypass
  { key = '/', mods = 'CTRL', action = act.SendKey({ key = '/', mods = 'CTRL' }) },
  { key = 'q', mods = 'CTRL', action = act.SendKey({ key = 'q', mods = 'CTRL' }) },
  { key = 'k', mods = 'CTRL', action = act.SendKey({ key = 'k', mods = 'CTRL' }) },
  { key = 'i', mods = 'CTRL', action = act.SendKey({ key = 'i', mods = 'CTRL' }) },
}

local process_icons = {
  ['docker'] = wezterm.nerdfonts.linux_docker,
  ['docker-compose'] = wezterm.nerdfonts.linux_docker,
  ['psql'] = '󱤢',
  ['usql'] = '󱤢',
  ['kuberlr'] = wezterm.nerdfonts.linux_docker,
  ['kubectl'] = wezterm.nerdfonts.linux_docker,
  ['stern'] = wezterm.nerdfonts.linux_docker,
  ['nvim'] = wezterm.nerdfonts.custom_vim,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['vim'] = wezterm.nerdfonts.dev_vim,
  ['node'] = wezterm.nerdfonts.mdi_hexagon,
  ['go'] = wezterm.nerdfonts.seti_go,
  ['zsh'] = wezterm.nerdfonts.dev_terminal,
  ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
  ['btm'] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ['htop'] = wezterm.nerdfonts.mdi_chart_donut_variant,
  ['cargo'] = wezterm.nerdfonts.dev_rust,
  ['sudo'] = wezterm.nerdfonts.fa_hashtag,
  ['lazydocker'] = wezterm.nerdfonts.linux_docker,
  ['git'] = wezterm.nerdfonts.dev_git,
  ['lua'] = wezterm.nerdfonts.seti_lua,
  ['wget'] = wezterm.nerdfonts.mdi_arrow_down_box,
  ['curl'] = wezterm.nerdfonts.mdi_flattr,
  ['gh'] = wezterm.nerdfonts.dev_github_badge,
  ['ruby'] = wezterm.nerdfonts.cod_ruby,
}

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir or ''
  local HOME_DIR = string.format('file://%s', os.getenv('HOME'))

  return current_dir == HOME_DIR and '.' or string.gsub(current_dir, '(.*[/\\])(.*)', '%2')
end

local function get_process(tab)
  if not tab.active_pane or tab.active_pane.foreground_process_name == '' then
    return '[?]'
  end

  local process_name = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2')
  if string.find(process_name, 'kubectl') then
    process_name = 'kubectl'
  end

  return process_icons[process_name] or string.format('[%s]', process_name)
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local has_unseen_output = false
  if not tab.is_active then
    for _, pane in ipairs(tab.panes) do
      if pane.has_unseen_output then
        has_unseen_output = true
        break
      end
    end
  end

  local cwd = wezterm.format({
    { Attribute = { Intensity = 'Bold' } },
    { Text = get_current_working_dir(tab) },
  })

  local title = string.format(' %s ~ %s  ', get_process(tab), cwd)

  if has_unseen_output then
    return {
      { Foreground = { Color = '#28719c' } },
      { Text = title },
    }
  end

  return {
    { Text = title },
  }
end)

wezterm.on('update-right-status', function(window)
  if not window:get_dimensions().is_full_screen then
    window:set_right_status('')
    return
  end

  window:set_right_status(wezterm.format({
    { Foreground = { Color = '#808080' } },
    { Text = wezterm.strftime(' %R ') },
  }))
end)

local background = '#0a0a00'
local colors = {
  background = background,
  cursor_bg = '#a9a1e1',
  cursor_fg = background,
  cursor_border = '#fb4934',
  selection_fg = background,
  selection_bg = '#fb4934',
  tab_bar = {
    background = background,
    inactive_tab_edge = 'rgba(28, 28, 28, 0.9)',
    active_tab = {
      bg_color = background,
      fg_color = '#c0c0c0',
    },
    inactive_tab = {
      bg_color = background,
      fg_color = '#808080',
    },
    inactive_tab_hover = {
      bg_color = background,
      fg_color = '#808080',
    },
  },
}

local config = {
  audible_bell = 'Disabled',
  background = {
    {
      source = {
        File = '/Users/bmayo/.dotfiles/background/goya.jpg',
      },
      width = 'Cover',
      height = 'Cover',
      hsb = { brightness = 0.15 },
      vertical_align = 'Middle',
      horizontal_align = 'Center',
    },
  },
  canonicalize_pasted_newlines = 'None',
  color_scheme = 'Classic Dark (base16)',
  colors = colors,
  command_palette_font_size = 16.0,
  cursor_blink_rate = 500,
  command_palette_bg_color = '#1c1c1c',
  default_cursor_style = 'BlinkingBar',
  default_cwd = wezterm.home_dir,
  font = wezterm.font(font, { weight = 'Regular', italic = false }),
  font_rules = {
    {
      intensity = 'Bold',
      font = wezterm.font(font, { italic = false, weight = 'Bold' }),
    },
  },
  font_size = is_windows and 14.0 or 20.0,
  -- Disable font ligatures
  harfbuzz_features = { 'calt=1', 'clig=0', 'liga=0', 'zero', 'ss01' },
  hide_tab_bar_if_only_one_tab = false,
  hyperlink_rules = wezterm.default_hyperlink_rules(),
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.6,
  },
  keys = keys,
  max_fps = 120,
  mouse_bindings = {
    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'NONE',
      action = act.CompleteSelection('PrimarySelection'),
    },

    {
      event = { Up = { streak = 1, button = 'Left' } },
      mods = 'CMD',
      action = act.OpenLinkAtMouseCursor,
    },
  },
  quote_dropped_files = 'Posix',
  scrollback_lines = 10000,
  send_composed_key_when_left_alt_is_pressed = false,
  set_environment_variables = {
    EDITOR = 'nvim',
    PATH = '/opt/homebrew/bin:/home/bmayo/.go/current/bin:' .. os.getenv('PATH'),
  },
  show_new_tab_button_in_tab_bar = false,
  switch_to_last_active_tab_when_closing_tab = true,
  tab_max_width = 60,
  underline_position = -4,
  use_fancy_tab_bar = true,
  -- window_background_opacity = 1,
  -- window_background_opacity = 0.6,
  -- macos_window_background_blur = 10,
  window_decorations = 'RESIZE',
  window_frame = {
    font = wezterm.font({ family = font }),
    font_size = is_windows and 12.0 or 18.0,
    active_titlebar_bg = colors.background,
    inactive_titlebar_bg = colors.background,
  },
}

if is_windows then
  config.default_prog = { 'wsl.exe', '-d', 'Ubuntu-20.04', '--cd', '~' }
  config.wsl_domains = {
    {
      name = 'WSL:Ubuntu-20.04',
      distribution = 'Ubuntu-20.04',
      default_cwd = '~',
    },
  }
end

return config
