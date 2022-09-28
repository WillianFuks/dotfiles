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
  log = { level = 'warn' },
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
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

    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use {
        'rcarriga/nvim-notify',
        config = function() require 'user.plugins.notify' end,
        requires = { "nvim-telescope/telescope.nvim" }
    }

    use {
      "nvim-telescope/telescope.nvim",
      --branch = "0.1.x",
      config = function() require 'user.plugins.telescope' end
    }
    use {
      "nvim-telescope/telescope-fzf-native.nvim",
      requires = { "nvim-telescope/telescope.nvim" },
      run = "make"
    }
    use  {
        "kyazdani42/nvim-tree.lua",
        requires = {  'kyazdani42/nvim-web-devicons' },
        config = function() require 'user.plugins.nvimtree' end
    }
    use { "kyazdani42/nvim-web-devicons", requires = { {'nvim-lua/plenary.nvim'} } }

    use {
        "nvim-treesitter/nvim-treesitter",
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
        config = function() require 'user.plugins.treesitter' end
    }
    -- use {
    --     'nvim-treesitter/nvim-treesitter-refactor',
    --     requires = { 'nvim-treesitter/nvim-treesitter' },
    -- }
    use {
        'p00f/nvim-ts-rainbow',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        --run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }
    use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        requires = { 'nvim-treesitter/nvim-treesitter' , 'numToStr/Comment.nvim' },
    }
    use {
        'numToStr/Comment.nvim',
        config = function() require('user.plugins.Comment') end
    }
    -- use {
    --   "windwp/nvim-autopairs",
    --   config = function() require('user.plugins.autopairs') end,
    -- }
    -- use {
    --     'andymass/vim-matchup',
    --     requires = { 'nvim-treesitter/nvim-treesitter' },
    -- }

    use { 'marko-cerovac/material.nvim', config = function() require 'user.plugins.colorscheme' end }
    use 'projekt0n/github-nvim-theme'

    -- cmp related
	use { 'hrsh7th/nvim-cmp', requires = { 'L3MON4D3/LuaSnip' } , config = function() require 'user.plugins.cmp' end}
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
	use { 'saadparwaiz1/cmp_luasnip' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-nvim-lua' }
    use { 'David-Kunz/cmp-npm', requires = { 'nvim-lua/plenary.nvim' } }

	-- snippets
	use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('luasnip.loaders.from_lua').lazy_load()
            require('luasnip.loaders.from_vscode').lazy_load()
            require('luasnip.loaders.from_snipmate').lazy_load()
        end
    }
	use { 'rafamadriz/friendly-snippets' }

    -- lsp
    use { 'neovim/nvim-lspconfig' }
    use { 'tamago324/nlsp-settings.nvim' }
    use { 'jose-elias-alvarez/null-ls.nvim' }
    use { 'williamboman/mason.nvim', config = function() require('user.plugins.mason') end }
    use { 'williamboman/mason-lspconfig.nvim' }

    use {
      'lewis6991/gitsigns.nvim',
        config = function() require('user.plugins.gitsigns') end
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function() require('user.plugins.lualine') end,
    }

    use {
      "lukas-reineke/indent-blankline.nvim",
      config = function() require('user.plugins.indentlines') end,
    }

    packer.on_complete = vim.schedule_wrap(function()
        require('user.hooks').on_packer_completed()
    end)

    if bootstrap_packer then packer.sync() end

    end
})
