return {
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
    dependencies = { "echasnovski/mini.comment" },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = 'gc',

        -- Toggle comment on current line
        comment_line = '<leader>c',

        -- Toggle comment on visual selection
        comment_visual = '<leader>c',

        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        -- Works also in Visual mode if mapping differs from `comment_visual`
        textobject = 'gc',
      }
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
