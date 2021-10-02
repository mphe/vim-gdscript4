# Description
GDScript is the primary scripting language used by the [Godot Game Engine](https://godotengine.org/).

This plugin adds filetype set, syntax highlighting, snippets and ctags for the most recent version (3.2 at the time of writing).

# Installation
Using [vim-plug](https://github.com/junegunn/vim-plug):

    Plug 'clktmr/vim-gdscript3'
    
Or any other plugin manager of your choice.

# Screenshot
![Screenshot](screenshot.png)

*Colorscheme: [base16-eighties](https://github.com/chriskempson/base16-vim)*

# Completion, Go To Definition and Error Linting

## [coc.nvim](https://github.com/neoclide/coc.nvim)  configuration
```json
  "languageserver": {
      "godot": {
        "host": "127.0.0.1",
        "filetypes": ["gd", "gdscript3"],
        "port": 6008
      }
    }
```
## [ALE](https://github.com/dense-analysis/ale) configuration
```vimscript
if exists(':ALEInfo')
	call ale#linter#Define('gdscript3', {
	\   'name': 'godot',
	\   'lsp': 'socket',
	\   'address': '127.0.0.1:6008',
	\   'project_root': 'project.godot',
	\})
endif
```
# License
MIT
