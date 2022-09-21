local fn = vim.fn

local base_packer_path = fn.stdpath('data') .. '/site/pack'
local packer_install_path = base_packer_path .. '/packer/start/packer.nvim'
local compile_path = fn.stdpath('config') .. '/plugin/packer_compiled.lua'
local snapshot_path = fn.stdpath('cache') .. '/snapshots/'

local init_opts = {
  package_root = base_packer_path,
  compile_path = compile_path,
  snapshot_path = snapshot_path,
  max_jobs = 100,
  log = { level = "warn" },
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

local ensure_packer = function()
    local fn = vim.fn
    local install_path = packer_install_path
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd 'packadd packer.nvim'
        return true
    end
    return false
end

local bootstrap_packer = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost */plugins/init.lua source <afile> | PackerSync
  augroup end
]])

local packer = require('packer')
packer.init(init_opts)
packer.reset()

packer.startup({ function(use)
    use 'wbthomason/packer.nvim'

    use { "nvim-lua/popup.nvim" }
    use "nvim-lua/plenary.nvim"
    use 'marko-cerovac/material.nvim'

    -- cmp related
   -- use 'neovim/nvim-lspconfig'
	use({ 
        "hrsh7th/nvim-cmp",
        requires = { "L3MON4D3/LuaSnip" }
    }) -- The completion plugin
	use({ "hrsh7th/cmp-buffer" }) -- buffer completions
	use({ "hrsh7th/cmp-path" }) -- path completions
    use 'hrsh7th/cmp-cmdline'
	use({ "saadparwaiz1/cmp_luasnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "hrsh7th/cmp-nvim-lua" })

    -- For vsnip users.
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

	-- snippets
	use({
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_lua").lazy_load()
            require("luasnip.loaders.from_vscode").lazy_load()
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

    packer.on_complete = vim.schedule_wrap(function()
        require('user.hooks').on_packer_completed()
    end)

    if bootstrap_packer then packer.sync() end

    end
})

require('user.plugins.colorscheme')
require('user.plugins.cmp')
