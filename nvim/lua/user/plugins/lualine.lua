--from lvim
local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local colors = {
    green = '#98be65',
    red = '#ec5f67'
}


config = {
  options = {
    icons_enabled = true,
    theme = 'material',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    globalstatus = true,
  },
  sections = {
    lualine_a = {

        {
            function()
                local current_line = vim.fn.line '.'
                return table.concat({ 'L:', current_line })
            end
        }

    },
    lualine_b = {
        {
            "b:gitsigns_head",
            icon = "",
            separator = '|'
        },
        {
            'diff',
            source = diff_source,
            colored = false,
        },
        {
            'diagnostics',
             symbols = { error = " ", warn = " ", info = " ", hint = " " },
        }
    },
    lualine_c = {
        {
            'filename',
            newfile_status = true,
            path = 0,
        }
    },
    lualine_x = {
        {
            function()
              local shiftwidth = vim.api.nvim_buf_get_option(0, "shiftwidth")
              return table.concat({ ' ', shiftwidth })
            end,
            padding = 1,
        },
        --'encoding',
        'fileformat',
        {
            'filetype',
            icon_only = true,
        },
    },
    lualine_y = {
        {
            function()
              return ""
            end,
            color = function()
              local buf = vim.api.nvim_get_current_buf()
              local ts = vim.treesitter.highlighter.active[buf]
              return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
            end,
            separator = ''
       },
       {
           function(msg) return '' end,
           color = function()
               local buf_clients = vim.lsp.buf_get_clients()
               return { fg = next(buf_clients) ~= nil and colors.green or colors.red }
           end,

       }
    },
    lualine_z = {

        {
            function() return "  " end,
            padding = { left = 0, right = 0 },
            cond = nil,
        }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

require('lualine').setup(config)
