-- local bin = dap_utils.MASON_BIN_PATH .. '/bash-debug-adapter'
-- local BASHDB_DIR = dap_utils.MASON_PACKAGE_PATH .. '/bash-debug-adapter/extension/bashdb_dir'

local pkg = require'mason-registry'.get_package('bash-debug-adapter')
local install_path = pkg:get_install_path() --path/to/mason/packages/bash-debug-adapter
local bashdb_dir = install_path .. '/extension/bashdb_dir/'
local bashdb_path = bashdb_dir .. 'bashdb'

local dap = require('dap')
dap.adapters.sh = {
    type = 'executable',
    command = install_path .. '/bash-debug-adapter',
}
dap.configurations.sh = {
    {
        name = 'Launch Bash debugger',
        type = 'sh',
        request = 'launch',
        program = '${file}',
        cwd = '${workspaceFolder}',
        pathBashdb = bashdb_path,
        pathBashdbLib = bashdb_dir,
        pathBash = 'bash',
        pathCat = 'cat',
        pathMkfifo = 'mkfifo',
        pathPkill = 'pkill',
        terminalKind = 'integrated',
        env = {},
        args = {},
        -- showDebugOutput = true,
        -- trace = true,
    },
}
