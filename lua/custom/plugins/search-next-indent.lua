return {
  dir = vim.fn.stdpath 'config' .. '/lua/homegrown/search-next-indent',
  lazy = false, -- Load on startup
  config = function()
    require('homegrown.search-next-indent').setup()
  end,
}
