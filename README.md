# Description
GDScript is the primary scripting language used by the [Godot Game Engine](https://godotengine.org/).

This plugin adds filetype set, syntax highlighting, snippets and [tagbar](https://github.com/preservim/tagbar) support for Godot 4.x.

The project has been forked and adapted from [Rubonnek/vim-gdscript3](https://github.com/Rubonnek/vim-gdscript3).


# Installation
## Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'mphe/vim-gdscript4'
```

# Screenshot

![Screenshot](screenshot.png)

*Colorscheme: [base16-eighties](https://github.com/chriskempson/base16-vim)*

# Completion, Go To Definition and Error Linting

## [coc.nvim](https://github.com/neoclide/coc.nvim) configuration

```json
  "languageserver": {
      "godot": {
        "host": "127.0.0.1",
        "filetypes": ["gd", "gdscript"],
        "port": 6008
      }
    }
```

# License
MIT
