function! highind#get_pattern(column)
    let l:pattern = '^\s*\%' . a:column . 'v\zs.*\%' . (a:column+1) . 'v\ze'
    return l:pattern
endfunction

function! highind#clear_highlight()
    if exists('b:id') && b:id != -1
        call matchdelete(b:id)
        let b:id = -1
    endif
endfunction

function! highind#set_highlight(column)
    let l:pattern = highind#get_pattern(a:column)
    let b:id = matchadd('HighInd', l:pattern)
endfunction

function! highind#update()
    if s:enabled
        call highind#clear_highlight()
        call highind#set_highlight(indent('.') + 1)
    endif
endfunction

function! highind#buffer_init()
    call highind#clear_highlight()
    let b:id = -1
    call highind#update()
endfunction

function! highind#buffer_final()
    " call highind#clear_highlight()
    if exists('b:id')
        unlet b:id
    endif
endfunction

function! highind#enable()
    if exists('s:enabled') && s:enabled
        return
    endif

    let s:enabled = 1
    execute 'hi HighInd ctermbg=' . g:highind_bgcolor

    call highind#buffer_init()

    augroup highind
        autocmd!
        autocmd BufWinEnter * call highind#buffer_init()
        autocmd BufWinLeave * call highind#buffer_final()
        autocmd CursorMoved,CursorMovedI * call highind#update()
    augroup END
endfunction

function! highind#disable()
    if !exists('s:enabled') || !s:enabled
        return
    endif

    let s:enabled = 0
    call highind#buffer_final()

    highlight clear HighInd

    augroup highind
        autocmd!
    augroup END
endfunction

