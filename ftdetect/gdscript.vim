" Set filetype
autocmd BufRead,BufNewFile *.gd set filetype=gdscript
autocmd BufRead,BufNewFile *.gdscript set filetype=gdscript
autocmd BufRead,BufNewFile *.gdscript4 set filetype=gdscript

" Automatically switch res:// to the root of the folder
autocmd BufReadCmd res://* exe "bd!|edit ".substitute(expand("<afile>"),"res://*","","") | doauto BufRead
