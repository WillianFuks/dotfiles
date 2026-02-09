return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },

    opts = {
      auto_install = true,
      highlight = {
        enable = true,
        disable = function(_, buf)
          local max_filesize = 100 * 1024
          local max_lines = 5000
          local name = vim.api.nvim_buf_get_name(buf)
          local ok, stats = pcall(vim.loop.fs_stat, name)
          if ok and stats and stats.size > max_filesize then return true end
          local ok_len, lines = pcall(vim.fn.readfile, name)
          if ok_len and lines and #lines > max_lines then return true end
          return false
        end,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<C-S-space>",
        },
      },
      indent = { enable = true },
      ensure_installed = {
        "bash","c","diff","html","javascript","jsdoc","json","jsonc","lua","luadoc","luap",
        "markdown","markdown_inline","python","query","regex","toml","tsx","typescript",
        "vim","vimdoc","xml","yaml",
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.install").prefer_git = true
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false
      require("nvim-treesitter.configs").setup(opts)
    end,

    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", event = { "BufReadPost", "BufNewFile" } },
      { "nvim-treesitter/nvim-treesitter-context", enabled = false },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html","javascript","typescript","javascriptreact","typescriptreact","svelte","vue","tsx","jsx","xml","php","markdown","astro" },
    opts = {},
    config = function() require("nvim-ts-autotag").setup() end,
  },}
