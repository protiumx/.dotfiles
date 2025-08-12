local M = {}

---Returns the current cwd folder name
function M.get_cwd_name()
  return vim.fn.fnamemodify(vim.loop.cwd(), ':t')
end

function M.delete_buffer(buf, opts)
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  -- Filter out unlisted or dir buffers
  local listed = vim.tbl_filter(function(b)
    return vim.fn.buflisted(b) == 1
      and vim.fn.bufname(b) ~= '.'
      and vim.fn.bufname(b) ~= vim.loop.cwd()
  end, vim.api.nvim_list_bufs())

  -- If we only have 2 buffers, just close the current one
  if #listed <= 2 then
    pcall(vim.cmd, (opts.wipe and 'bwipeout! ' or 'bdelete! ') .. buf)
    return
  end

  vim.api.nvim_buf_call(buf, function()
    if vim.bo.modified then
      local ok, choice = pcall(
        vim.fn.confirm,
        ('Save changes to %q?'):format(vim.fn.bufname()),
        '&Yes\n&No\n&Cancel'
      )
      if not ok or choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
        return
      end
      if choice == 1 then -- Yes
        vim.cmd.write()
      end
    end

    for _, win in ipairs(vim.fn.win_findbuf(buf)) do
      vim.api.nvim_win_call(win, function()
        if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
          return
        end

        -- Try using alternate buffer
        local alt = vim.fn.bufnr('#')
        local alt_win = vim.fn.win_findbuf(alt)
        if alt ~= buf and #alt_win == 0 and vim.fn.buflisted(alt) == 1 then
          vim.api.nvim_win_set_buf(win, alt)
          return
        end

        -- Try using previous buffer
        -- local has_previous = pcall(vim.cmd, 'bprevious')
        -- if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        --   return
        -- end

        -- Create new listed buffer to avoid changing layout
        -- local new_buf = vim.api.nvim_create_buf(true, false)
        -- vim.api.nvim_win_set_buf(win, new_buf)
      end)
    end

    if vim.api.nvim_buf_is_valid(buf) then
      pcall(vim.cmd, (opts.wipe and 'bwipeout! ' or 'bdelete! ') .. buf)
    end
  end)
end

---Shallow clone a table
---@param original table
---@return table
function M.tbl_clone(original)
  local copy = {}
  for key, value in pairs(original) do
    copy[key] = value
  end
  return copy
end

---Get the current line if in normal mode all get all lines from the visual lines
function M.get_lines_indexes()
  local line = vim.fn.line('.')
  if string.lower(vim.fn.mode()) ~= 'v' then
    return { line, line }
  end

  local vline = vim.fn.getpos('v')[2]
  if vline > 0 and line > vline then
    -- vline marks the start
    return { vline, line }
  end

  return { line, line }
end

---Get text from visual selection
function M.get_selection_text()
  local a_orig = vim.fn.getreg('a')
  local mode = vim.fn.mode()
  if mode ~= 'v' and mode ~= 'V' then
    vim.cmd([[normal! gv]])
  end

  vim.cmd([[normal! "aygv]])
  local text = vim.fn.getreg('a')
  vim.fn.setreg('a', a_orig)
  return text
end

---@param filename string
---@return string|nil
function M.get_git_url(filename)
  local remote_output = vim.fn.systemlist('gremote')
  if #remote_output == 0 then
    vim.notify('No remote found in current cwd', vim.log.levels.WARN)
    return nil
  end

  local branch_output = vim.fn.systemlist('git rev-parse --abbrev-ref HEAD')

  local remote = remote_output[1]
  local branch = branch_output[1]

  local url = string.format('%s/tree/%s/%s', remote, branch, filename)
  if string.find(remote, 'bitbucket') then
    url = string.format('%s/browse/%s?at=refs/heads/%s', remote, filename, branch)
  end

  return url
end

function M.uuid()
  local id, _ = vim.fn.system('uuidgen'):gsub('\n', ''):lower()
  return id
end

function M.uid()
  local uuid = M.uuid()
  return string.gsub(uuid, '-', '')
end

-- Checks for
-- - Writing git commits
-- - Editing /tmp files
-- - Env variable `MIN` is present
function M.should_minimal_env()
  if (vim.env.CL or '') ~= '' then
    return true
  end

  -- Check if one argument is a /tmp file
  return vim.tbl_contains(vim.v.argv, function(arg)
    return vim.startswith(arg, '/tmp/') or vim.startswith(arg, '/private/')
  end, { predicate = true })
end

return M
