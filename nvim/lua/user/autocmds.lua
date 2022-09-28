--https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
local group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {})
local group_ws = vim.api.nvim_create_augroup('WhitespaceTrails', {})
vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group=group,
  callback = function()
    vim.opt.foldlevel = 20
    vim.opt.foldlevelstart = 20
    vim.opt.foldmethod     = 'expr'
    vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  end
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group=group_ws,
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
  desc='Automatically removes trailing whitespaces'
})
