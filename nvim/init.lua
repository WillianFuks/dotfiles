require('user.disable_builtins')

vim.defer_fn(function()
    pcall(require, "impatient")
end, 0)

local reload = require('user.utils').reload

if _G._is_reload then
	reload('user')
	_G._is_reload = false -- avoids reloading without directly requesting it
end

require('user.options')
require('user.mappings')
require('user.plugins')
require('user.autocmds')

_G._is_reload = false -- Only the command map sets this value to true once
