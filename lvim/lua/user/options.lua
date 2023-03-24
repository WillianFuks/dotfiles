local o = vim.opt
o.number = false
o.wildignore = { "*.o", "*~", "*.pyc", "*/node_modules/*", "*/.git/*", "*/vendor/*" }
o.fillchars = { eob = " " } -- Replaces the ~ at end of buffer with spaces which in effect hides it
o.cmdheight = 0
o.mouse = ""
o.whichwrap:remove { "<", ">", "[", "]", "h", "l", "b", "s" }
o.signcolumn = "number"
o.showtabline = 0
o.smartindent = true
