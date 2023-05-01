local ok, dap = pcall(require, "dap")

assert(ok, "nvim-dap is not installed. Cannot run debugger for nvim lua files.")

dap.configurations.lua = {
  {
    type = "nlua",
    request = "attach",
    name = "Attach to running Neovim instance",
  }
}

dap.adapters.nlua = function(callback, config)
  callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
end

---@diagnostic disable-next-line: redefined-local
local ok = pcall(function()
    vim.api.nvim_set_keymap("n", "<F9>", [[:lua require"osv".launch({port = 8086, lvim = true})<CR>]], { noremap = true })
  end
)

assert(ok, "One-step-for-vimkind failed to load.")
