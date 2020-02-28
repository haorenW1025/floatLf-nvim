local term = require 'floatTerm'
local api = vim.api
local M = {}

function M.toggleLf()
  if term.buf_handle == nil or not api.nvim_buf_is_valid(term.buf_handle) then
    term.createFloatingWindow()
    api.nvim_command("startinsert")
    M.jobID = api.nvim_call_function("floatLf#wrap_term_open", {})
  else
    api.nvim_call_function("floatLf#delete_lf_buffer", {})
  end
end

function M.toggleLf_current_buf()
  if term.buf_handle == nil or not api.nvim_buf_is_valid(term.buf_handle) then
    local buf_path = api.nvim_call_function('expand', {'%:p:h'})
    term.createFloatingWindow()
    api.nvim_command("startinsert")
    M.jobID = api.nvim_call_function("floatLf#wrap_term_open_current_buf", {buf_path})
  else
    api.nvim_call_function("floatLf#delete_lf_buffer", {})
  end
end

function M.lfOpenFile()
  api.nvim_call_function("floatLf#wrap_open", {M.jobID})
  if api.nvim_get_var("floatLf_autoclose") == 1 then
    M.toggleLf()
  end
end

function M.lfSplitFile()
  api.nvim_call_function("floatLf#wrap_split", {M.jobID})
  if api.nvim_get_var("floatLf_autoclose") == 1 then
    M.toggleLf()
  end
end

function M.lfVsplitFile()
  api.nvim_call_function("floatLf#wrap_vsplit", {M.jobID})
  if api.nvim_get_var("floatLf_autoclose") == 1 then
    M.toggleLf()
  end
end

function M.lfTabFile()
  api.nvim_call_function("floatLf#wrap_tab", {M.jobID})
  if api.nvim_get_var("floatLf_autoclose") == 1 then
    M.toggleLf()
  end
end


return M
