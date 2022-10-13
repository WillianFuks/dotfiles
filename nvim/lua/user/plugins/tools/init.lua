local should_run = false
local templates_dir = require('user.plugins.tools.config').templates_dir
local utils = require('user.utils')

if not utils.is_dir(templates_dir) then
    should_run = true
    vim.fn.mkdir(templates_dir, 'p') --if already exists then exit silently
end

require('user.plugins.tools.lsp').setup(should_run)
require('user.plugins.tools.dap').setup(should_run)
