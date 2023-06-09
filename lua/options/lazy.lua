local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "; -- Set the <leader> in the remaps
vim.g.maplocalleader = " "; -- Set the <leader> in the remaps

local plugins = {
	{'rose-pine/neovim', name = 'rose-pine' },
	{
		"nvim-neo-tree/neo-tree.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	'nvim-tree/nvim-web-devicons', -- icons
	"ThePrimeagen/harpoon",-- File navigation with marks
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { {'nvim-lua/plenary.nvim'} }
	}, -- Quick open
	'BurntSushi/ripgrep', -- used for search
	"mbbill/undotree", -- Shows all modifications
	"tpope/vim-fugitive", -- Git support
	'lewis6991/gitsigns.nvim', -- Git Annotations
	{'nvim-treesitter/nvim-treesitter',-- Theme support etc - nvim-treesitter
		build = ':TSUpdate' -- Theme support etc - nvim-treesitter
	},
	{
		'VonHeikemen/lsp-zero.nvim',
		dependencies = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},
			{'williamboman/mason.nvim'},
			{'williamboman/mason-lspconfig.nvim'},
		 {
			'nvim-lualine/lualine.nvim',
			dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true }
		},
			-- Autocompletion
			{'hrsh7th/nvim-cmp'},
			{'hrsh7th/cmp-nvim-lsp'},
			{'hrsh7th/cmp-buffer'}, 
			{'hrsh7th/cmp-path'},
			{'saadparwaiz1/cmp_luasnip'},
			{'hrsh7th/cmp-nvim-lua'},

			-- Snippets
			{'L3MON4D3/LuaSnip'},
			{'rafamadriz/friendly-snippets'},
		}
	}, -- Lsp support (Autocompletion)
	'mfussenegger/nvim-jdtls',
	{
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	}, -- Autocompletion for pairs "()"
	{'windwp/nvim-ts-autotag'} -- autoclose html tags
}

local opts = {}

require("lazy").setup(plugins, opts)
