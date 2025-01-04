" Extends Vim's default syntax definition

if exists ('b:gdresource_did_syntax')
    finish
endif
let b:gdresource_did_syntax = 1

let s:save_cpo = &cpo
set cpo&vim

syn match gdResourceComment ";.*" contains=@Spell
syn match gdResourceClass '\v<\u\w+>' containedin=gdResourceAttributeValue

hi def link gdResourceComment Comment
hi def link gdResourceClass Type

let &cpo = s:save_cpo
unlet s:save_cpo
