local config = require('user.plugins.tools.lsp.config')
local di = config.diagnostics

vim.diagnostic.config({
    virtual_text = di.virtual_text,
    signs = di.signs,
    underline = di.underline,
    update_in_insert = di.update_in_insert,
    severity_sort = di.severity_sort,
    float = di.float,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
