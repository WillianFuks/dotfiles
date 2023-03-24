---------------------------------------------------
--------------------  NVIM DEFAULTS  --------------
---------------------------------------------------

lvim.keys.normal_mode["<A-j>"] = nil
lvim.keys.normal_mode["<A-k>"] = nil
lvim.keys.normal_mode["<A-Up>"] = nil
lvim.keys.normal_mode["<A-Down>"] = nil
lvim.keys.normal_mode["<A-Left>"] = nil
lvim.keys.normal_mode["<A-Right>"] = nil
lvim.keys.insert_mode["<A-j>"] = nil
lvim.keys.insert_mode["<A-k>"] = nil
lvim.keys.insert_mode["<A-Up>"] = nil
lvim.keys.insert_mode["<A-Down>"] = nil
lvim.keys.insert_mode["<A-Left>"] = nil
lvim.keys.insert_mode["<A-Right>"] = nil
lvim.keys.visual_block_mode["<A-j>"] = nil
lvim.keys.visual_block_mode["<A-k>"] = nil

lvim.leader = ","
lvim.keys.normal_mode["B"] = "^"
lvim.keys.normal_mode["E"] = "$"
lvim.keys.normal_mode["zl"] = "zL"
lvim.keys.normal_mode["zh"] = "zH"
lvim.keys.normal_mode["<C-Up>"] = ":resize +2<CR>"
lvim.keys.normal_mode["<C-Down>"] = ":resize -2<CR>"
lvim.keys.normal_mode["<C-Left>"] = ":vertical resize +2<CR>"
lvim.keys.normal_mode["<C-Right>"] = ":vertical resize -2<CR>"
lvim.keys.normal_mode["E"] = "$"
lvim.keys.normal_mode["j"] = "gj"
lvim.keys.normal_mode["k"] = "gk"
lvim.keys.normal_mode["dE"] = "d$"
lvim.keys.normal_mode["cE"] = "c$"
lvim.keys.normal_mode["x"] = '"_x'
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"
lvim.keys.normal_mode["q:"] = "<NOP>"

lvim.keys.visual_mode["B"] = "^"
lvim.keys.visual_mode["zl"] = "zL"
lvim.keys.visual_mode["zh"] = "zH"
lvim.keys.visual_mode["E"] = "$"
lvim.keys.visual_mode["p"] = '"_dP'

lvim.keys.insert_mode["fd"] = "<ESC>"

---------------------------------------------------
--------------------  WHICH-KEY  ------------------
---------------------------------------------------

lvim.builtin.which_key.mappings["<leader>"] = {
  name = "Runtime",
  x = { ":source %<CR>", "Reload file" }
}
lvim.builtin.which_key.mappings["<space>"] = lvim.builtin.which_key.mappings["h"]
lvim.builtin.which_key.mappings["h"] = nil
lvim.builtin.which_key.mappings["b"]["q"] = lvim.builtin.which_key.mappings["c"]
lvim.builtin.which_key.mappings["c"] = nil
lvim.builtin.which_key.mappings["q"] = nil
lvim.builtin.which_key.mappings["c"] = lvim.builtin.which_key.mappings["/"]
lvim.builtin.which_key.mappings["/"] = nil

lvim.builtin.which_key.vmappings["w"] = lvim.builtin.which_key.mappings["w"]
lvim.builtin.which_key.vmappings["c"] = { "<Plug>(comment_toggle_linewise_visual)", "Visual Comment Toggle" }

---------------------------------------------------
--------------------  LSP  ------------------------
---------------------------------------------------

lvim.lsp.buffer_mappings.normal_mode['g['] = {
  lvim.builtin.which_key.mappings["l"]["k"][1],
  { desc = lvim.builtin.which_key.mappings["l"]["k"][2] }
}
lvim.lsp.buffer_mappings.normal_mode['g]'] = {
  lvim.builtin.which_key.mappings["l"]["j"][1],
  { desc = lvim.builtin.which_key.mappings["l"]["j"][2] }
}
lvim.lsp.buffer_mappings.normal_mode['<leader>fo'] = {
  ':lua vim.lsp.buf.format()<CR>' ,
  "Formats code if formatter is available"
}
lvim.lsp.buffer_mappings.normal_mode['<leader>ga'] = {
  ':lua vim.lsp.buf.code_action()<CR>',
  "Code Action"
}
lvim.lsp.buffer_mappings.visual_mode['<leader>ga'] = {
  ':lua vim.lsp.buf.code_action()<CR>',
  "Code Action"
}
lvim.lsp.buffer_mappings.normal_mode['<leader>gcl'] = {
  ':lua vim.lsp.codelens.run()<CR>',
  "Code Lens"
}
lvim.lsp.buffer_mappings.visual_mode['<leader>gcl'] = {
  ':lua vim.lsp.codelens.run()<CR>',
  "Code Lens"
}

---------------------------------------------------
--------------------  MISC  -----------------------
---------------------------------------------------

lvim.builtin.which_key.mappings["s"]["s"] = { ":SymbolsOutline<CR>", "Toggle symbols outline from the LSP" }

lvim.keys.normal_mode["<F5>"] = { function() require('dap').continue() end, { desc = "Start DAP Debugging" } }
lvim.keys.normal_mode["<F3>"] = { function() require('dap').step_over() end, { desc = "DAP - Step Over" } }
lvim.keys.normal_mode["<F2>"] = { function() require('dap').step_into() end, { desc = "DAP - Step Into" } }
lvim.keys.normal_mode["<F4>"] = { function() require('dap').step_out() end, { desc = "DAP - Step Out" } }
