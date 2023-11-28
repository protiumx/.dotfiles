local Path = require('plenary.path')
local strings = require('plenary.strings')

local telescope_actions = require('telescope.actions')
local telescope_sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')
local conf = require('telescope.config').values
local entry_display = require('telescope.pickers.entry_display')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local telescope_utils = require('telescope.utils')

local actions = require('config.telescope.actions')
local sorters = require('config.telescope.sorters')
local themes = require('config.telescope.themes')
local utils = require('config.utils')

local state = require('config.state')

local M = {}

local function entry_from_buffer(opts)
  local icon_width = 0
  local icon, _ = telescope_utils.get_devicons('fname', false)
  icon_width = strings.strdisplaywidth(icon)

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 1 },
      { width = opts.bufnr_width, right_justify = true },
      { width = 4 },
      { width = icon_width },
      { remaining = true },
    },
  })

  local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

  local make_display = function(entry)
    -- marked + bufnr_width + modes + icon + 4 spaces + : + lnum
    opts.__prefix = 1 + opts.bufnr_width + 4 + icon_width + 4 + 1 + #tostring(entry.lnum)
    local display_bufname = telescope_utils.transform_path(opts, entry.filename)
    local display_icon, hl_group = telescope_utils.get_devicons(entry.filename, false)

    return displayer({
      entry.marked and '󰤱' or ' ',
      { entry.bufnr, 'TelescopeResultsNumber' },
      { entry.indicator, 'TelescopeResultsComment' },
      { display_icon, hl_group },
      display_bufname .. ':' .. entry.lnum,
    })
  end

  return function(entry)
    local bufname = entry.info.name ~= '' and entry.info.name or '[No Name]'
    -- if bufname is inside the cwd, trim that part of the string
    bufname = Path:new(bufname):normalize(cwd)

    local hidden = entry.info.hidden == 1 and 'h' or 'a'
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, 'readonly') and '=' or ' '
    local changed = entry.info.changed == 1 and '+' or ' '
    local indicator = entry.flag .. hidden .. readonly .. changed
    local lnum = 1

    -- account for potentially stale lnum as getbufinfo might not be updated or from resuming buffers picker
    if entry.info.lnum ~= 0 then
      -- but make sure the buffer is loaded, otherwise line_count is 0
      if vim.api.nvim_buf_is_loaded(entry.bufnr) then
        local line_count = vim.api.nvim_buf_line_count(entry.bufnr)
        lnum = math.max(math.min(entry.info.lnum, line_count), 1)
      else
        lnum = entry.info.lnum
      end
    end

    -- NOTE: This caches the state of the of the results
    return make_entry.set_default_entry_mt({
      bufnr = entry.bufnr,
      display = make_display,
      filename = bufname,
      indicator = indicator,
      lnum = lnum,
      marked = state.get_buffer(entry.bufnr),
      ordinal = entry.bufnr .. ' : ' .. bufname,
      value = bufname,
    }, opts)
  end
end

-- based on telescope builtin https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__internal.lua#L885
-- place marked buffers always at the top of the results
function M.buffers(opts)
  opts.bufnr_width = 3 -- account for up to 3 digits buf numbers

  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) or not vim.api.nvim_buf_is_loaded(b) then
      return false
    end

    if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
      return false
    end

    if opts.cwd and not string.find(vim.api.nvim_buf_get_name(b), opts.cwd, 1, true) then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  if not next(bufnrs) then
    return
  end

  table.sort(bufnrs, function(a, b)
    if state.get_buffer(a) and state.get_buffer(b) then
      return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
    end

    if state.get_buffer(a) then
      return true
    end

    if state.get_buffer(b) then
      return false
    end

    return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
  end)

  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    table.insert(buffers, {
      bufnr = bufnr,
      flag = vim.fn.bufnr('') and '%' or (bufnr == vim.fn.bufnr('#') and '#' or ' '),
      info = vim.fn.getbufinfo(bufnr)[1],
    })
  end

  pickers
    .new(opts, {
      finder = finders.new_table({
        results = buffers,
        entry_maker = entry_from_buffer(opts),
      }),
      previewer = conf.grep_previewer(opts),
      sorter = sorters.buffer_sorter(),
      default_selection_index = 1,
      attach_mappings = function(_, map)
        map('i', "<M-'>", actions.toggle_buffer_mark)
        return true
      end,
    })
    :find()
end

local fd_search_files_cmd = {
  'fd',
  '-p',
  '--hidden',
  '-i',
  '-t',
  'f',
}

---@param pattern string
---@param callback fun(entry:string)
function M.find_file_pattern(pattern, callback)
  local opts = themes.get_dropdown()
  opts.entry_maker = make_entry.gen_from_file(opts)
  opts.prompt_title = 'Select File'

  local cmd = { 'fd', '--hidden', '--no-ignore', '--type', 'f', '-g', pattern }
  pickers
    .new(opts, {
      finder = finders.new_oneshot_job(cmd, opts),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(buffer_number)
        telescope_actions.select_default:replace(function()
          telescope_actions.close(buffer_number)
          callback(action_state.get_selected_entry()[1])
        end)
        return true
      end,
    })
    :find()
end

---@param opts table
---@param callback fun(entry:string)
function M.select_file(opts, callback)
  local builtin = require('telescope.builtin')
  opts = themes.get_dropdown(opts)
  opts.attach_mappings = function(buffer_number)
    telescope_actions.select_default:replace(function()
      telescope_actions.close(buffer_number)
      callback(action_state.get_selected_entry()[1])
    end)
    return true
  end

  builtin.find_files(opts)
end

---Find files on prompt change with fd
function M.find_files_live(opts)
  if opts.cwd then
    opts.cwd = vim.fn.expand(opts.cwd)
  else
    opts.cwd = vim.loop.cwd()
  end

  local cmd_generator = function(prompt)
    if #prompt < 3 then
      return nil
    end

    local args = utils.tbl_clone(fd_search_files_cmd)
    table.insert(args, prompt)

    return args
  end

  opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

  pickers
    .new(opts, {
      finder = finders.new_job(cmd_generator, opts.entry_maker, 0, opts.cwd),
      previewer = conf.file_previewer(opts),
      -- disable sorting so that regex can be used in the prompt
      sorter = telescope_sorters.empty(),
    })
    :find()
end

return M
