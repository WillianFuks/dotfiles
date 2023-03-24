local formatters = require "lvim.lsp.null-ls.formatters"

formatters.setup {
  { command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
}

vim.filetype.add {
  extension = {
    zsh = "zsh",
  },
}

local servers_to_skip = { "bashls" }
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, servers_to_skip, 1, #servers_to_skip)

local lsp_manager = require "lvim.lsp.manager"
lsp_manager.setup("bashls", {
  filetypes = { "sh", "zsh" },
  on_init = require("lvim.lsp").common_on_init,
  capabilities = require("lvim.lsp").common_capabilities(),
})
