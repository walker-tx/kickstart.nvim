# search-next-indent.nvim

A Neovim plugin that allows you to quickly navigate between blocks of code at
the same indentation level.

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  'walker0/search-next-indent.nvim',
  config = function()
    require('search-next-indent').setup()
  end
}
```

## Configuration

The plugin can be configured by passing options to the setup function. Here are
the default settings:

```lua
require('search-next-indent').setup({
  mappings = {
    prev = '<M-,>', -- Jump to previous block at same indent
    next = '<M-.>'  -- Jump to next block at same indent
  }
})
```

### Customizing Keymaps

You can change the default keymaps by passing different values:

```lua
require('search-next-indent').setup({
  mappings = {
    prev = '[i',  -- change to whatever you prefer
    next = ']i'   -- change to whatever you prefer
  }
})
```

To disable a mapping, set it to `false`:

```lua
require('search-next-indent').setup({
  mappings = {
    prev = false,  -- disable previous mapping
    next = ']i'    -- only use next mapping
  }
})
```

## Usage

By default, the plugin provides two keymaps:

- `Alt-,`: Jump to the previous block at the same indentation level
- `Alt-.`: Jump to the next block at the same indentation level

These keymaps work in:

- Normal mode
- Visual mode
- Visual Block mode
