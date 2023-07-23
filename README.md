## Overview

Repository contains some configs "borrowed" :) and tuned to my needs.

### Nvim

#### Installation

1. install nerd fonts
2. install packer (https://github.com/wbthomason/packer.nvim)
3. install prettierd (https://github.com/fsouza/prettierd) and ripgrep (https://github.com/BurntSushi/ripgrep)
4. run `:PackerCompile` and `:PackerSync`
5. enjoy

#### List of plugins

- "wbthomason/packer.nvim" -- packer used for managing the plugins
- "folke/tokyonight.nvim" -- nice dark theme
- "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' -- highlighting code branches and makes code more readable
- "nvim-treesitter/playground" -- highlighting the code syntax
- "tpope/vim-fugitive" -- git tool
- "dmmulroy/tsc.nvim" -- running tsc compiler
- "lewis6991/gitsigns.nvim" -- showing which lines were modified on the lefthand side of a line number column
- 'neovim/nvim-lspconfig' -- providing LSP support
- 'VonHeikemen/lsp-zero.nvim', -- merging nvim-cmp and nvim-lspconfig together
- 'williamboman/mason.nvim' -- mason package manager
- 'williamboman/mason-lspconfig.nvim' - brigding gaps betewen lspconfig and mason
- 'hrsh7th/nvim-cmp' -- providing code suggestions
- 'hrsh7th/cmp-buffer' -- merging suggestion buffers
- 'hrsh7th/cmp-path' -- adding system path to suggestion box
- 'saadparwaiz1/cmp_luasnip' -- providing advanced autocomplete to docs etc
- 'hrsh7th/cmp-nvim-lsp' -- providing built-in language server client
- 'hrsh7th/cmp-nvim-lua' -- providing nvim-cmp source for neovim Lua API
- 'mhartington/formatter.nvim' -- formatting the code
- 'kyazdani42/nvim-tree.lua' -- providing file explorer
- 'nvim-telescope/telescope.nvim' -- providing fuzzy search
- 'windwp/windline.nvim' -- nice status bar
- "mbbill/undotree" -- providing undo history
- "nvim-treesitter/nvim-treesitter-context" -- providing clever scrolling

#### Key bindings cheat-sheet

- h,j,k,l - navigation
- space - \<leader\>
---
- C-w + h,j,k,l - change window
- :q - close window
- C-q - close window
- C-w + o - close all windows except current one
---
- y - copy
- d - cut
- p - paste
- "-+-p - paste from a clipboard
- "-+-y - copy to a clipboard
---
- / - grep in a file
- /\c - grep in a file, case insensitive
- C-f - search in all files
- \<leader\>-pf - search in all files (using rg)
- C-p - search in all files (using git ls-files)
---
- gd - go to definition
- gr - go to references
- C-o - go to the previous posistion
- \<leader\>-vd - show error in a pop up window
- \<leader\>-ca - show error fix proposals
- u - undo
- C-r - redo
- C-u - open undo history tree
---
- \<leader\>-gs - open git tool
(inside git tool)</br>
- s - stage file
- \- - unstage file
- \> - show file changes
- < - hide file changes
- = - toggle file changes
- X - checkout file (revert unstaged changes)
- cc - commit
- ca - commit with amend
---
- C-n - show files tree
- a - create new file / directory (to create folder add "/" at the end of a file name)
- d - delete file/directory
- x - cut a file / directory
- p - paste a file / directory
