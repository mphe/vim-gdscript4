if exists('b:gdscript_did_ftplugin')
    finish
endif
let b:gdscript_did_ftplugin=1

setlocal comments=:##,:#
setlocal formatoptions+=croql formatoptions-=t
setlocal include=\\v^[^#]*([^#A-Za-z0-9_]\|^)((pre)?load\\s*\\(\\s*\|extends\\s*)[\"\'](res\\:\/\/)?
