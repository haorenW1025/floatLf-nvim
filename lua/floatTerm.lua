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
  local close = api.nvim_get_var("floatLf_lf_close")
  local open = api.nvim_get_var("floatLf_lf_open")
  local split = api.nvim_get_var("floatLf_lf_split")
  local vsplit = api.nvim_get_var("floatLf_lf_vsplit")
  local tab = api.nvim_get_var("floatLf_lf_tab")
  api.nvim_buf_set_keymap(M.buf_handle, 't', close, '<c-\\><c-n>:call floatLf#delete_lf_buffer()<CR>', {})
  api.nvim_buf_set_keymap(M.buf_handle, 't', open, '<c-\\><c-n>:lua lf.lfOpenFile()<CR>', {})
  api.nvim_buf_set_keymap(M.buf_handle, 't', split, '<c-\\><c-n>:lua lf.lfSplitFile()<CR>', {})
  api.nvim_buf_set_keymap(M.buf_handle, 't', vsplit, '<c-\\><c-n>:lua lf.lfVsplitFile()<CR>', {})
  api.nvim_buf_set_keymap(M.buf_handle, 't', tab, '<c-\\><c-n>:lua lf.lfTabFile()<CR>', {})
end

function M.refocusFloatingWindow()
  api.nvim_set_current_win(M.win_handle)
  api.nvim_command("startinsert")
end

M.setMapping()

return M
