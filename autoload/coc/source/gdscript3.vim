function! coc#source#gdscript3#init() abort
  return {
        \'shortcut': 'GDS3',
        \'filetypes': ['gdscript3'],
        \'triggerCharacters': ['.'],
        \}
endfunction

function! coc#source#gdscript3#complete(options, callback) abort
  let items = GDScriptComplete(0, a:options.input)
  call a:callback(items)
endfunction
