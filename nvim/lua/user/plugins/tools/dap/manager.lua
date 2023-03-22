local registry = require'mason-registry'
local M = {}

local function setup_dap(dap_name)
    local ok, _ = pcall(require, string.format('user.plugins.tools.dap.providers.%s', dap_name))
    if not ok then
        vim.notify_once(string.format('Failed to run DAP setup for %q', dap_name, vim.log.levels.ERROR))
    end
end

function M.setup(dap_name)
    if not registry.is_installed(dap_name) then
        vim.notify_once(string.format('DAP installation in progress for: [%q]', dap_name), vim.log.levels.INFO)
        local pkg = registry.get_package(dap_name)
        local inst_handle = pkg:install()

        inst_handle:once('stderr', function(chunk)
            vim.schedule(function()
                vim.notify_once(
                    string.format('DAP installation failed. Cause of error:  [%q]\n', chunk), vim.log.levels.ERROR
                )
            end)
        end)

        inst_handle:once('closed', function()
            if pkg:is_installed() then
                vim.schedule(function()
                    vim.notify_once(string.format('DAP installation completed for: [%q]', dap_name), vim.log.levels.INFO)
                    setup_dap(dap_name)
                end)
            end
        end)

    else
        setup_dap(dap_name)
    end
end

return M
