local opt = vim.opt

opt.termguicolors = true
opt.hlsearch = true
opt.number = true
opt.mouse = "a"
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.clipboard = "unnamedplus"

vim.g.loaded_netrw = 2
vim.g.loaded_netrwPlugin = 1

vim.cmd("colorscheme nightfox")

-- KEYBINDS
local opts = { noremap = true, silent = true }

-- toggle nvim-tree
vim.keymap.set(
  'n', 
  '<leader>e',
  ':NvimTreeToggle<CR>', 
  opts 
)

-- view diagnostic information
vim.keymap.set(
  'n',
  '<leader>i',
  vim.diagnostic.open_float,
  opts
)

-- go to next diagnostic item
vim.keymap.set(
  'n',
  ']d',
  vim.diagnostic.goto_next,
  opts
)

-- go to previous diagnostic item
vim.keymap.set(
  'n',
  '[d',
  vim.diagnostic.goto_prev,
  opts
)

-- PLUGIN SETTINGS
require 'nvim-tree'.setup()

require 'lualine'.setup {
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "filename" },
    lualine_c = { "location" },
    lualine_x = { "diff", "diagnostics", "lsp_progress" },
    lualine_y = {},
    lualine_z = { "branch" }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" }
}

local on_attach = function (client, buffer)
end

local lsp_opts = { on_attach = on_attach }

require 'lspconfig'.rust_analyzer.setup (lsp_opts) -- rust
require 'lspconfig'.hls.setup (lsp_opts)           -- haskell
require 'lspconfig'.gdscript.setup (lsp_opts)      -- godot
require 'lspconfig'.clangd.setup (lsp_opts)        -- c/c++
require 'lspconfig'.bashls.setup (lsp_opts)        -- bash
require 'lspconfig'.html.setup (lsp_opts)          -- html/css
require 'lspconfig'.rnix.setup (lsp_opts)          -- nix

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "haskell" },
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

require 'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

require 'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
