local config = {
    keys = 'asdghklwertyuiopzxcvbnmfj',
    create_hl_autocmd = true,
    quit_key = 'q'
}

require('hop').setup(config)

nnoremap('<leader>j', '<cmd>HopWord<cr>', 'Prepares for jumping anywhere in buffer to beginning of word')

vim.defer_fn(function()
    vim.cmd [[hi HopNextKey  guifg=#ff007c gui=bold cterm=bold]]
    vim.cmd [[hi HopNextKey1 guifg=#ff9900 gui=bold cterm=bold]]
    vim.cmd [[hi HopNextKey2 guifg=#ff9900 gui=bold cterm=bold]]
end, 0)
