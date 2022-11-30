local opt = vim.opt

-- ! generic vim options
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
opt.completeopt = { 'menu', 'menuone', 'noselect' }

vim.g.loaded_netrw = 2
vim.g.loaded_netrwPlugin = 1

vim.cmd("colorscheme nightfox")

-- ! plugin configuration

local opts = { noremap = true, silent = true }

-- toggle nvim-tree
vim.keymap.set('n', '<leader><tab>', ':NvimTreeToggle<CR>', opts)

-- view diagnostic information
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, opts)

-- go to next diagnostic item
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)

-- go to previous diagnostic item
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)

-- file explorer setup
require 'nvim-tree'.setup()

-- fancy modeline
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

-- keybinds to enable on lsp attachment
local on_attach = function (client, buffer)
  local bufopts = { noremap = true, silent = true, buffer = buffer }
  vim.keymap.set('n', '<leader>t', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>h', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>d', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>.', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>s', vim.lsp.buf.workspace_symbol, bufopts)
end

-- let lsp know about plugin stuff (may be different post nvim 0.8)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)

local lsp_opts = { on_attach = on_attach, capabilities = capabilities }

-- setup options for each language server
require 'lspconfig'.rust_analyzer.setup (lsp_opts) -- rust
require 'lspconfig'.hls.setup (lsp_opts)           -- haskell
require 'lspconfig'.gdscript.setup (lsp_opts)      -- godot
require 'lspconfig'.clangd.setup (lsp_opts)        -- c/c++
require 'lspconfig'.bashls.setup (lsp_opts)        -- bash
require 'lspconfig'.html.setup (lsp_opts)          -- html/css
require 'lspconfig'.rnix.setup (lsp_opts)          -- nix

local cmp = require 'cmp'

-- configure completion
cmp.setup {
  snippet = {
    expand = function (args)
      -- use vsnip for snippets
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  mapping = cmp.mapping.preset.insert {
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<C-down>'] = cmp.mapping.scroll_docs(1),
    ['<C-up>'] = cmp.mapping.scroll_docs(-1)
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  }, {
    { name = 'buffer' }
  })
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' }}),
})

-- configure treesitter to highlight
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
