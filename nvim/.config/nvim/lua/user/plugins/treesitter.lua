return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    opts = {
      parsers = {
        "bash","c","diff","html","javascript","jsdoc","json","jsonc","lua","luadoc","luap",
        "markdown","markdown_inline","python","query","regex","toml","tsx","typescript",
        "vim","vimdoc","xml","yaml",
      },

      -- performance guards
      max_filesize = 100 * 1024,
      max_lines = 5000,

      -- If true, also enable treesitter-based indentexpr (experimental upstream)
      enable_indentexpr = true,
    },

    config = function(_, opts)
      local ts = require("nvim-treesitter")

      ts.setup({
        install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- seems to be causing trouble, everytime when opening nvim it forces install of every parser
      -- ts.install(opts.parsers)

      -- Enable folds globally
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = false

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "FileType" }, {
        callback = function(ev)
          local buf = ev.buf
          local name = vim.api.nvim_buf_get_name(buf)
          if name == "" then return end

          -- filesize guard
          local ok_stat, stat = pcall(vim.loop.fs_stat, name)
          if ok_stat and stat and stat.size and stat.size > opts.max_filesize then
            return
          end

          -- line-count guard (avoids reading huge buffers into Lua)
          local line_count = vim.api.nvim_buf_line_count(buf)
          if line_count > opts.max_lines then
            return
          end

          pcall(vim.treesitter.start, buf)

          if opts.enable_indentexpr then
            pcall(function()
              vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end)
          end
        end,
      })
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html","javascript","typescript","javascriptreact","typescriptreact",
      "svelte","vue","tsx","jsx","xml","php","markdown","astro",
    },
    opts = {},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
