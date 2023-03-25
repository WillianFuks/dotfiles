require "user.lsp.languages.python"
require "user.lsp.languages.lua"
require "user.lsp.languages.sh"

lvim.lsp.diagnostics.float.focusable = true

local code_actions = require "lvim.lsp.null-ls.code_actions"
local formatters = require "lvim.lsp.null-ls.formatters"


formatters.setup {
  { command = "fixjson" },
  { command = "tidy" },
  -- { command = "trim_newlines" },
  -- { command = "trim_whitespace" },
}

code_actions.setup {
  -- { name = "refactoring" },
  {
    name = "eslint_d",
    prefer_local = 'node_modules/.bin'
  }
}
