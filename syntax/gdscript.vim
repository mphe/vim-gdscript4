" Syntax file for GDScript

if exists('b:current_syntax')
    finish
endif
let b:current_syntax = 'gdscript'


" Whether to highlight node references wrapped in strings as a whole (1) or use string literal highlighting (0).
" E.g. %"some node with spaces" could be highlighted as a whole or individually with
" % -> gdNode and "some node with spaces" -> gdString.
let g:gdscript_highlight_whole_string_node_references = get(g:, 'gdscript_highlight_whole_string_node_references', 1)


let s:save_cpo = &cpoptions
set cpoptions&vim

syn keyword gdConditional if elif else match
syn keyword gdRepeat      for while
syn keyword gdOperator    and or not is in as
syn match   gdOperator    "\V&&\|||\|!\|&\|^\||\|~\|*\|/\|%\|+\|-\|=\|<\|>\|:\|$"
syn match   gdDelimiter   "\V(\|)\|[\|]\|{\|}\|@"
syn keyword gdStatement   break continue pass return yield breakpoint
syn keyword gdKeyword     extends signal self class_name void const enum super
                        \ var setget assert rpc sync set get await
                        \ remote master puppet remotesync mastersync puppetsync
syn match   gdKeyword     "\v^\s*((static\s*)=func\s+|class\s+)"
                        \ nextgroup=gdFunction skipwhite
syn keyword gdBoolean     true false

syn match   gdMember   "\v<(\.)@<=[a-z_]+\w*>"
syn match   gdFunction "\v<\w*>\s*(\()@="
syn match   gdDecorator "\v(\@)@1<=<\w+>"
syn match   gdSignal "\v(<signal>\s+)@<=<\w+>"
syn match   gdSetGet "\v(<setget>\s+)@<=<\w+>"
syn match   gdSetGet "\v(<setget>\s+\w*\s*,\s*)@<=<\w+>"

syn keyword gdNull      null
syn keyword gdClass     int float bool
syn match   gdClass     "\v<\u\w+>"
syn match   gdConstant  "\v<[A-Z_]+[A-Z0-9_]*>"
syn keyword gdClass     AABB IP JSON OS RID

if g:gdscript_highlight_whole_string_node_references
    syn region  gdNode start='\v[\$%]\"' end='\v\"'
    syn region  gdNode start='\v[\$%]\'' end='\v\''
else
    syn match   gdNode      "\v[\$%]" nextgroup=gdString
endif

syn match   gdNode      "\v[\$%]\w+"

syn region  gdString      start='\v\"' end='\v\"' contains=gdFormat,gdEscapeError,gdEscape
syn region  gdString      start='\v\'' end='\v\'' contains=gdFormat,gdEscapeError,gdEscape
syn match   gdEscapeError "\v\\."              contained
syn match   gdEscapeError "\v\\u.{,3}"         contained
syn match   gdEscape      "\v\\[abfnrtv\\'"]"  contained
syn match   gdEscape      "\v\\u[0-9]{4}"      contained

syn match   gdFormat "\v\%\%" contained
syn match   gdFormat "\v\%[+-]=(\d*|\*)=\.=(\d*|\*)=[scdoxXf]" contained

syn match   gdNumber      "\v<\d+(\.)@!>"
syn match   gdNumber      "\v<0x\x+(\.)@!>"
syn match   gdFloat       "\v<\d*\.\d+(\.)@!>"
syn match   gdFloat       "\v<\d*\.=\d+(e-=\d+)@="
syn match   gdExponent    "\v(\d*\.=\d+)@<=e-=\d+>"

syn match   gdComment "\v#.*$" contains=@Spell
syn keyword gdTodo    TODO FIXME XXX NOTE BUG HACK OPTIMIZE containedin=gdComment
syn match   gdTodo    '\v\@deprecated|\@experimental|\@tutorial' containedin=gdComment

syn region gdFunctionFold
  \ start="\v^\z(\s*)%(%(static\s+)=func|class)>"
  \ end="\v\ze%(\s*\n)+%(\z1\s)@!."
  \ fold transparent

syn region gdFold
  \ matchgroup=gdComment
  \ start='#.*{{{.*$'
  \ end='#.*}}}.*$'
  \ fold transparent

hi def link gdConditional Conditional
hi def link gdRepeat      Repeat
hi def link gdOperator    Operator
hi def link gdDelimiter   Delimiter
hi def link gdStatement   Statement
hi def link gdKeyword     Keyword
hi def link gdBoolean     Boolean
hi def link gdDecorator   Function

hi def link gdMember   Identifier
hi def link gdFunction Function
hi def link gdSignal   Function
hi def link gdSetGet   Function

hi def link gdNull     Constant
hi def link gdClass    Type
hi def link gdConstant Constant
hi def link gdNode     Macro

hi def link gdString   String
hi def link gdEscape   Special
hi def link gdFormat   Special
hi def link gdNumber   Number
hi def link gdFloat    Float
hi def link gdExponent Special

hi def link gdEscapeError Error

hi def link gdComment Comment
hi def link gdTodo    Todo

let &cpoptions = s:save_cpo
unlet s:save_cpo
