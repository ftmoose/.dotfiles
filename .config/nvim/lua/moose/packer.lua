-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

	-- Color scheme
  use {
	  "rebelot/kanagawa.nvim",
	  config = function()
		  vim.cmd('colorscheme kanagawa')
	  end
  }

	-- Telescope
  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

	-- Treesitter
  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	-- Harpoon
  use('theprimeagen/harpoon')

	-- Fugitive (Git wrapper)
  use('tpope/vim-fugitive')

	-- LSP
	use('neovim/nvim-lspconfig')
	use('j-hui/fidget.nvim')
	use('hrsh7th/nvim-cmp')
	use({
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		after = { "hrsh7th/nvim-cmp" },
		requires = { "hrsh7th/nvim-cmp" }
	})
	use('hrsh7th/vim-vsnip')
	use("simrat39/rust-tools.nvim")

	-- Nvim Tree
	use('nvim-tree/nvim-web-devicons')
	use {
		'nvim-tree/nvim-tree.lua',
		requires = {
			'nvim-tree/nvim-web-devicons', -- optional
		},
	}

	-- Other
	use('nvim-lua/popup.nvim')
	use('nvim-lua/plenary.nvim')

end)
