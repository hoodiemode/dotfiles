local opt = vim.opt

opt.termguicolors = true
opt.hlsearch = true
opt.number = true
opt.mouse = "a"
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.clipboard = "unnamedplus"

vim.g.loaded_netrw = 2
vim.g.loaded_netrwPlugin = 1

vim.cmd("colorscheme nightfox")

-- PLUGIN SETTINGS
require 'nvim-tree'.setup()

require 'lspconfig'.rust_analyzer.setup {} -- rust
require 'lspconfig'.hls.setup {}           -- haskell
require 'lspconfig'.gdscript.setup {}      -- godot
require 'lspconfig'.clangd.setup {}        -- c/c++
require 'lspconfig'.bashls.setup {}        -- bash
require 'lspconfig'.html.setup {}          -- html/css
require 'lspconfig'.rnix.setup {}          -- nix

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "cpp", "rust", "haskell" },
  sync_install = false,
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
