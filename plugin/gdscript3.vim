if exists("g:gdscript3_loaded")
    finish
endif
let g:gdscript3_loaded=1

au BufReadCmd res://* exe "bd!|edit ".substitute(expand("<afile>"),"res://*","","") | doauto BufRead

if !has("python3") && !has("python")
    finish
endif

if has("python3")
    let s:pyfile_cmd = "py3file"
    let s:py_cmd = "py3"
else
    let s:pyfile_cmd = "pyfile"
    let s:py_cmd = "py"
endif

execute s:pyfile_cmd . " " . expand('<sfile>:p:h') . "/../python/init.py"


fun! GDScriptOpenDocumentation(keyword)
    let url = "https://docs.godotengine.org/en/stable/"

    " If the cursor is on the keyword we can try to do a context aware keyword
    " lookup. (e.g. The keyword may be method a method with multiple
    " implementations, so first get the corresponding class and then open the
    " correct docs.) 
    " Otherwise we have only the keyword as a parameter and our best guess is to
    " just search the docs for the keyword.
    if keyword ==# expand('<cword>')
        let decl_ns = call GDScriptGetDeclNamespace()
    else
        let url .= "search.html?q=" . a:keyword
        call system("echo " . l:url . " | xargs xdg-open")
    endif
endfun
command -nargs=1 KeywordprgGDScript3 :call GDScriptOpenDocumentation("<args>")


fun! GDScriptGetDeclNamespace()
    execute s:py_cmd . " gdscript_get_decl_namespace()"
    if exists("gdscript_decl_namespace")
        return gdscript_decl_namespace
    else
        return []
    endif
endfun
command GDScriptGetDeclNamespace :echo GDScriptGetDeclNamespace()


fun! GDScriptComplete(findstart, base)
    if a:findstart == 1
        let line = getline('.')
        let start = col('.') - 1
        " Treat '-' as part of the word when completing in a string.
        if synIDattr(synID(line('.'), col('.')-1, 1), 'name') ==# "gdString"
            let pattern = '[-a-zA-Z0-9_]'
        else
            let pattern = '[a-zA-Z0-9_]'
        endif
        while start > 0 && line[start - 1] =~ pattern
            let start -= 1
        endwhile
        return start
    else
        execute s:py_cmd . " gdscript_complete()"
        if exists("gdscript_completions")
            return gdscript_completions
        else
            return []
        endif
    endif
endfun


fun! GDScriptGetProjectDir()
    execute s:py_cmd . ' vim.command(''let gdscript_project_root="'' + util.get_project_dir() + ''\"'')'
    return gdscript_project_root
    if exists("gdscript_project_root")
    else
        return ""
    endif
endfun


" Configure for common completion frameworks.

" Deoplete
if &rtp =~ 'deoplete.nvim'
    call deoplete#custom#option('sources', {
        \ 'gdscript3': ['omni'],
    \ })
    call deoplete#custom#var('omni', 'input_patterns', {
        \ 'gdscript3': [
            \ '\.|\w+',
            \ '\bextends\s+',
            \ '\bexport\(',
            \ '\bfunc\s+',
            \ '"res://[^"]*'
        \ ]
    \ })
endif

" SuperTab
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" YouCompleteMe
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.gdscript3 = [
    \'re!\w+',
    \'.',
    \'re!\bextends\s+',
    \'re!\bexport\(',
    \'re!\bfunc\s+',
    \'re!"res://[^"]*'
    \]



" Configure echodoc
if &rtp =~ 'echodoc'
    let s:echodoc_dict = { "name": "gdscript3", "rank": 9 }
    fun! s:echodoc_dict.search(text)
        execute s:py_cmd . " echodoc_search()"
        if exists("echodoc_search_result")
            return echodoc_search_result
        else
            return []
        endif
    endfun
    call echodoc#register('gdscript3', s:echodoc_dict)

    " Reset echodoc cache when exiting insert mode.
    " This fixes an issue where the function signature wouldn't re-appear
    " after exiting and re-entering insert mode.
    au InsertLeave * let b:prev_echodoc = []
endif

" Configure Syntastic checker
let g:syntastic_gdscript3_checkers = ['godot_server']
