local config = require('user.plugins.lsp.config')
local utils = require('user.utils')
local available_servers = require('mason-lspconfig').get_available_servers()

local templates_dir = config.templates_dir

vim.fn.mkdir(templates_dir, 'p')

for _, server in ipairs(available_servers) do
    if vim.tbl_contains(config.automatic_configuration.skipped_servers, server) then
        goto skip
    end

    local ok, server_config = pcall(require, string.format([[lspconfig.server_configurations.%s]], server))
    if not ok then
        goto skip
    end

    local server_filetypes = server_config.default_config.filetypes

    server_filetypes = vim.tbl_filter(
        function(ft) return not vim.tbl_contains(config.automatic_configuration.skipped_filetypes, ft) end,
        server_filetypes or {}
    )

    if not server_filetypes then
        goto skip
    end

    for _, filetype in ipairs(server_filetypes) do
        local ftplugin_file_path = table.concat({ templates_dir, '/', filetype, '.lua' })
        local content = string.format([[require('user.plugins.lsp.manager').setup(%q)]], server)
        utils.write_file(ftplugin_file_path, content .. '\n', 'a')
    end

    ::skip::
end
