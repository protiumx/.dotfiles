---@diagnostic disable: unused-local

-- Sources:
-- https://wezterm.org/config/lua/config/index.html
-- https://wezterm.org/config/lua/keyassignment/index.html

local wezterm = require('wezterm')
local act = wezterm.action

-- https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html
local is_windows = wezterm.target_triple == 'x86_64-pc-windows-msvc'
local font = 'Berkeley Mono'
local key_mod_panes = is_windows and 'ALT' or 'CMD'

-- Global state
local state = {
  debug_mode = false,
}

local function pane_keys(mod)
  local key_mappings = {
    j = 'Down',
    h = 'Left',
    l = 'Right',
    k = 'Up',
  }

  local keys = {}
  for k, dir in pairs(key_mappings) do
    table.insert(keys, {
      key = k,
      mods = mod,
      action = act.ActivatePaneDirection(dir),
    })

    table.insert(keys, {
      key = k,
      mods = mod .. '|CTRL',
      action = act.SplitPane({
        direction = dir,
      }),
    })

    table.insert(keys, {
      key = k,
      mods = mod .. '|CTRL|SHIFT',
      action = act.SplitPane({
        direction = dir,
        top_level = true,
      }),
    })

    table.insert(keys, {
      key = k,
      mods = mod .. '|ALT',
      action = act.AdjustPaneSize({ dir, 1 }),
    })
  end

  return keys
end

local function open_file(window, pane, uri)
  wezterm.log_info('enter with uir', uri)
  -- Not a file or in alt screen (e.g. nvim, less)
  if pane:is_alt_screen_active() then
    return false
  end

  local path = ''
  local row = ''
  local path_row_pattern = '(%S+):(%d+)'

  -- check for pattern file://[HOSTNAME]/PATH[#linenr]
  if uri:find('^file:') == 1 then
    local url = wezterm.url.parse(uri)
    path = url.file_path
    if url.fragment then
      row = url.fragment
    end
  elseif uri:find(path_row_pattern) ~= -1 then
    path, row = string.match(uri, path_row_pattern)
  else
    return false
  end

  wezterm.log_info('......', uri, path, row)
  local editor = 'nvim'
  local cursor = ''
  if row and row ~= '' then
    cursor = '+' .. row
  end

  local args = cursor ~= '' and { editor, cursor, path } or { editor, path }
  local cmd = wezterm.shell_join_args(args)

  -- If there is a pane with neovim send keys
  local panes = window:active_tab():panes()
  for _, p in ipairs(panes) do
    local editor_ps = p:get_foreground_process_name():find(editor)
    if editor_ps then
      row = row ~= '' and ('|' .. row) or ''
      p:send_text(':')
      wezterm.sleep_ms(50)
      p:send_text('e ' .. path .. row .. '\r')
      p:activate()
      return true
    end
  end

  -- Open nvim in a new pane to the right
  pane:split({ args = args, direction = 'Right', top_level = true })
  return true
end

local key_table_leader = { key = '/', mods = key_mod_panes, timeout_milliseconds = 1000 }

