" Extends Vim's default syntax definition

if exists('b:gdshader_did_syntax')
    finish
endif
let b:gdshader_did_syntax = 1

let s:save_cpo = &cpo
set cpo&vim

" Change highlight for builtins from Identifier to Constant.
" Some builtins are constants, some are not. I think this fits better generally.
hi link gdshaderBuiltin Constant

let &cpo = s:save_cpo
unlet s:save_cpo
