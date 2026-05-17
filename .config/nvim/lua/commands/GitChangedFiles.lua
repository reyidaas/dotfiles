local git_qf_loaded = false

local function get_git_files()
  return vim.fn.systemlist('git diff --name-only')
end

local function build_qf_list(files)
  local qf_list = {}
  for _, file in ipairs(files) do
    if file ~= '' then
      table.insert(qf_list, { filename = file, lnum = 1, col = 1, text = 'changed' })
    end
  end
  return qf_list
end

local function qf_has_git_files(files)
  local current_qf = vim.fn.getqflist()
  if #current_qf ~= #files then return false end
  for i, entry in ipairs(current_qf) do
    if vim.fn.bufname(entry.bufnr) ~= files[i] then
      return false
    end
  end
  return true
end

vim.api.nvim_create_user_command('GitChangedFiles', function()
  local files = get_git_files()

  if not git_qf_loaded or not qf_has_git_files(files) then
    vim.fn.setqflist(build_qf_list(files), 'r')
    git_qf_loaded = true
    vim.cmd('cfirst')
  else
    local ok = pcall(vim.cmd, 'cnext')
    if not ok then
      git_qf_loaded = false
      vim.notify('No more changed files', vim.log.levels.INFO)
    end
  end

  -- save the window where the file was opened
  local file_win = vim.api.nvim_get_current_win()
  vim.cmd('copen')
  -- refocus the file window
  vim.api.nvim_set_current_win(file_win)
end, {})
