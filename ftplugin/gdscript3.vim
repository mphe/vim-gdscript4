if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin=1

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal formatoptions+=croql formatoptions-=t
setlocal include=\\v^[^#]*([^#A-Za-z0-9_]\|^)((pre)?load\\s*\\(\\s*\|extends\\s*)[\"\'](res\\:\/\/)?
setlocal foldlevel=99
setlocal foldmethod=syntax
