return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    enabled = false,
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    'echasnovski/mini.pairs',
    enabled = false,
    version = '*',
    event='InsertEnter',
    config=true
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    event='VeryLazy',
    config=true
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<leader>bq",
        function()
          require("mini.bufremove").delete(0)
        end,
        desc = "Delete Buffer",
      },
      -- stylua: ignore
      { "<leader>bQ", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },
  {
    'echasnovski/mini.splitjoin',
    version = '*',
    event='VeryLazy',
    opts = {
      mappings = {
        toggle = 'gs',
        split = '',
        join = '',
      },
      detect = {
        brackets = nil,
        separator = ',',
        exclude_regions = nil,
      },
      split = {
        hooks_pre = {},
        hooks_post = {},
      },
      join = {
        hooks_pre = {},
        hooks_post = {},
      },
    }
  },
}
