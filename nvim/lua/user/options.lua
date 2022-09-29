utils = require('user.utils')

local g = vim.g
local o = vim.opt
local _sep = package.config:sub(1, 1)
local _cache_path = vim.fn.stdpath('cache')
local _uv = vim.loop

local _undo_dir = _cache_path .. _sep .. 'undo'

if not utils.is_dir(_undo_dir) then
    vim.fn.mkdir(_undo_dir, 'p')
end

g.mapleader = ','

o.clipboard:append({ 'unnamedplus' })
o.backup = false
o.completeopt = { 'menuone' , 'noselect' }
o.ignorecase = true
o.pumheight = 10
o.showmode = false
o.smartcase = true
o.smartindent = true
o.swapfile = false
o.termguicolors = true
o.title = true
o.undodir = _undo_dir
o.undofile = true
o.updatetime = 100 -- faster completion (lvim)
o.writebackup = false
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.cursorline = true
o.number = false
o.numberwidth = 4
o.signcolumn = 'auto'
o.wrap = false
o.shadafile = vim.fn.stdpath('cache') .. _sep .. 'nvim.shada'
o.scrolloff = 8
o.sidescrolloff = 8 --Not used as wrap is true
o.wildignore = { '*.o', '*~', '*.pyc' }
o.lazyredraw = true
o.conceallevel = 0 -- allows markers `` to appear in Markdown files
o.hlsearch = true
o.fillchars = { eob = " " } -- Replaces the ~ at end of buffer with spaces which in effect hides it
o.laststatus = 3
o.ruler = false
o.shortmess:append 'c' -- avoid reduntant messages from ins-completion menu
o.shortmess:append 'sI' -- dont show default intro message

return { colorscheme = 'material' }
