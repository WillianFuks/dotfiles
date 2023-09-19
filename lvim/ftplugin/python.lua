-- local debugpy_python_path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python3"
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")

local ok = pcall(function()
  -- Without this check each time neovim loads a python file the configurations for dap will
  -- be inserted again which will start duplicating entries indefinitely.
  if not package.loaded['dap-python'] then
    require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
  end
end)

assert(ok, "Failed to setup debugpy.")


lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('dap-python').test_method()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('dap-python').test_class()<cr>", "Test Class" }
lvim.builtin.which_key.vmappings["d"] = {
  name = "Debug",
  s = { "<cmd>lua require('dap-python').debug_selection()<cr>", "Debug Selection" },
}
