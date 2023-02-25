local M = {}
-- local color = require 'user.options'.colorscheme

function M.on_packer_completed()
    vim.api.nvim_exec_autocmds('User', { pattern = 'PackerComplete' })
    --vim.cmd('colorscheme ' .. color)
end

return M
