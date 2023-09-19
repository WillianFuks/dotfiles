local null_ls = require "null-ls"
local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"
local Log = require "lvim.core.log"

formatters.setup {
  { command = "prettierd" },
}

linters.setup {
  {
    command = "eslint_d",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
}
