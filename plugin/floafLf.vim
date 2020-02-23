if exists('g:loaded_floatLf') | finish | endif

let s:save_cpo = &cpo
set cpo&vim


if ! exists('g:floatLf_autoclose')
    " disable autoclose by defualt
    let g:floatLf_autoclose = 0
endif

if ! exists('g:floatLf_lf_close')
    " mapping of closing lf
    let g:floatLf_lf_close = 'q'
endif

if ! exists('g:floatLf_lf_open')
    " mapping of closing lf
    let g:floatLf_lf_open = '<c-o>'
endif

if ! exists('g:floatLf_lf_split')
    " mapping of open file in split in lf
    let g:floatLf_lf_split = '<c-x>'
endif

if ! exists('g:floatLf_lf_vsplit')
    " mapping of open file in vsplit in lf
    let g:floatLf_lf_vsplit = '<c-v>'
endif

if ! exists('g:floatLf_lf_tab')
    " mapping of open file in tab in lf
    let g:floatLf_lf_tab = '<c-t>'
endif

lua lf = require "lf"
lua term = require "floatTerm"

command! -nargs=0 LfRefocus  lua require'floatTerm'.refocusFloatingWindow()
command! -nargs=0 LfToggle lua require'lf'.toggleLf()
" command! -nargs=0 LfOpen lua require'lf'.lfOpenFile()
" command! -nargs=0 LfSplit lua require'lf'.lfSplitFile()
" command! -nargs=0 LfVsplit lua require'lf'.lfVsplitFile()
" command! -nargs=0 LfTab lua require'lf'.lfTabFile()


let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_floatLf = 1


