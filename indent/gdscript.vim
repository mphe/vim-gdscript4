if exists('b:gdscript_did_indent')
    finish
endif
let b:gdscript_did_indent = 1

let s:path = expand('<sfile>:p:h')
" echo s:path

if g:gdscript_use_python_indent
    runtime! indent/python.vim
endif
