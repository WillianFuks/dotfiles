local opts = {
  settings = {
    Lua = {
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

local lua_dev_defaults = require('lua-dev').setup({})
local config = vim.tbl_deep_extend('force', lua_dev_defaults, opts)

return config
