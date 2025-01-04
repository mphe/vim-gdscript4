if exists('b:gdresource_did_ftplugin')
    finish
endif
let b:gdresource_did_ftplugin=1

setlocal include=\\v.*path\\=\"(res\\:\/\/)?
setlocal foldlevel=99
setlocal foldmethod=syntax
