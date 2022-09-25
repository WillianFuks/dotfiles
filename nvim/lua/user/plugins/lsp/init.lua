lspconfig = require('lspconfig')

local config = require('user.plugins.lsp.config')

--Sigsn that appears by the side of each window
for _, sign in ipairs(config.diagnostics.signs.values) do
    vim.fn.sign_define(
        sign.name,
        { texthl = sign.name, text = sign.text, numhl = sign.name }
    )
end