local keys = {
  {
    key = ',',
    mods = 'CMD',
    action = act.PromptInputLine({
      description = 'Launch',
      prompt = ' ',
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

  {
    key = '?',
    mods = 'CMD|CTRL',
    action = wezterm.action_callback(function()
      state.debug_mode = not state.debug_mode
    end),
  },
  {
    key = 'a',
    mods = 'LEADER|CTRL',
    action = wezterm.action.SendString('lololo'),
  },

  -- Scrolling
  { key = 'PageUp', action = act.ScrollByPage(-0.3) },
  { key = 'PageDown', action = act.ScrollByPage(0.3) },
  { key = 'UpArrow', mods = 'ALT', action = act.ScrollByLine(-1) },
  { key = 'DownArrow', mods = 'ALT', action = act.ScrollByLine(1) },
  { key = 'UpArrow', mods = 'SHIFT|ALT', action = act.ScrollToTop },
  { key = 'DownArrow', mods = 'SHIFT|ALT', action = act.ScrollToBottom },

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
    key = 'p',
    mods = 'LEADER',
    action = act.ActivateKeyTable({
      name = 'pane',
      timeout_milliseconds = 2000,
    }),
  },

  {
    key = 'w',
    mods = key_mod_panes,
    action = act.CloseCurrentPane({ confirm = true }),
  },

  {
    key = 'W',
    mods = key_mod_panes .. '|SHIFT',
    action = wezterm.action.CloseCurrentTab({ confirm = true }),
  },

  {
    key = 'z',
    mods = key_mod_panes,
    action = act.TogglePaneZoomState,
  },

  {
    key = '!',
    mods = 'SHIFT|' .. key_mod_panes,
    action = wezterm.action_callback(function(_win, pane)
      pane:move_to_new_window()
    end),
  },

  -- Rotate
  {
    key = 'r',
    mods = key_mod_panes,
    action = act.RotatePanes('Clockwise'),
  },

  -- Select and focus
  {
    key = 's',
    mods = key_mod_panes,
    action = act.PaneSelect,
  },

  -- Select and swap
  {
    key = 'S',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.PaneSelect({
      mode = 'SwapWithActive',
    }),
  },

  -- Tabs
  {
    key = 't',
    mods = 'CMD',
    action = act.SpawnCommandInNewTab({ cwd = wezterm.home_dir }),
  },

  { key = 'T', mods = 'SHIFT|' .. key_mod_panes, action = act.ShowTabNavigator },
  -- Activate Tabs
  { key = 'H', mods = 'SHIFT|' .. key_mod_panes, action = act.ActivateTabRelative(-1) },
  { key = 'L', mods = 'SHIFT|' .. key_mod_panes, action = act.ActivateTabRelative(1) },
  {
    key = 'o',
    mods = key_mod_panes,
    action = act.ActivateLastTab,
  },

  -- Swap Tabs
  { key = '{', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
  { key = '}', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },

  -- Utils

  {
    key = 'R',
    mods = 'SHIFT|CMD',
    action = act.ReloadConfiguration,
  },

  {
    key = 'n',
    mods = 'SHIFT|' .. key_mod_panes,
    action = wezterm.action.ShowLauncherArgs({
      title = 'Launch',
      fuzzy_help_text = 'Search: ',
      flags = 'FUZZY|TABS|LAUNCH_MENU_ITEMS',
    }),
  },
  {
    key = '0',
    mods = key_mod_panes,
    action = act.ResetFontSize,
  },

  {
    key = 'v',
    mods = 'SHIFT|' .. key_mod_panes,
    action = act.ActivateCopyMode,
  },

  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = act.QuickSelectArgs({
      patterns = {
        'https?://\\S+',
      },
    }),
  },
  {
    key = '?',
    mods = 'CMD',
    action = act.QuickSelect,
  },
  -- Quick select links and open them
  {
    key = 'O',
    mods = 'CMD|SHIFT',
    action = act.QuickSelectArgs({
      patterns = {
        'https?://\\S+',
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.open_with(url)
      end),
    }),
  },
  -- Quick select files
  {
    key = 'F',
    mods = 'CMD|SHIFT',
    action = act.QuickSelectArgs({
      patterns = {
        'file:///\\S+',
        '[\\w\\d/.-_]+:\\d{1,4}',
      },
      action = wezterm.action_callback(function(window, pane)
        local uri = window:get_selection_text_for_pane(pane)
        open_file(window, pane, uri)
      end),
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

for _, v in ipairs(pane_keys(key_mod_panes)) do
  table.insert(keys, v)
end

local key_tables = {
  pane = {
    {
      key = 't',
      action = wezterm.action_callback(function(_win, pane)
        pane:move_to_new_tab()
      end),
    },

    -- vertical slim panel
    {
      key = 'v',
      action = act.SplitPane({
        direction = 'Right',
        size = { Percent = 35 },
      }),
    },

    {
      key = 'h',
      action = act.SplitPane({
        direction = 'Down',
        size = { Percent = 35 },
      }),
    },
  },
}

local process_icons = {
  ['docker'] = wezterm.nerdfonts.linux_docker,
  ['docker-compose'] = wezterm.nerdfonts.linux_docker,
  ['btm'] = '',
  ['psql'] = '󱤢',
  ['usql'] = '󱤢',
  ['kuberlr'] = wezterm.nerdfonts.linux_docker,
  ['ssh'] = wezterm.nerdfonts.fa_exchange,
  ['ssh-add'] = wezterm.nerdfonts.fa_exchange,
  ['kubectl'] = wezterm.nerdfonts.linux_docker,
  ['stern'] = wezterm.nerdfonts.linux_docker,
  ['nvim'] = wezterm.nerdfonts.custom_vim,
  ['vim'] = wezterm.nerdfonts.dev_vim,
  ['make'] = wezterm.nerdfonts.seti_makefile,
  ['node'] = wezterm.nerdfonts.mdi_hexagon,
  ['go'] = wezterm.nerdfonts.seti_go,
  ['python3'] = '',
  ['Python'] = '',
  ['zsh'] = wezterm.nerdfonts.dev_terminal,
  ['bash'] = wezterm.nerdfonts.cod_terminal_bash,
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
  ['yazi'] = '',
  ['wezterm'] = wezterm.nerdfonts.cod_tools,
}

local theme = {
  bg = '#161616',
  fg1 = '#bbbbbb',
  fg2 = '#9e9e9e',
  fg3 = '#777777',
  unseen = '#C53030',
}

local function get_current_working_dir(tab)
  local url = tab.active_pane and tab.active_pane.current_working_dir or { file_path = '' }
  local path = url.file_path
  if path:sub(-1) == '/' then
    path = path:sub(1, #path - 1)
  end

  local HOME_DIR = os.getenv('HOME')

  return path == HOME_DIR and '~' or string.gsub(path, '(.*[/\\])(.*)', '%2')
end

local function get_tab_process(tab)
  if not tab.active_pane then
    return nil
  end

  if tab.active_pane.foreground_process_name == '' then
    return process_icons['wezterm'] .. ' ' .. tab.active_pane.title
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

  local cwd = get_current_working_dir(tab)
  local process = get_tab_process(tab)
  local title = '[?]'
  if process then
    if cwd ~= '' then
      title = string.format(' %s (%s) ', process, cwd)
    else
      title = string.format(' %s ', process)
    end
  end

  local w = wezterm.column_width(title)
  local min_width = 10
  if w < min_width then
    title = wezterm.pad_right(title, min_width)
  end

  local format = wezterm.format({
    { Text = title },
  })

  if has_unseen_output then
    format = wezterm.format({
      { Foreground = { Color = theme.unseen } },
      { Text = title },
    })
  end

  return format
end)

wezterm.on('update-right-status', function(window, pane)
  local process = ''

  if state.debug_mode then
    local info = pane:get_foreground_process_info()
    if info then
      process = info.name
      for i = 2, #info.argv do
        process = info.argv[i]
      end
    end
  end

  local status = (#process > 0 and ' | ' or '')
  local name = window:active_key_table()
  if name then
    status = string.format('󰌌  { %s }', name)
  end

  if window:get_dimensions().is_full_screen then
    status = status .. wezterm.strftime(' %R ')
  end

  window:set_right_status(wezterm.format({
    { Foreground = { Color = theme.fg2 } },
    { Text = process },
    { Foreground = { Color = theme.fg2 } },
    { Text = status },
  }))
end)

wezterm.on('open-uri', function(window, pane, uri)
  return open_file(window, pane, uri)
end)

local colors = {
  background = theme.bg,
  cursor_bg = theme.fg2,
  cursor_fg = theme.bg,
  cursor_border = theme.fg2,
  selection_fg = theme.bg,
  selection_bg = '#fb4934',
  quick_select_label_bg = { Color = '#60b5de' },
  quick_select_label_fg = { Color = '#ffffff' },
  quick_select_match_bg = { Color = '#c07d9e' },
  quick_select_match_fg = { Color = '#ffffff' },
  tab_bar = {
    background = theme.bg,
    inactive_tab_edge = 'rgba(28, 28, 28, 0.9)',
    active_tab = {
      bg_color = theme.bg,
      fg_color = theme.fg1,
    },
    inactive_tab = {
      bg_color = theme.bg,
      fg_color = theme.fg3,
    },
    inactive_tab_hover = {
      bg_color = theme.bg,
      fg_color = theme.fg2,
    },
  },
}

local config = {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = 'Disabled',
  background = {
    -- {
    --   source = {
    --     File = '/Users/bmayo/.dotfiles/background/goya.jpg',
    --   },
    --   width = 'Cover',
    --   height = 'Cover',
    --   hsb = { brightness = 0.3 },
    --   vertical_align = 'Middle',
    --   horizontal_align = 'Center',
    -- },
  },
  canonicalize_pasted_newlines = 'None',
  check_for_updates = true,
  color_scheme = 'Classic Dark (base16)',
  colors = colors,
  command_palette_font_size = 18.0,
  command_palette_bg_color = '#1c1c1c',
  cursor_blink_rate = 500,
  default_cursor_style = 'BlinkingUnderline',
  default_cwd = wezterm.home_dir,
  default_prog = { 'zsh' },
  font = wezterm.font(font, { weight = 'Regular', italic = false }),
  font_rules = {
    -- Disable italics in bold
    {
      intensity = 'Bold',
      font = wezterm.font(font, { italic = false, weight = 'Bold' }),
    },
  },
  font_size = is_windows and 16.0 or 21.0,
  -- Disable font ligatures
  harfbuzz_features = { 'calt=1', 'clig=0', 'liga=0', 'zero', 'ss01' },
  hide_tab_bar_if_only_one_tab = false,
  hyperlink_rules = wezterm.default_hyperlink_rules(),
  inactive_pane_hsb = {
    saturation = 1.0,
    brightness = 0.6,
  },
  keys = keys,
  key_tables = key_tables,
  launch_menu = {
    {
      label = 'Run go package tests',
      args = { 'go', 'test', './...' },
    },
  },
  leader = key_table_leader,
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
  quick_select_patterns = {
    '[0-9a-f]{7,40}', -- hashes
    '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}', -- uuids
    '(https?|file):\\/\\/\\S+',
  },
  quote_dropped_files = 'Posix',
  scrollback_lines = 10000,
  send_composed_key_when_left_alt_is_pressed = false,
  set_environment_variables = {
    EDITOR = 'nvim',
    PATH = '/opt/homebrew/bin:/home/bmayo/.go/current/bin:' .. os.getenv('PATH'),
  },
  show_new_tab_button_in_tab_bar = false,
  show_close_tab_button_in_tabs = false,
  switch_to_last_active_tab_when_closing_tab = true,
  tab_max_width = 80,
  -- underline_position = -4,
  use_fancy_tab_bar = true,
  use_resize_increments = true,
  window_background_opacity = 0.7,
  -- macos_window_background_blur = 10,
  window_decorations = 'RESIZE',
  window_frame = {
    font = wezterm.font({ family = font, weight = 'Bold' }),
    font_size = is_windows and 15.0 or 18.0,
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
