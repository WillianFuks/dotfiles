local null_ls = require "null-ls"
local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"

formatters.setup {
  { command = "black" },
  { command = "isort" },
}

linters.setup {
  {
    command = "flake8",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
  {
    command = "mypy",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
  {
    command = "pydocstyle",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
  {
    command = "pyproject-flake8",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
}

local debugpy_python_path = require('mason-registry').get_package('debugpy'):get_install_path() .. '/venv/bin/python3'
local opts = {
    include_configs = true
}
pcall(function()
  require("dap-python").setup(debugpy_python_path, opts)
end)

vim.api.nvim_create_autocmd(
  { "FileType" },
  {
    pattern = { "python" },
    callback = function()
      lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
      lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" }
      lvim.builtin.which_key.vmappings["d"] = {
        name = "Debug",
        s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
      }
    end,
})
