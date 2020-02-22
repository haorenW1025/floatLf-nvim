if exists('g:loaded_floatLf') | finish | endif

let s:save_cpo = &cpo
set cpo&vim



command! -nargs=0 LfRefocus  lua require'floatTerm'.refocusFloatingWindow()
command! -nargs=0 LfToggle lua require'lf'.toggleLf()
command! -nargs=0 LfOpen lua require'lf'.lfOpenFile()
command! -nargs=0 LfSplit lua require'lf'.lfSplitFile()
command! -nargs=0 LfVsplit lua require'lf'.lfVsplitFile()
command! -nargs=0 LfTab lua require'lf'.lfTabFile()


let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_floatLf = 1


