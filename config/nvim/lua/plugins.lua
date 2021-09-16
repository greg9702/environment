require("packer").startup(function()
  use "wbthomason/packer.nvim"

  use {
    "nvim-treesitter/nvim-treesitter",
    run = ':TSUpdate'
  }

  use "ghifarit53/tokyonight-vim"

  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip'
  use 'mhartington/formatter.nvim'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

end)

