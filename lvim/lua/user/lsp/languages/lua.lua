local null_ls = require("null-ls")
-- local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"

-- formatters.setup {
--   { command = "stylua",
--     method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
--   },
-- }

linters.setup {
  {
    command = "luacheck",
    method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
    extra_args = { '--globals', 'lvim' },
  },
}
