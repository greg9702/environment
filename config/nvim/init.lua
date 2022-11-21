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

  use {
    "folke/tokyonight.nvim"
  }
  use "pantharshit00/vim-prisma"

  use "neovim/nvim-lspconfig"
  use {
    "hrsh7th/nvim-cmp",
    requires = { "hrsh7th/cmp-buffer",
    }
  }
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'mhartington/formatter.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'windwp/windline.nvim'
  use "github/copilot.vim"
  use 'ggandor/lightspeed.nvim'
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
vim.o.notermguicolors = true
vim.o.signcolumn = "yes"
require("tokyonight").setup({
  style = "night"
})
vim.g.tokyonight_style = "light"
vim.cmd[[colorscheme tokyonight]]
map("n", "<esc>", ":nohlsearch<CR>", default_opts)


-- Treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}


-- Tree
require'nvim-tree'.setup {
  filters = {
    custom = {".git", "node_modules", ".vscode"}
  },
  git = {
    ignore = true
  }
}
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)
map('n', '<C-j>', ':NvimTreeFindFile<CR>', default_opts)

-- LSP
local nvim_lsp = require('lspconfig')

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end


-- Servers

nvim_lsp.tailwindcss.setup{}
nvim_lsp.astro.setup{
  init_options = {
    typescript = {
      serverPath = "/usr/lib/node_modules/typescript/lib/tsserverlibrary.js"
    }
  }
}
nvim_lsp.prismals.setup{}
nvim_lsp.tsserver.setup{}
-- nvim_lsp.eslint.setup{}
nvim_lsp.terraformls.setup{}
nvim_lsp.graphql.setup{}
nvim_lsp.elixirls.setup{
  cmd = { "/usr/bin/elixir-ls" }
}
nvim_lsp.gopls.setup{}
nvim_lsp.jsonls.setup{
  cmd = { "vscode-json-languageserver", '--stdio' },
  settings = {
    json = {
      schemas = {
        {
          fileMatch = {'tsconfig.json', 'tsconfig.*.json'},
          url = 'http://json.schemastore.org/tsconfig'
        },
        {
          fileMatch = {'lerna.json'},
          url = 'http://json.schemastore.org/lerna'
        },
        {
          description = 'Prettier config',
          fileMatch = {'.prettierrc', '.prettierrc.json', 'prettier.config.json'},
          url = 'http://json.schemastore.org/prettierrc'
        },
        {
          fileMatch = {'package.json'},
          url = 'http://json.schemastore.org/package'
        },
      }
    },
  }
}

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
map('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', default_opts)
map('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', default_opts)
map('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', default_opts)
map('n', '<Leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', default_opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', default_opts)
map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', default_opts)
map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', default_opts)

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        underline = true
    }
)


local cmp = require("cmp")
cmp.setup({
    snippet = {
      expand = function(args)
        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<Tab>'] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Insert })
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
    }
  })

-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", default_opts)
map("n", "<C-t>", "<cmd>Telescope<CR>", default_opts)
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", default_opts)
require("telescope").setup{
  defaults = {
    file_ignore_patters = { "yarn.lock", "node_modules/*" }
  }
}


-- Formatter
local formatter_prettier =  {
  function()
    return {
      -- exe = "prettier",
      -- args = {
      --   "--stdin-filepath",
      --   vim.api.nvim_buf_get_name(0)
      -- },
      -- stdin = true,
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
    typescriptreact = formatter_prettier,
    json = formatter_prettier,
    graphql = formatter_prettier
  }
})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.astro,*.ts,*.tsx,*.mjs,*.js,*.jsx,*.json,*.graphql FormatWrite
augroup END
]], true)

vim.api.nvim_command("autocmd BufWritePre *.ex,*.go lua vim.lsp.buf.formatting()")

require('wlsample.airline')

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

map('i', '<C-j>', 'copilot#Accept()', { expr = true, silent = true})


-- vim.g.do_filetype_lua = 1
-- vim.g.did_load_filetypes = 0
vim.filetype.add({
  extension = {
    astro = "astro"
  }
})
