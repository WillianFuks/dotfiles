local debugpy_python_path = require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/bin/python3'
require('dap-python').setup(debugpy_python_path)

nnoremap('<leader>dn', [[:lua require('dap-python').test_method()<CR>]])
nnoremap('<leader>df', [[:lua require('dap-python').test_class()<CR>]])
vnoremap('<leader>ds', [[<ESC>:lua require('dap-python').debug_selection()<CR>]])
