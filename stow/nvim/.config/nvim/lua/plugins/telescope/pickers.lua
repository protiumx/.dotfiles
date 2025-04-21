local Path = require('plenary.path')

local strings = require('plenary.strings')

local telescope_actions = require('telescope.actions')
local telescope_sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')
local telescope_config = require('telescope.config').values
local entry_display = require('telescope.pickers.entry_display')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local telescope_utils = require('telescope.utils')

local actions = require('plugins.telescope.actions')
local sorters = require('plugins.telescope.sorters')
local themes = require('plugins.telescope.themes')

local utils = require('config.utils')
local state = require('config.state')

-- Used to sort buffers that have common marks
local common_marks = { 'A', 'S', 'D', 'F' }

local M = {}

local function entry_from_buffer(opts)
  local icon_width = 0
  local icon, _ = telescope_utils.get_devicons('fname', false)
  icon_width = strings.strdisplaywidth(icon)

  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 1 }, -- pin
      { width = opts.bufnr_width },
      { width = 1 }, -- mark
      { width = icon_width },
      { remaining = true },
    },
  })

  local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

  local make_display = function(entry)
    -- marked + bufnr_width + mark + icon
    -- E.g. "󰤱.100.A.<icon>.some/path", dots are spaces
    opts.__prefix = 1 + opts.bufnr_width + 1 + icon_width + 3
    local display_bufname = telescope_utils.transform_path(opts, entry.filename)
    local display_icon, hl_group = telescope_utils.get_devicons(entry.filename, false)

    return displayer({
      entry.marked and '󰤱' or ' ',
      { entry.bufnr, 'TelescopeResultsNumber' },
      { entry.indicator, 'TelescopeMatching' },
      { display_icon, hl_group },
      display_bufname,
    })
  end

  return function(entry)
    local bufname = entry.info.name ~= '' and entry.info.name or '[No Name]'
    -- if bufname is inside the cwd, trim that part of the string
    bufname = Path:new(bufname):normalize(cwd)

    -- NOTE: This caches the state of the of the results
    return make_entry.set_default_entry_mt({
      bufnr = entry.bufnr,
      display = make_display,
      filename = bufname,
      indicator = entry.mark or ' ',
      marked = state.get_buffer(entry.bufnr),
      ordinal = entry.bufnr .. ' : ' .. bufname,
      value = bufname,
    }, opts)
  end
end

-- based on telescope builtin https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/__internal.lua#L885
-- place marked buffers always at the top of the results
function M.buffers(opts)
  -- Max text width for "999"
  opts.bufnr_width = 3

  -- Filter out unloaded buffers and buffers for the cwd
  local bufnrs = vim.tbl_filter(function(b)
    if 1 ~= vim.fn.buflisted(b) or not vim.api.nvim_buf_is_loaded(b) then
      return false
    end

    if opts.ignore_current_buffer and b == vim.api.nvim_get_current_buf() then
      return false
    end

    local bufname = vim.api.nvim_buf_get_name(b)
    if opts.cwd and not string.find(bufname, opts.cwd, 1, true) then
      return false
    end

    if bufname == '.' or bufname == vim.loop.cwd() then
      return false
    end

    return true
  end, vim.api.nvim_list_bufs())

  if not next(bufnrs) then
    vim.notify('No listed buffers')
    return
  end

  local buffers = {}
  for _, bufnr in ipairs(bufnrs) do
    local mark = nil
    for _, m in ipairs(common_marks) do
      local row = vim.api.nvim_buf_get_mark(bufnr, m)[1]
      if row > 0 then
        mark = m
        break
      end
    end

    table.insert(buffers, {
      bufnr = bufnr,
      info = vim.fn.getbufinfo(bufnr)[1],
      mark = mark,
    })
  end

  table.sort(buffers, function(a, b)
    -- When both buffers are marked fallback to lastused timestamp
    if state.get_buffer(a.bufnr) and state.get_buffer(b.bufnr) then
      return a.info.lastused > b.info.lastused
    end

    if a.mark ~= nil and b.mark ~= nil then
      return a.mark > b.mark
    end

    if state.get_buffer(a.bufnr) or a.mark ~= nil then
      return true
    end

    if state.get_buffer(b.bufnr) or b.mark ~= nil then
      return false
    end

    return a.info.lastused > b.info.lastused
  end)

  pickers
    .new(opts, {
      finder = finders.new_table({
        results = buffers,
        entry_maker = entry_from_buffer(opts),
      }),
      previewer = telescope_config.grep_previewer(opts),
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
      sorter = telescope_config.file_sorter(opts),
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
  opts.cwd = opts.cwd and vim.fn.expand(opts.cwd) or vim.loop.cwd()

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
      previewer = telescope_config.file_previewer(opts),
      -- disable sorting so that regex can be used in the prompt
      sorter = telescope_sorters.empty(),
    })
    :find()
end

return M
