# Description
GDScript is the primary scripting language used by the [Godot Game Engine](https://godotengine.org/).

This project has been forked and adapted from [Rubonnek/vim-gdscript3](https://github.com/Rubonnek/vim-gdscript3) in the following ways:
- Support for Godot 4.x GDScript flavor
- Use existing filetype and syntax definitions bundled with Vim
- Extend and improve Vim's existing filetype and syntax definitions where useful
- Fix and integrate [Tagbar](https://github.com/preservim/tagbar) support
- Add some [configuration settings](#configuration) for tweaking highlighting and indent behavior


# Installation
## Using [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'mphe/vim-gdscript4'
```


# Configuration

The plugin defines a few settings related to highlighting and indentation.
See [vim-gdscript4.vim](plugin/vim-gdscript4.vim#L9).

# Completion, Go To Definition and Error Linting

Completion is not part of this plugin but can be enabled using the Godot Language Server.

## Using [coc.nvim](https://github.com/neoclide/coc.nvim)

[See also here](https://github.com/neoclide/coc.nvim/wiki/Language-servers#godot) (Port has been changed to 6005 in Godot 4.x).

```json
"languageserver": {
    "godot": {
        "host": "127.0.0.1",
        "filetypes": ["gd", "gdscript"],
        "port": 6005
    },
}
```

## Using [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)

[See also here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#gdscript).

```lua
require'lspconfig'.gdscript.setup{}
```



# Screenshot

![Screenshot](screenshot.png)

*Colorscheme: [Solarized](https://github.com/ishan9299/nvim-solarized-lua)*


# License
MIT
