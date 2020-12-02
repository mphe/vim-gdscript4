" Set filetype
autocmd BufRead,BufNewFile *.gd set filetype=gdscript3
autocmd BufRead,BufNewFile *.gdscript set filetype=gdscript3
autocmd BufRead,BufNewFile *.gdscript3 set filetype=gdscript3

" Automatically switch res:// to the root of the folder
autocmd BufReadCmd res://* exe "bd!|edit ".substitute(expand("<afile>"),"res://*","","") | doauto BufRead
