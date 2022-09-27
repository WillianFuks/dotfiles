local pickers = {
  find_files = {
    --theme = "dropdown",
    hidden = false,
    --previewer = false,
  },
  live_grep = {
    --@usage don't include the filename in the search results
    only_sort_text = true,
    --theme = "dropdown",
  },
  grep_string = {
    only_sort_text = true,
    --theme = "dropdown",
  },
  buffers = {
    --theme = "dropdown",
    previewer = false,
    initial_mode = "normal",
  },
  planets = {
    show_pluto = true,
    show_moon = true,
  },
  git_files = {
    --theme = "dropdown",
    hidden = true,
    previewer = false,
    show_untracked = true,
  },
  lsp_references = {
    --theme = "dropdown",
    initial_mode = "normal",
  },
  lsp_definitions = {
    --theme = "dropdown",
    initial_mode = "normal",
  },
  lsp_declarations = {
    --theme = "dropdown",
    initial_mode = "normal",
  },
  lsp_implementations = {
    --theme = "dropdown",
    initial_mode = "normal",
  },
}

local actions = require "telescope.actions"

local config = {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    scroll_strategy = "limit",
    dynamic_preview_title = true,
    layout_strategy = "horizontal",
    layout_config = {
      width = 0.75,
      preview_cutoff = 120,
      horizontal = {
        preview_width = function(_, cols, _)
          if cols < 120 then
            return math.floor(cols * 0.5)
          end
          return math.floor(cols * 0.6)
        end,
        mirror = false,
      },
      vertical = { mirror = false },
    },
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-c>"] = actions.close,
        ["<C-j>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.cycle_history_prev,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<CR>"] = actions.select_default,
        ["<C-d>"] = require("telescope.actions").delete_buffer,
      },
      n = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["db"] = require("telescope.actions").delete_buffer,
      },
    },
    --pickers = pickers,
    file_ignore_patterns = { 'node_modules', '\\.pyc' },
    path_display = { 'absolute' },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  },
  pickers = pickers,
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
}

local telescope = require "telescope"
telescope.setup(config)

--  if lvim.builtin.project.active then
--    pcall(function()
--      require("telescope").load_extension "projects"
--    end)
--  end

telescope.load_extension "notify"

-- if config.telescope.on_config_done then
--   config.telescope.on_config_done(telescope)
-- end

if config.extensions and config.extensions.fzf then
    telescope.load_extension "fzf"
end

nnoremap('<C-f>', [[<cmd>lua require('telescope.builtin').find_files()<cr>]], 'Find Files Picker')
nnoremap('<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]], 'Grep words on files')
nnoremap('<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<cr>]], '')
nnoremap('<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<cr>]], '')
