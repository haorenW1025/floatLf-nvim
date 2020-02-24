local api = vim.api
local M = {}

function M.createFloatingWindow()
  M.win_prev = api.nvim_tabpage_get_win(0)
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
    col = math.ceil((column - width)  / 2),
    style = "minimal"
  }

  if api.nvim_get_var("floatLf_border") == 1 then
    local top_left = api.nvim_get_var("floatLf_topleft_border")
    local top_right = api.nvim_get_var("floatLf_topright_border")
    local horizontal = api.nvim_get_var("floatLf_horizontal_border")
    local vertical = api.nvim_get_var("floatLf_vertical_border")
    local bot_left = api.nvim_get_var("floatLf_botleft_border")
    local bot_right = api.nvim_get_var("floatLf_botright_border")

    local top_border = top_left..string.rep(horizontal, width - 2)..top_right
    local mid_border = vertical..string.rep(" ", width - 2)..vertical
    local bot_border = bot_left..string.rep(horizontal, width - 2)..bot_right
    local border_lines = top_border..string.rep(mid_border, height - 2)..bot_border
    local lines = {top_border}
    for i=1, math.ceil(height)-2, 1 do
      table.insert(lines, mid_border)    
    end
    table.insert(lines, bot_border)
    M.buf_handle = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(M.buf_handle, 0, -1, true, lines)
    M.win_handle = api.nvim_open_win(M.buf_handle, true, opts)
    api.nvim_win_set_option(M.win_handle, 'winhl', 'Normal:Floating')
  end

  opts['width'] = opts['width'] - 4
  opts['height'] = opts['height'] -2
  opts['row'] = opts['row'] + 1
  opts['col'] = opts['col'] + 2
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
  local opts = {silent = true}
  api.nvim_buf_set_keymap(M.buf_handle, 't', close, '<c-\\><c-n>:call floatLf#delete_lf_buffer()<CR>', opts)
  api.nvim_buf_set_keymap(M.buf_handle, 't', open, '<c-\\><c-n>:lua lf.lfOpenFile()<CR>', opts)
  api.nvim_buf_set_keymap(M.buf_handle, 't', split, '<c-\\><c-n>:lua lf.lfSplitFile()<CR>', opts)
  api.nvim_buf_set_keymap(M.buf_handle, 't', vsplit, '<c-\\><c-n>:lua lf.lfVsplitFile()<CR>', opts)
  api.nvim_buf_set_keymap(M.buf_handle, 't', tab, '<c-\\><c-n>:lua lf.lfTabFile()<CR>', opts)
end

function M.focusPrevWindow()
  api.nvim_set_current_win(M.win_prev)
end

function M.refocusFloatingWindow()
  api.nvim_set_current_win(M.win_handle)
  api.nvim_command("startinsert")
end

M.setMapping()

return M
