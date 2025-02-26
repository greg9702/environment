return require('packer').startup(function()
  use { "wbthomason/packer.nvim" } -- necessary
  use { "folke/tokyonight.nvim" }  -- theme
  use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' } -- nice syntax code branches
  use { "nvim-treesitter/playground" } -- highlighting the code tree syntax
  use { "tpope/vim-fugitive" } -- git tool - need to thing about it
  use { "dmmulroy/tsc.nvim" } -- runs tsc compiler and checks syntax
  use { "lewis6991/gitsigns.nvim" } -- shows which lines were modified

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  }

  use { 'mhartington/formatter.nvim' } -- custom formatter
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' } -- file explorer
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } } -- fuzzy search
  use { 'windwp/windline.nvim' } -- status bar
  use { "mbbill/undotree" } -- undo history
  use { "nvim-treesitter/nvim-treesitter-context" } -- clever scrolling

  use { 'theprimeagen/harpoon' }
end)
