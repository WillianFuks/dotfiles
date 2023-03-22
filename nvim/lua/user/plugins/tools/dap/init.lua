local M = {}

local all_pkgs = require('mason-registry').get_all_packages()
local template_setup = require('user.plugins.tools.dap.templates').setup

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F3>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F2>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F4>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>dlp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

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
