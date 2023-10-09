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
o.title = false

if vim.fn.has("nvim-0.9.0") == 1 then
  o.splitkeep = "screen"
  o.shortmess:append({ C = true })
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
