lvim.builtin.telescope.defaults.file_ignore_patterns = {
  ".git/",
  "target/",
  "docs/",
  "vendor/*",
  "%.lock",
  "__pycache__/*",
  "%.sqlite3",
  "%.ipynb",
  "node_modules/*",
  "%.svg",
  "%.otf",
  "%.ttf",
  "%.webp",
  ".dart_tool/",
  ".github/",
  ".gradle/",
  ".idea/",
  ".settings/",
  ".vscode/",
  "__pycache__/",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "%.pdb",
  "%.dll",
  "%.class",
  "%.exe",
  "%.cache",
  "%.ico",
  "%.pdf",
  "%.dylib",
  "%.jar",
  "%.docx",
  "%.met",
  "smalljre_*/*",
  ".vale/",
  "%.burp",
  "%.mp4",
  "%.mkv",
  "%.rar",
  "%.zip",
  "%.7z",
  "%.tar",
  "%.bz2",
  "%.epub",
  "%.flac",
  "%.tar.gz",
}

lvim.builtin.telescope.pickers.previewer = true

lvim.builtin.telescope.pickers.live_grep = {
  theme = "dropdown",
}

lvim.builtin.telescope.pickers.grep_string = {
  theme = "dropdown",
}

lvim.builtin.telescope.pickers.find_files = {
  theme = "dropdown",
  -- previewer = false,
}

lvim.builtin.telescope.pickers.buffers = {
  theme = "dropdown",
  -- previewer = false,
  initial_mode = "normal",
}

-- lvim.builtin.telescope.pickers.planets = {
--   show_pluto = true,
--   show_moon = true,
-- }

lvim.builtin.telescope.pickers.colorscheme = {
  enable_preview = true,
}

lvim.builtin.telescope.pickers.lsp_references = {
  theme = "dropdown",
  initial_mode = "normal",
}

lvim.builtin.telescope.pickers.lsp_definitions = {
  theme = "dropdown",
  initial_mode = "normal",
}

lvim.builtin.telescope.pickers.lsp_declarations = {
  theme = "dropdown",
  initial_mode = "normal",
}

lvim.builtin.telescope.pickers.lsp_implementations = {
  theme = "dropdown",
  initial_mode = "normal",
}

-- lvim.builtin.telescope.defaults.selection_caret = "  "

-- TODO: Change code to pcall
-- if require'telescope'.extensions.project ~= nil then
--   lvim.builtin.which_key.mappings["s"]["p"] = {
--     name = "Projects",
--     ":SymbolsOutline<CR>",
--     "Toggle symbols outline from the LSP"
--   }
-- end
