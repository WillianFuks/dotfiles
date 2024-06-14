local o = vim.opt

o.number = true
o.wildignore = { '*.o', '*~', '*.pyc', '*/node_modules/*', '*/.git/*', '*/vendor/*' }
-- o.cmdheight = 0  -- cmdheight is experimental, as it may break plugins (it did for netrw) then disable for now
o.mouse = ''
o.whichwrap:remove({ '<', '>', '[', ']', 'h', 'l', 'b', 's' })
o.showtabline = 1
o.smartindent = true
o.title = false
o.numberwidth = 2
o.signcolumn = 'yes' -- always show the sign column, otherwise it would shift the text each time
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
-- From mini.basics
o.backup = false -- Don't store backup while overwriting the file
o.writebackup = false -- Don't store backup while overwriting the file

-- From LazyVim
o.completeopt = 'menu,menuone,noselect,preview'
o.conceallevel = 0
o.confirm = true -- Confirm to save changes before exiting modified buffer
o.cursorline = true -- Enable highlighting of the current line
o.expandtab = true -- Use spaces instead of tabs
o.formatoptions:append('jl1') -- h: fo-table for info
o.formatoptions:remove({ 'c', 'r', 'o' })
o.grepprg = 'rg --vimgrep'
o.ignorecase = true -- Ignore case
o.smartcase = true -- Don't ignore case with capitals
o.laststatus = 3 -- global statusline
o.list = false -- Show some invisible characters (tabs...
o.pumblend = 0 -- Popup menu fully opaque
o.pumheight = 7 -- Maximum number of entries in a popup
o.scrolloff = 4 -- Lines of context
o.shortmess:append('IC')
o.shortmess:remove('filmnw')
o.showmode = false -- Dont show mode since we have a statusline
o.sidescrolloff = 4 -- Columns of context
o.splitbelow = true -- Put new windows below current
o.splitkeep = 'screen'
o.splitright = true -- Put new windows right of current
o.termguicolors = true -- True color support
o.undofile = true
o.undolevels = 10000
o.updatetime = 4000 -- Save swap file and trigger CursorHold
o.wildmode = 'longest:full,full' -- Command-line completion mode
o.winminwidth = 5 -- Minimum window width
o.wrap = false -- Disable line wrap
o.fillchars = {
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
-- Folding
o.foldlevel = 99
o.foldmethod = 'indent'

-- From LunarVim
o.clipboard = 'unnamedplus' -- allows neovim to access the system clipboard
o.foldexpr = '' -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
o.hlsearch = true -- highlight all matches on previous search pattern
o.swapfile = false -- creates a swapfile
o.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.tabstop = 2 -- insert 2 spaces for a tab
o.showcmd = false
o.ruler = false

vim.cmd('filetype plugin indent on') -- Enable all filetype plugins
