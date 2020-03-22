function! floatLf#on_exit(job_id, code, event) dict
    if a:code == 0
        call floatLf#delete_lf_buffer()
    endif
endfunction

function! floatLf#delete_lf_buffer()
    for n in nvim_list_bufs()
        if ! buflisted(n)
            let name = bufname(n)
            if name == '[Scratch]' ||
              \ matchend(name, ":lf")
                call CleanupBuffer(n)
            endif
        endif
    endfor
endfunction

function! CleanupBuffer(buf)
    if bufexists(a:buf)
        silent execute 'bwipeout! '.a:buf
    endif
endfunction

function! floatLf#wrap_term_open()
    let jobID = termopen('lf', {'on_exit': function('floatLf#on_exit')})
    return jobID
endfunction

function! floatLf#wrap_term_open_current_buf(path)
    let jobID = termopen('lf '.(a:path), {'on_exit': function('floatLf#on_exit')})
    return jobID
endfunction

function! floatLf#get_callback()
    if g:floatLf_autoclose == 1
        return "-c 'call floatLf#delete_lf_buffer()'"
    endif
    return " -c 'LfRefocus' "
endfunction

" HACK use two <CR> to prevent unexpected behavior
function! floatLf#wrap_open(job_id)
    let callback = floatLf#get_callback()
    call chansend(a:job_id, "%%nvr  --servername $(nvr --serverlist) -cc 'LfFocusPrev' " . callback . " $f \<CR>")
endfunction

function! floatLf#wrap_split(job_id)
    let callback = floatLf#get_callback()
    call chansend(a:job_id, "%%nvr --servername $(nvr --serverlist) -cc 'LfFocusPrev' " . callback . " -o $f \<CR>")
endfunction

function! floatLf#wrap_vsplit(job_id)
    let callback = floatLf#get_callback()
    call chansend(a:job_id, "%%nvr --servername $(nvr --serverlist) -cc 'LfFocusPrev' " . callback . " -O $f \<CR>")
endfunction

function! floatLf#wrap_tab(job_id)
    let callback = floatLf#get_callback()
    call chansend(a:job_id, "%%nvr --servername $(nvr --serverlist) -cc 'LfFocusPrev' " . callback . " -p $f \<CR>")
endfunction
