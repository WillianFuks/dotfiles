local M = {}

local config = require('user.plugins.lsp.config')
local autocmds = require('user.autocmds')

---@param server string such as 'pyright'
---@return boolean if server is already working as a client for current buffer
local function is_server_active(server)
    for _, client in pairs(vim.lsp.get_active_clients()) do
        if client.name == server then
            return true
        end
    end
    return false
end

local function build_mason_config(server_name, pkg_name)
    if pkg_name == nil then
        return {}
    end
    local found, mason_config = pcall(require, 'mason-lspconfig.server_configurations.' .. server_name)
    if not found then
        return {}
    end
    local path = require('mason-core.path')
    local install_dir = path.package_prefix(pkg_name)
    local conf = mason_config(install_dir)
    return conf or {}
end

local function set_codelens_refresh_autocmds(client, bufnr)
    local ok, codelens = pcall(function()
        return client.supports_method('textDocument/codeLens')
    end)
    if not ok or not codelens then
        return
    end
    local group = config.buffer_autocmds.codelens_group
    local events = { 'BufEnter', 'InsertLeave' }
    local ok1, autocmds_arr = pcall(vim.api.nvim_get_autocmds, {
        group = group,
        buffer = bufnr,
        event = events,
    })
    if ok1 and #autocmds_arr > 0 then
        return
    end
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_create_autocmd(events, {
        group = group,
        buffer = bufnr,
        callback = vim.lsp.codelens.refresh,
    })
end

local function add_buf_keymaps(bufnr)
    for lhs, t in pairs(config.buffer_mappings.normal_mode) do
        local rhs, desc = t[1], t[2]
        local opts = { buffer = bufnr, desc = desc, noremap = true, silent = true }
        vim.keymap.set('n', lhs, rhs, opts)
    end
end

local function default_on_exit(_, _)
    autocmds.clear_augroup(config.codelens_group)
end

local function set_buf_options(bufnr)
    --- enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    --- use gq for formatting
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr(#{timeout_ms:500})')
end

local function default_on_attach(client, bufnr)
    set_codelens_refresh_autocmds(client, bufnr)
    add_buf_keymaps(bufnr)
    set_buf_options(bufnr)
end

local function default_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        },
    }
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
    return capabilities
end

function M.default_opts()
    return {
        on_attach = default_on_attach,
        on_init = nil,
        on_exit = default_on_exit,
        capabilities = default_capabilities(),
    }
end

local function build_config(server_name, mason_config)
    local defaults = M.default_opts()
    local ok, custom_config = pcall(require, 'user.plugins.lsp.custom.' .. server_name)
    if ok then
        defaults = vim.tbl_deep_extend('force', defaults, custom_config)
    end
    defaults = vim.tbl_deep_extend('force', defaults, mason_config)
    return defaults
end

-- manually start the server and don't wait for the usual filetype trigger from lspconfig
local function launch_server(server_name, server_config)
    local lspconf = require('lspconfig')[server_name]
    lspconf.setup(server_config)
    local bufnr = vim.api.nvim_get_current_buf()
    lspconf.manager.try_add_wrapper(bufnr)
end

-- check if the manager autocomd has already been configured since some servers can take a while to initialize
-- this helps guarding against a data-race condition where a server can get configured twice
-- which seems to occur only when attaching to single-files
local function client_is_configured(server_name)
    local active_autocmds = vim.api.nvim_get_autocmds({ event = 'FileType', pattern = vim.bo.filetype })
    for _, result in ipairs(active_autocmds) do
        if result.command:match(server_name) then
            return true
        end
    end
    return false
end

function M.setup(server_name)
    if is_server_active(server_name) or client_is_configured(server_name) then
        return
    end
    local pkg_name = require('mason-lspconfig.mappings.server').lspconfig_to_package[server_name]
    local registry = require('mason-registry')
    if not registry.is_installed(pkg_name) then
        vim.notify_once(string.format('Installation in progress for: [%q]', server_name), vim.log.levels.INFO)
        local pkg = registry.get_package(pkg_name)
        pkg:install():once('closed', function()
            if pkg:is_installed() then
                vim.schedule(function()
                    vim.notify_once(string.format('Installation complete for: [%q]', server_name), vim.log.levels.INFO)
                    --This has to be here as it's running asynchronously
                    local server_config = build_config(server_name, build_mason_config(server_name, pkg_name))
                    launch_server(server_name, server_config)
                end)
            else
                vim.schedule(function()
                    vim.notify_once(string.format('Failed to install package: [%q]', server_name), vim.log.levels.ERROR)
                end)
                return
            end
        end)
    end
    -- mason config is only available once the server has been installed
    local server_config = build_config(server_name, build_mason_config(server_name, pkg_name))
    launch_server(server_name, server_config)
end

return M
