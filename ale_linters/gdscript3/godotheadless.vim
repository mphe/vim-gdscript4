" Author: Timur Celik - https://github.com/clktmr
" Description: Uses Godot headless for linting

call ale#Set('gdscript3_godotheadless_executable', 'godotheadless')

function! ale_linters#gdscript3#godotheadless#GetCommand(buffer) abort
    return '%e -s %s --check-only'
endfunction

function! ale_linters#gdscript3#godotheadless#Handle(buffer, lines) abort
    let l:pattern = '^.*SCRIPT ERROR: \(.*\)\n.\+:\(\d\+\).*\n'
    let l:output = []

    for l:match in ale#util#GetMatches(join(a:lines, "\n"), l:pattern)
        let msg = substitute(l:match[1], '\e\[[0-9;]\+[mK]', '', 'g')
        call add(l:output, {
        \   'lnum': l:match[2],
        \   'col': 0,
        \   'text': msg,
        \   'type': 'E',
        \})
    endfor

    return l:output
endfunction

call ale#linter#Define('gdscript3', {
\   'name': 'godotheadless',
\   'executable': {b -> ale#Var(b, 'gdscript3_godotheadless_executable')},
\   'command': function('ale_linters#gdscript3#godotheadless#GetCommand'),
\   'output_stream': 'stderr',
\   'callback': 'ale_linters#gdscript3#godotheadless#Handle',
\})
