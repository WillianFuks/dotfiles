local debugpy_python_path = require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/bin/python3'
local opts = {
    include_configs = true
}
require('dap-python').setup(debugpy_python_path, opts)

nnoremap('<leader>dtm', [[:lua require('dap-python').test_method()<CR>]])
nnoremap('<leader>dtc', [[:lua require('dap-python').test_class()<CR>]])
vnoremap('<leader>dds', [[<ESC>:lua require('dap-python').debug_selection()<CR>]])
