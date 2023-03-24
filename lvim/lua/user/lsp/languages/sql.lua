local null_ls = require "null-ls"
local linters = require "lvim.lsp.null-ls.linters"

linters.setup {
  {
    command = "sqlfluff",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
  },
}
