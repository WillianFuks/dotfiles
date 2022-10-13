local M = {}

local config = require('user.plugins.tools.lsp.config')
local opts_factory = require('user.plugins.tools.lsp.manager').default_opts

--@params should_run boolean If true then builds the templates
function M.setup(should_run)
    for _, sign in ipairs(config.diagnostics.signs.values) do
        vim.fn.sign_define(
            sign.name,
            { texthl = sign.name, text = sign.text, numhl = sign.name }
        )
    end

    require('user.plugins.tools.lsp.handlers')

    if should_run then
        require('user.plugins.tools.lsp.templates')
    end

    require('nlspsettings').setup(config.nlsp_settings.setup)
    require('null-ls').setup(vim.tbl_deep_extend('force', config.null_ls, opts_factory()))
end

return M
