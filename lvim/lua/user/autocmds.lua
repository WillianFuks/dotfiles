local Log = require("lvim.core.log")
local group_general_settings = vim.api.nvim_create_augroup("general_settings", {})
local _buffer_mappings = vim.api.nvim_create_augroup("buffer_mappings", {})
local group_dap_settings = vim.api.nvim_create_augroup("dap_settings", {})
-- Setting formatoptions through `vim.o` doesn"t work as the value gets constantly reseted
-- so using autocmd to fix it. Now jumping to a new line from a comment shouldn"t automatically
-- comment the next line.
lvim.autocommands = {
  {
    { "BufWinEnter", "BufNewFile" },
    {
      group = group_general_settings,
      pattern = { "*" },
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
  },
  {
    { "BufWinEnter", "BufNewFile" },
    {
      group = group_dap_settings,
      pattern = { "*" },
      desc = [[
        Looks for the file "launch.json" either at `cwd` or
        at `cwd .. ".vscode"`. If the file exists, loads its dap
        config.
      ]],
      callback = function()
        local lvim_utils = require("lvim.utils")
        local cwd = vim.fn.getcwd()
        local ok, _ = pcall(function()
          local dap = require("dap")
          local dap_ext_vscode = require "dap.ext.vscode"
          local json_path = nil
          if lvim_utils.is_file(cwd .. "launch.json") then
            json_path = cwd .. "launch.json"
          elseif lvim_utils.is_file(cwd .. "/.vscode/launch.json") then
            json_path = cwd .. "/.vscode/launch.json"
          end
          if (json_path ~= nil and dap.configurations[vim.bo.filetype] ~= nil) then
                dap_ext_vscode.load_launchjs(json_path)
          end
        end)
        if not ok then
          Log:error("Failed loading DAP configuration from launch.json")
        end
      end
    }
  },
  {
    { "TextYankPost" },
    {
      group = group_general_settings,
      pattern = { "*" },
      callback = function()
        vim.highlight.on_yank { higroup = "Visual", timeout = 150 }
      end,
    }
  },
  {
    -- resize splits if window got resized
    -- from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
    { "VimResized" },
    {
      group = group_general_settings,
      callback = function()
        vim.cmd("tabdo wincmd =")
      end,
    }
  }
}

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "zsh",
  callback = function()
    -- let treesitter use bash highlight for zsh files as well
    require("nvim-treesitter.highlight").attach(0, "bash")
  end,
})


vim.api.nvim_create_autocmd("FileType", {
  group=_buffer_mappings,
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<Cmd>lua require('bqf.qfwin.handler').open(false)<CR> | <Cmd>ccl<CR>", { buffer = true })
  end,
})
