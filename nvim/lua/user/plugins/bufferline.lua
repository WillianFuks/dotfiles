local config = {
    options = {
        mode = "buffers",
        numbers = "none",
        close_command = nil,
        right_mouse_command = nil,
        left_mouse_command = nil,
        middle_mouse_command = nil,
        indicator = {
            icon = '▎',
            style = 'icon'
        },
        name_formatter = function(buf)  -- buf contains:
            return buf.name
        end,
        max_name_length = 18,
        max_prefix_length = 15,
        truncate_names = true,
        tab_size = 18,
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local result = {}
            local symbols = { error = "", warning = "", info = "" }
            if not lvim.use_icons then
              return "(" .. num .. ")"
            end
            for name, count in pairs(diagnostics) do
              if symbols[name] and count > 0 then
                table.insert(result, symbols[name] .. " " .. count)
              end
            end
            result = table.concat(result, " ")
            return #result > 0 and result or ""
        end,
        custom_filter = nil,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                padding = 1,
                separator = true
            }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_buffer_default_icon = true,
        show_close_icon = false,
        show_tab_indicators = false,
        show_duplicate_prefix = true,
        persist_buffer_sort = true,
        separator_style = 'slant',
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        hover = {
            enabled = false,
            delay = 200,
            reveal = {'close'}
        },
        sort_by = 'insert_after_current'
    }
}

require('bufferline').setup({ options = config.options })

nnoremap('<Tab>', [[<cmd>lua require('bufferline').cycle(1)<cr>]], 'Cycles through the buffers moving forward')
nnoremap('<S-Tab>', [[<cmd>lua require('bufferline').cycle(-1)<cr>]], 'Cycles through the buffers moving backwards')
