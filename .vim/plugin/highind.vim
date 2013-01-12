if exists('g:highind_loaded')
    finish
endif
let g:highind_loaded = 1


if !exists('g:highind_bgcolor')
    let g:highind_bgcolor = 238
endif

if !exists('g:highind_enable_at_startup')
    let g:highind_enable_at_startup = 0
endif

if g:highind_enable_at_startup
    call highind#enable()
endif
