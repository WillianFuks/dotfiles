local set = vim.keymap.set


set({ "n" }, "B", "^", { expr=false, silent=true, desc='Moves to beginning of line' })
set({ "n", "v" }, "E", "$", { expr=false, silent=true, desc='Moves to end of line' })
set({ "n" }, "zl", "zL", { expr=false, silent=true, desc='zL jumps the cursor displacing the buffer to the right -- a jump to the Left' })
set({ "n" }, "zh", "zH", { expr=false, silent=true, desc='Similar to zl but jumps to the right' })
set({ "n" }, "<C-Up>", ":resize +2<CR>", { expr=false, silent=true, desc='Resizes window upwards' })
set({ "n" }, "<C-Down>", ":resize -2<CR>", { expr=false, silent=true, desc='Resizes window downwards' })
set({ "n" }, "<C-Right>", ":vertical resize -2<CR>", { expr=false, silent=true, desc='Resizes window increasing to the right' })
set({ "n" }, "<C-Left>", ":vertical resize +2<CR>", { expr=false, silent=true, desc='Resizes window increasing to the right' })
set({ "n" }, "dE", "d$", { expr=false, silent=true, desc='Deletes to end of line' })
set({ "n" }, "cE", "c$", { expr=false, silent=true, desc='Changes to end of line' })
set({ "n", "x", "v" }, "x", '"_x', { expr=false, silent=true, desc='Deletes char under cursor without adding to registers' })
set({ "n" }, "<C-d>", "<C-d>zz", { expr=false, silent=true, desc='Moves buffer downward and re-center screen' })
set({ "n" }, "<C-f>", "<C-f>zz", { expr=false, silent=true, desc='Moves buffer very downward and re-center screen' })
set({ "n" }, "<C-u>", "<C-u>zz", { expr=false, silent=true, desc='Moves buffer updward and re-center screen' })
set({ "n" }, "<C-b>", "<C-b>zz", { expr=false, silent=true, desc='Moves buffer very updward and re-center screen' })
set({ "n" }, "<leader>x", ":source %<CR>", { expr=false, silent=true, desc='Reload file. % means current file' })
set({ "n" }, "<leader><space>", "<cmd>nohlsearch<CR>", { expr=false, silent=true, desc='Removes search highlight' })

set({ "n" }, "<C-h>", "<C-w>h", { desc="Go to Left Window", remap=true, silent=true })
set({ "n" }, "<C-j>", "<C-w>j", { desc="Go to Lower Window", remap=true, silent=true })
set({ "n" }, "<C-k>", "<C-w>k", { desc="Go to Upper Window", remap=true, silent=true })
set({ "n" }, "<C-l>", "<C-w>l", { desc="Go to Right Window", remap=true, silent=true })

set({ "n" }, "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height", silent=true })
set({ "n" }, "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height", silent=true })
set({ "n" }, "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width", silent=true })
set({ "n" }, "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width", silent=true })

-- buffers
set({ "n" }, "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer", silent=true })
set({ "n" }, "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer", silent=true })

set({ "n",  "v" }, "<leader>w", "<cmd>w!<CR>", { expr=false, silent=true, desc='Saves file' })

set({ "n", "x" }, "j", "gj", { expr = false, silent = true, desc='Moves down the line' })
set({ "n", "x" }, "k", "gk", { expr = false, silent = true, desc='Moves cursor up the line' })

set({ "i" }, "fd", "<ESC>", { expr=false, silent=true, desc='Get out of insert mode' })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
set({ "n" }, "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
set({ "x", "o" }, "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
set({ "n" }, "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
set({ "x", "o" }, "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- better indenting
set({ "v" }, "<", "<gv")
set({ "v" }, ">", ">gv")

-- Improve selecting and pasting
set({ "v" }, "p", '"_dP', { expr=false, silent=true, desc='Without this when visual-selecting text and pasting on top of it the register will be replaced with the new value. This map avoids that so pasting visual-selected can keep working indefinitely' })

set({ "n" }, "[q", vim.cmd.cprev, { desc = "Previous Quickfix", silent=true })
set({ "n" }, "]q", vim.cmd.cnext, { desc = "Next Quickfix", silent=true })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

set({ "n" }, "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
set({ "n" }, "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
set({ "n" }, "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
set({ "n" }, "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
set({ "n" }, "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
set({ "n" }, "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- quit
set({ "n" }, "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- windows
set({ "n" }, "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
set({ "n" }, "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })

-- avoid command-window
set({ "n" }, "q:", "", { expr=false, silent=true, desc='Avoids opening the command-line window with command history' })
set({ "n" }, "q/", "", { expr=false, silent=true, desc='Avoids opening the command-line window with command history' })
set({ "n" }, "q?", "", { expr=false, silent=true, desc='Avoids opening the command-line window with command history' })
