local dapui = require "dapui"
local dap = require "dap"

if lvim.builtin.dap.ui.auto_open then
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
    dap.repl.close()
  end
end

lvim.builtin.dap.ui.config.expand_lines = false
lvim.builtin.dap.ui.config.layouts[1]['elements'] = {
  { id = "scopes", size = 0.45 },
  { id = "breakpoints", size = 0.15 },
  { id = "watches", size = 0.20 },
  { id = "stacks", size = 0.20 },
}
lvim.builtin.dap.ui.config.layouts[1]['size'] = 0.40
