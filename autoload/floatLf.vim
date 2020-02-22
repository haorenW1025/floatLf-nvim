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

function! floatLf#wrap_term_open()
    let jobID = termopen('lf', {'on_exit': function('floatLf#on_exit')})
    return jobID
endfunction

function! floatLf#wrap_open(job_id)
    " echo a:cmd
    echo a:job_id
    call chansend(a:job_id, "\<CR> nvr -c 'LfRefocus' -l $f \<CR>")
endfunction

function! floatLf#wrap_split(job_id)
    " echo a:cmd
    call chansend(a:job_id, "\<CR> nvr -c 'LfRefocus' -l -o $f \<CR>")
endfunction

function! floatLf#wrap_vsplit(job_id)
    " echo a:cmd
    call chansend(a:job_id, "\<CR> nvr -c 'LfRefocus' -l -O $f \<CR>")
endfunction

function! floatLf#wrap_tab(job_id)
    " echo a:cmd
    call chansend(a:job_id, "\<CR> nvr -c 'LfRefocus' -l -p $f \<CR>")
endfunction
