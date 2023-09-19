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
