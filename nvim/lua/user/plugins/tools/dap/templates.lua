local M = {}
local templates_dir = require('user.plugins.tools.config').templates_dir
local utils = require('user.utils')
local config = require('user.plugins.tools.dap.config')

local lang_ft_map = {
    Elixir = 'elixir',
    [".NET"] = nil,
    ["C#"] = nil,
    ["F#"] = 'fsharp',
    Puppet = 'puppet',
    Go = 'go',
    JavaScript = 'javascript',
    TypeScript = 'typescript',
    Bash = 'sh',
    C = 'c',
    ["C++"] = 'cpp',
    Rust = 'rust',
    Python = 'python',
    PHP = 'php',
    Java = 'java'
}

function M.setup(pkg)
    for _, lang in ipairs(pkg.spec.languages) do
        if not lang then
            goto skip
        end

        if vim.tbl_contains(config.skip_adapters, pkg.name) then
            goto skip
        end

        local filetype = lang_ft_map[lang]

        if not filetype then
            goto skip
        end

        local ftplugin_file_path = table.concat({ templates_dir, '/', filetype, '.lua' })
        local content = string.format([[require('user.plugins.tools.dap.manager').setup(%q)]], pkg.name)
        utils.write_file(ftplugin_file_path, content .. '\n', 'a')
        ::skip::
    end
end

return M
