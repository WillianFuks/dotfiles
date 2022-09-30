--https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
local group_ts_fold_workaround = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {})

local group_whitespace = vim.api.nvim_create_augroup('WhitespaceTrails', {})
local group_general_settings = vim.api.nvim_create_augroup('general_settings', {})


vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  group = group_ts_fold_workaround,
  callback = function()
    vim.opt.foldlevel = 20
    vim.opt.foldlevelstart = 20
    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end
})

vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = group_whitespace,
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
  desc='Automatically removes trailing whitespaces'
})

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    group = group_general_settings,
    pattern = '*',
    desc = 'Highlight text on yank',
    callback = function() require('vim.highlight').on_yank { higroup = 'Search', timeout = 150 } end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = group_general_settings,
    pattern = {
      'Jaq',
      'qf',
      'help',
      'man',
      'lspinfo',
      'spectre_panel',
      'lir',
      'DressingSelect',
      'tsplayground',
      'Markdown',
    },
    callback = function()
      vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]]
    end,
  })
