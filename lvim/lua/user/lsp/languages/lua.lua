local formatters = require "lvim.lsp.null-ls.formatters"
local linters = require "lvim.lsp.null-ls.linters"

formatters.setup {
  { command = "stylua" },
}

linters.setup {
  { command = "luacheck" },
}
