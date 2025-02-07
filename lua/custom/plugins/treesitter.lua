-- Great tutorial post on all of this:
-- -- https://www.josean.com/posts/nvim-treesitter-and-textobjects
return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'python',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          node_decremental = '<bs>',
          scope_incremental = false,
        },
      },
      -- Special selectors and stuff (methods, functions, classes, etc)
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['am'] = {
              query = '@function.outer',
              desc = 'Select [A]round a [M]ethod/Func',
            },
            ['if'] = {
              query = '@function.inner',
              desc = 'Select [I]nside a [M]ethod/Func',
            },
            ['al'] = {
              query = '@loop.outer',
              desc = 'Select [A]round a [L]oop',
            },
            ['il'] = {
              query = '@loop.inner',
              desc = 'Select [I]nside a [L]oop',
            },
            ['ai'] = {
              query = '@conditional.outer',
              desc = 'Select [A]round a cond[i]tional',
            },
            ['ii'] = {
              query = '@conditional.inner',
              desc = 'Select [I]nside a cond[i]tional',
            },
            ['ac'] = {
              query = '@class.outer',
              desc = 'Select [A]round a [C]lass',
            },
            ['ic'] = {
              query = '@class.inner',
              desc = 'Select [I]nside a [C]lass',
            },
            ['ao'] = {
              query = '@local.scope',
              query_group = 'locals',
              desc = 'Select [A]round a sc[o]pe',
            },
            ['io'] = {
              query = '@local.scope',
              query_group = 'locals',
              desc = 'Select [I]nside a sc[o]pe',
            },
          },
        },
        -- Special movements and stuff
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = { query = '@function.outer', desc = 'Next [M]ethod/Function' },
            [']c'] = { query = '@class.outer', desc = 'Next [C]lass' },
            [']l'] = { query = '@loop.outer', desc = 'Next [L]oop' },
            [']i'] = { query = '@conditional.outer', desc = 'Next cond[i]tional' },
            [']o'] = { query = '@local.scope', query_group = 'locals', desc = 'Next sc[o]pe' },
          },
          goto_previous_start = {
            ['[m'] = { query = '@function.outer', desc = 'Previous [M]ethod/Function' },
            ['[c'] = { query = '@class.outer', desc = 'Previous [C]lass' },
            ['[l'] = { query = '@loop.outer', desc = 'Previous [L]oop' },
            ['[i'] = { query = '@conditional.outer', desc = 'Previous cond[i]tional' },
            ['[o'] = { query = '@local.scope', query_group = 'locals', desc = 'Previous sc[o]pe' },
          },
        },
        lsp_interop = {
          enable = true,
          border = 'single',
          floating_preview_opts = {},
          peek_definition_code = {
            ['<leader>pf'] = { query = '@function.outer', desc = '[P]eek [F]unction Definition' },
            ['<leader>pc'] = { query = '@class.outer', desc = '[P]eek [C]lass Definition' },
          },
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
      vim.treesitter.language.register('markdown', 'mdx')
    end,
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-treesitter' },
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-treesitter' },
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        -- multiwindow = false, -- Enable multiwindow support.
        -- max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        -- min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        -- line_numbers = true,
        -- multiline_threshold = 20, -- Maximum number of lines to show for a single context
        -- trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = 'topline', -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- -- Separator between context and content. Should be a single character string, like '-'.
        -- -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        -- separator = nil,
        -- zindex = 20, -- The Z-index of the context window
        -- on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },
}
