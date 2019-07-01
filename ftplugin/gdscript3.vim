if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin=1

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal formatoptions+=croql formatoptions-=t
setlocal isfname+=:
setlocal include=\\v^[^#]*(load\|preload\|extends\\s*[\"\'])
setlocal includeexpr=substitute(v:fname,'res\\\:\/\/\\(\.\*\\)','\\1','g')
execute 'setlocal path^=' . GDScriptGetProjectDir()
setlocal omnifunc=GDScriptComplete
setlocal foldlevel=99
setlocal foldmethod=syntax
