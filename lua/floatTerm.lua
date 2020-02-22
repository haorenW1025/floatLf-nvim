local api = vim.api
local M = {}

function M.createFloatingWindow()
  local column = api.nvim_get_option("columns")
  local line = api.nvim_get_option("lines")

  -- TODO make this user adjustable
  local width = column * 0.9
  local height = line * 0.9

  local opts = {
    relative = "editor",
    width = math.ceil(width),
    height  = math.ceil(height),
    row = math.ceil((line - height) / 2)-1 ,
    col = math.ceil((column - width)  / 2)
  }
  M.buf_handle = api.nvim_create_buf(false, true)
  M.setMapping()
  M.win_handle = api.nvim_open_win(M.buf_handle, true, opts)
  api.nvim_win_set_option(M.win_handle, 'winhl', 'Normal:Floating')
end

function M.setMapping()
  -- TODO make this user adjustable
  api.nvim_buf_set_keymap(M.buf_handle, 't', '<c-o>', '<c-\\><c-n>:LfOpen<CR>i', {})
  api.nvim_buf_set_keymap(M.buf_handle, 't', '<c-x>', '<c-\\><c-n>:LfSplit<CR>i', {})
  api.nvim_buf_set_keymap(M.buf_handle, 't', '<c-v>', '<c-\\><c-n>:LfVsplit<CR>i', {})
  api.nvim_buf_set_keymap(M.buf_handle, 't', '<c-t>', '<c-\\><c-n>:LfTab<CR>i', {})
end

function M.refocusFloatingWindow()
  api.nvim_set_current_win(M.win_handle)
  api.nvim_command("startinsert")
end

return M
