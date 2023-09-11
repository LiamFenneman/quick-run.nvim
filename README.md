<div align="center">

# Quick Run
<sub>**Set a command to run when you press the Quick Run key.**</sub>

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

</div>

## Use Case

You have that one command for building or running your project and want to have
a keymap set, but you don't want to change your Neovim config or worry about
different keymaps for different projects.

With Quick Run you set the command to run, then use the predefined keymap
(*default \<F5\>*) to run it whenever you want.

## Installation
Using [lazy.nvim](https://github.com/folke/lazy.nvim):
```lua
{ 'LiamFenneman/quick-run.nvim', opts = {} },
```

Using [packer](https://github.com/wbthomason/packer.nvim):
```lua
use 'LiamFenneman/quick-run.nvim'
```

## Quick Configuration

```lua
require('quick-run').setup({})
```

## Default Configuration

```lua
require('quick-run').setup({
    default_cmd = 'echo "Hello World"',
    mappings = {
        quick_run = '<F5>',
    },
    callbacks = {
        on_stdout = function(_, data, _)
            vim.api.nvim_out_write(table.concat(data, '\n'))
        end,
        on_stderr = function(_, data, _)
            vim.api.nvim_err_write(table.concat(data, '\n'))
        end,
        on_exit = function(_, data, _) end,
    },
})
```
