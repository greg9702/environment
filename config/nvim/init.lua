-- Plugins
local packer = require("packer")
local util = require("packer.util")
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

packer.startup(function()
  use "wbthomason/packer.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate'
  }

  use "ghifarit53/tokyonight-vim"

  use "neovim/nvim-lspconfig"
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer",
    }
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'mhartington/formatter.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
end)

-- Simple keybinding
local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Appearance
vim.o.number = true
vim.o.numberwidth = 1
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.mouse = "a"
vim.o.foldlevel = 99
vim.o.foldmethod = "indent"
vim.o.foldenable = true
vim.o.termguicolors = true
vim.o.signcolumn = "yes"
vim.g.colors_name = "tokyonight"
map("n", "<esc>", ":nohlsearch<CR>", default_opts)


-- Treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}


-- Tree
vim.g.nvim_tree_ignore = {".git", "node_modules", ".build", ".vscode"}
vim.g.nvim_tree_gitignore = 1
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)
map('n', '<C-m>', ':NvimTreeFindFile<CR>', default_opts)

-- LSP
local nvim_lsp = require('lspconfig')
vim.fn.sign_define("LspDiagnosticsSignError",
    {text = "", texthl = "Red"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
    {text = "", texthl = "Yellow"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
    {text = "", texthl = "Blue"})
vim.fn.sign_define("LspDiagnosticsSignHint",
    {text = "", texthl = "Aqua"})

-- Servers
nvim_lsp.tsserver.setup{}

map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', default_opts)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', default_opts)
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', default_opts)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', default_opts)
map('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', default_opts)
map('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', default_opts)
map('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', default_opts)
map('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', default_opts)
map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', default_opts)
map('n', '<Leader>ac', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
map('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', default_opts)
map('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', default_opts)
map('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', default_opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', default_opts)
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', default_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        underline = true
    }
)


local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})

-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", default_opts)
map("n", "<C-t>", "<cmd>Telescope<CR>", default_opts)
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", default_opts)
require("telescope").setup{
  defaults = {
    file_ignore_patters = { "yarn.lock" }
  }
}


-- Formatter
local formatter_prettier =  {
  function()
    return {
      exe = "prettierd",
      args = {vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
  end
}

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = formatter_prettier,
    javascriptreact = formatter_prettier,
    typescript = formatter_prettier,
    typescriptreact = formatter_prettier
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.ts,*.tsx,*.js,*.jsx FormatWrite
augroup END
]], true)
