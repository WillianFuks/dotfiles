local config = require('user.plugins.lsp.config')
local utils = require('user.utils')
local opts_factory = require('user.plugins.lsp.manager').default_opts

for _, sign in ipairs(config.diagnostics.signs.values) do
    vim.fn.sign_define(
        sign.name,
        { texthl = sign.name, text = sign.text, numhl = sign.name }
    )
end

require('user.plugins.lsp.handlers')

if not utils.is_dir(config.templates_dir) then
    require('user.plugins.lsp.templates')
end

require('nlspsettings').setup(config.nlsp_settings.setup)
require('null-ls').setup(vim.tbl_deep_extend('force', config.null_ls, opts_factory()))
