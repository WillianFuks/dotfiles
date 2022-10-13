local M = {}

--https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
local group_ts_fold_workaround = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {})

-- local group_whitespace = vim.api.nvim_create_augroup('WhitespaceTrails', {})
local group_general_settings = vim.api.nvim_create_augroup('general_settings', {})

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufNew', 'BufNewFile', 'BufWinEnter' }, {
    group = group_ts_fold_workaround,
    callback = function()
        vim.opt.foldlevel = 20
        vim.opt.foldlevelstart = 20
        vim.opt.foldmethod = 'expr'
        vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
    end,
})

-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--     group = group_whitespace,
--     pattern = { '*' },
--     command = [[%s/\s\+$//e]],
--     desc = 'Automatically removes trailing whitespaces',
-- })

vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    group = group_general_settings,
    pattern = '*',
    desc = 'Highlight text on yank',
    callback = function()
        require('vim.highlight').on_yank({ higroup = 'Search', timeout = 150 })
    end,
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
        'null-ls-info',
        'toggleterm',
    },
    callback = function()
        vim.cmd([[
      nnoremap <silent> <buffer> e :close<CR>
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]])
    end,
})

--Setting formatoptions through `vim.o` doesn't work as the value gets constantly reseted
--so using autocmd to fix it. Now jumping to a new line from a comment shouldn't automatically
--also comment the new line.
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'BufNewFile' }, {
    group = group_general_settings,
    pattern = { '*' },
    callback = function()
        vim.cmd([[setlocal formatoptions-=cro]])
    end,
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = group_general_settings,
    pattern = { 'lua' },
    callback = function()
        require('user.plugins.tools.dap.providers.lua')
    end,
})

vim.api.nvim_create_autocmd({ 'Filetype' }, {
    group = group_general_settings,
    pattern = { 'dap-repl' },
    callback = function()
        require('dap.ext.autocompl').attach()
    end,
})

--- Clean autocommand in a group if it exists
--- This is safer than trying to delete the augroup itself
---@param name string the augroup name
function M.clear_augroup(name)
    -- defer the function in case the autocommand is still in-use
    vim.schedule(function()
        pcall(function()
            vim.api.nvim_clear_autocmds({ group = name })
        end)
    end)
end

return M
