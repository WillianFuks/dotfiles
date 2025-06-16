vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
    require('vim.hl').on_yank({ higroup = 'CursorIM', timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd('CmdwinEnter', {
  desc = "It's not possible to remove the mappings that open the command window so we use its event enter to close it automatically.",
  group = vim.api.nvim_create_augroup('close-cmdwin', { clear = true }),
  callback = function()
    vim.cmd('q')
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close with q', { clear = true }),
  pattern = {
    'PlenaryTestPopup',
    'help',
    'lspinfo',
    'notify',
    'qf',
    'query',
    'spectre_panel',
    'startuptime',
    'tsplayground',
    'neotest-output',
    'checkhealth',
    'neotest-summary',
    'neotest-output-panel',
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 't', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'When vim window is resized automatically sets windows as equal size',
  group = vim.api.nvim_create_augroup('win resized', { clear = true }),
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup('Remove auto commenting', { clear = true }),
  pattern = "*",
  callback = function()
    vim.opt.formatoptions:remove({'c', 'r', 'o' })
  end,
})
