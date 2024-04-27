vim.g.mapleader = ","
vim.g.maplocalleader = ","

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

require('user.config')

require("lazy").setup({
  spec = {
    { import = "user.plugins" },
  },
  install = {
    -- colorscheme = { "primer_dark" },  -- currently not working
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
  custom_keys = {
    ["<localleader>l"] = false,
    ["<localleader>t"] = false
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "zip",
        "zipPlugin",
        "vimball",
        "vimballPluging",
        "getscript",
        "getscriptPluging",
        "logiPat",
        "rrhelper",
        "matchit",
        -- "matchparen",
        "netrwPlugin",
        "tar",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})



--[[
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
]]--
