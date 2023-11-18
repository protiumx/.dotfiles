local Path = require('plenary.path')
local strings = require('plenary.strings')

local conf = require('telescope.config').values
local entry_display = require('telescope.pickers.entry_display')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local utils = require('telescope.utils')

local sorters = require('config.telescope.sorters')
local state = require('config.state')

local M = {}

local function entry_from_buffer(opts)
  local icon_width = 0
  local icon, _ = utils.get_devicons('fname', false)
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
    local display_bufname = utils.transform_path(opts, entry.filename)
    local icon, hl_group = utils.get_devicons(entry.filename, false)

    return displayer({
      entry.marked and '󰤱' or ' ',
      { entry.bufnr, 'TelescopeResultsNumber' },
      { entry.indicator, 'TelescopeResultsComment' },
      { icon, hl_group },
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

  -- always sort by most recent and marked buffers
  table.sort(bufnrs, function(a, b)
    return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
  end)

  table.sort(bufnrs, function(a, b)
    if state.get_buffer(a) then
      return true
    end

    return false
  end)

  local buffers = {}
  local default_selection_idx = 1
  for _, bufnr in ipairs(bufnrs) do
    local flag = bufnr == vim.fn.bufnr('') and '%' or (bufnr == vim.fn.bufnr('#') and '#' or ' ')

    if opts.sort_lastused and not opts.ignore_current_buffer and flag == '#' then
      default_selection_idx = 2
    end

    local element = {
      bufnr = bufnr,
      flag = flag,
      info = vim.fn.getbufinfo(bufnr)[1],
    }

    table.insert(buffers, element)
  end

  pickers
    .new(opts, {
      prompt_title = 'Buffers',
      finder = finders.new_table({
        results = buffers,
        entry_maker = entry_from_buffer(opts),
      }),
      previewer = conf.grep_previewer(opts),
      sorter = sorters.buffer_sorter(),
      default_selection_index = default_selection_idx,
    })
    :find()
end

return M
