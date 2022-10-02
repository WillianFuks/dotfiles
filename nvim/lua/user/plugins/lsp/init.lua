local config = require('user.plugins.lsp.config')
local utils = require('user.utils')

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
