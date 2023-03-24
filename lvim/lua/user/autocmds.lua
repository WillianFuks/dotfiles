local group_general_settings = vim.api.nvim_create_augroup('general_settings', {})
-- Setting formatoptions through `vim.o` doesn't work as the value gets constantly reseted
-- so using autocmd to fix it. Now jumping to a new line from a comment shouldn't automatically
-- comment the next line.
lvim.autocommands = {
  {
    {'BufWinEnter', 'BufNewFile' },
    {
      group = group_general_settings,
      pattern = { '*' },
      callback = function()
          vim.cmd([[setlocal formatoptions-=cro]])
      end,
    }
  },
  {
    { "TextYankPost" },
    {
      callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
      end
    }
  }
}

vim.api.nvim_create_autocmd()

-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
