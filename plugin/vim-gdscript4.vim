scriptencoding utf-8

if exists('g:loaded_vim_gdscript')
    finish
endif
let g:loaded_vim_gdscript = 1


" Configurable settings {{{

" Whether to highlight node references wrapped in strings as a whole (1) or use string literal highlighting (0).
" E.g. %"some node with spaces" could be highlighted as a whole or individually with
" % -> gdNode and "some node with spaces" -> gdString.
let g:gdscript_highlight_whole_string_node_references = get(g:, 'gdscript_highlight_whole_string_node_references', 1)

" Whether to use Vim's default GDScript indent (0) or Python indent (1).
" Both are very similar by default but Python indent is more configurable.
" When using https://github.com/Vimjas/vim-python-pep8-indent, set this option to 1.
let g:gdscript_use_python_indent = get(g:, 'gdscript_use_python_indent', 0)

" }}}

augroup au_godot_res_handling
    autocmd!
    autocmd BufReadCmd res://* exe "bd!|edit ".substitute(expand("<afile>"),"res://*","","") | doauto BufRead
augroup END

let g:tagbar_type_gdscript = {
            \ 'ctagsargs' : '-f- --format=2 --excmd=pattern --fields=nksSa --extras= --sort=no --language-force=gdscript',
            \ 'kinds': [
                \ 'c:classes',
                \ 'e:enums',
                \ 'C:constants',
                \ 's:signals',
                \ 'v:variables',
                \ 'm:methods',
            \ ],
            \ 'sro': '.',
            \ 'kind2scope': {
                \ 'c': 'class',
                \ 'e': 'enum',
            \ }
        \ }
