if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin=1

setlocal include=\\v.*res\\:\/\/
execute 'setlocal path^=' . GDScriptGetProjectDir()
setlocal foldlevel=99
setlocal foldmethod=syntax
