return require('packer').startup(function()
  use { "wbthomason/packer.nvim" } -- necessary
  use { "folke/tokyonight.nvim" }  -- theme
  use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' } -- nice syntax code branches
  use { "nvim-treesitter/playground" } -- highlighting the code tree syntax
  use { "tpope/vim-fugitive" } -- git tool - need to thing about it
  use { "dmmulroy/tsc.nvim" } -- runs tsc compiler and checks syntax
  use { "lewis6991/gitsigns.nvim" } -- shows which lines were modified

  use {
	  'VonHeikemen/lsp-zero.nvim', -- merges nvim-cmp and nvim-lspconfig together
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'}, -- suggestions
		  {'hrsh7th/cmp-buffer'}, -- in insert mode use c-p and c-n to jump between suggestion, merges suggestion buffers
		  {'hrsh7th/cmp-path'}, -- add system path to suggestion box
		  {'saadparwaiz1/cmp_luasnip'}, -- advanced autocomplete to docs etc
		  {'hrsh7th/cmp-nvim-lsp'}, 
		  {'hrsh7th/cmp-nvim-lua'},
	  }
  }

  use { 'mhartington/formatter.nvim' } -- custom formatter
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' } -- file explorer
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } } -- fuzzy search
  use { 'windwp/windline.nvim' } -- status bar
  use { "mbbill/undotree" } -- undo history
  use { "nvim-treesitter/nvim-treesitter-context" } -- clever scrolling
end)
