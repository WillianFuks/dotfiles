local M = {}

local all_pkgs = require('mason-registry').get_all_packages()
local template_setup = require('user.plugins.tools.dap.templates').setup

nnoremap('<F5>', [[<Cmd>lua require'dap'.continue()<CR>]])
nnoremap('<F3>', [[<Cmd>lua require'dap'.step_over()<CR>]])
nnoremap('<F2>', [[<Cmd>lua require'dap'.step_into()<CR>]])
nnoremap('<F4>', [[<Cmd>lua require'dap'.step_out()<CR>]])
nnoremap('<leader>b', [[<Cmd>lua require'dap'.toggle_breakpoint()<CR>]])
nnoremap('<leader>B', [[<Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]])
nnoremap('<leader>dr', [[<Cmd>lua require'dap'.repl.open()<CR>]])
nnoremap('<leader>dl', [[<Cmd>lua require'dap'.run_last()<CR>]])
nnoremap('<Leader>lp', [[<Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]])

local dap = require('dap')
local dapui = require('dapui')
dapui.setup({
    expand_lines = false,
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = 'scopes', size = 0.30 },
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 60, -- 40 columns
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 0.3,
            position = 'bottom',
        },
    },
    controls = {
        enabled = true,
        -- Display controls in this element
        element = 'repl',
        icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '↻',
            terminate = '□',
        },
    },
    windows = { indent = 0 },
})


dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
    dap.repl.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
    dap.repl.close()
end

function M.setup(should_run)
    if should_run then
        for _, pkg in ipairs(all_pkgs) do
            if vim.tbl_contains(pkg.spec.categories, 'DAP') then
                template_setup(pkg)
            end
        end
    end
end

return M
