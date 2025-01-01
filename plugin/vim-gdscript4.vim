scriptencoding utf-8

if exists('g:loaded_vim_gdscript')
    finish
endif

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

let g:loaded_vim_gdscript = 1
