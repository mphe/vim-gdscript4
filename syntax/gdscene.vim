" Syntax file for Godot's tscn, tres and project.godot files

if exists ("b:current_syntax")
    finish
endif
let b:current_syntax = "gdscene"

let s:save_cpo = &cpo
set cpo&vim

syn keyword gdKeyword    contained gd_scene ext_resource sub_resource node
                                 \ connection gd_resource resource
syn keyword gdBoolean    contained false true
syn match   gdDelimiter  contained display "\V(\|)\|[\|]\|{\|}"
syn match   gdOperator   contained display "\V=\|:"
syn match   gdNumber     contained display "\v-?\d+"
syn match   gdFloat      contained display "-\?\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\="
syn match   gdFloat      contained display "\.\d\+\(e[-+]\=\d\+\)\=[fl]\=\>"
syn match   gdFloat      contained display "-\?\d\+e[-+]\=\d\+[fl]\=\>"
syn match   gdArray      contained display "\v[.*]"
syn match   gdIdentifier contained display "\v\h\w+"
syn region  gdString     contained start="\"" end="\""

syn region  gdSection    start="^\[" end="^\["me=e-1 transparent fold
syn match   gdHeader    "\v^\[.*\]"        contained containedin=gdSection contains=gdKeyword,gdString,gdNumber
syn match   gdValue      "\v[=:].*"hs=s+1  contains=ALLBUT,gdHeader
syn region  gdDictionary start="{" end="}" contains=gdString,gdValue,gdDelimiter keepend transparent fold

hi def link gdOperator   Operator
hi def link gdDelimiter  Delimiter
hi def link gdKeyword    Keyword
hi def link gdHeader     Type
hi def link gdString     String
hi def link gdIdentifier Identifier
hi def link gdArray      Constant
hi def link gdNumber     Number
hi def link gdFloat      Number
hi def link gdBoolean    Boolean

let &cpo = s:save_cpo
unlet s:save_cpo
