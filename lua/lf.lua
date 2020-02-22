local term = require 'floatTerm'
local api = vim.api
local M = {}

function M.toggleLf()
  term.createFloatingWindow()
  api.nvim_command("startinsert")
  M.jobID = api.nvim_call_function("floatLf#wrap_term_open", {})
  print(M.jobID)
end

function M.lfOpenFile()
  api.nvim_call_function("floatLf#wrap_open", {M.jobID})
end

function M.lfSplitFile()
  api.nvim_call_function("floatLf#wrap_split", {M.jobID})
end

function M.lfVsplitFile()
  api.nvim_call_function("floatLf#wrap_vsplit", {M.jobID})
end

function M.lfTabFile()
  api.nvim_call_function("floatLf#wrap_tab", {M.jobID})
end

return M
