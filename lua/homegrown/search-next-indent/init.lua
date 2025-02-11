local M = {}

local defaults = {
  mappings = {
    prev = '<M-,>',
    next = '<M-.>',
  },
}

local function jump_prev()
  local indent = vim.fn.matchstr(vim.fn.getline '.', [[^\s*]])
  local pattern = '^' .. indent .. [[\%<]] .. vim.fn.line '.' .. 'l\\S'
  vim.fn.search(pattern, 'be')
end

local function jump_next()
  local indent = vim.fn.matchstr(vim.fn.getline '.', [[^\s*]])
  local pattern = '^' .. indent .. [[\%>]] .. vim.fn.line '.' .. 'l\\S'
  vim.fn.search(pattern, 'e')
end

-- Setup function with default options
function M.setup(opts)
  opts = vim.tbl_deep_extend('force', defaults, opts or {})

  -- Define the keymaps with descriptions
  if opts.mappings.prev then
    vim.keymap.set({ 'n', 'v', 'x' }, opts.mappings.prev, jump_prev, {
      noremap = true,
      silent = true,
      desc = 'Jump to previous block at same indent',
    })
  end

  if opts.mappings.next then
    vim.keymap.set({ 'n', 'v', 'x' }, opts.mappings.next, jump_next, { noremap = true, silent = true, desc = 'Jump to next block at same indent' })
  end
end

return M
