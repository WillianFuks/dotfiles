local dap = require('dap')
local install_path = require'mason-registry'.get_package('firefox-debug-adapter'):get_install_path()
local adapter_path = install_path .. '/dist/adapter.bundle.js'
dap.adapters.firefox = {
  type = 'executable',
  command = 'node',
  args = { adapter_path },
}

local config = {
      name = 'Debug with Firefox',
      type = 'firefox',
      request = 'launch',
      reAttach = true,
      url = 'http://localhost:3000',
      webRoot = '${workspaceFolder}',
      firefoxExecutable = '/usr/bin/firefox'
    }

for _, lang in ipairs({ 'javascript', 'typescript' }) do
    if not dap.configurations[lang] then
        dap.configurations[lang] = { config }
    else
        table.insert(dap.configurations[lang], config)
    end
end

