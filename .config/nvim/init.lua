-- custom things
Fish = {}

vim.g.mapleader = " "
vim.cmd([[
let g:maplocalleader = "\<BS>"
]])

Fish.plugins = {
	now = {
    -- TODO: Remover depois
    "https://github.com/dstein64/vim-startuptime",
		"https://github.com/folke/tokyonight.nvim",
	},
	later = {
    "https://github.com/mikavilpas/yazi.nvim",
		"https://github.com/nvim-mini/mini.nvim",
		"https://github.com/folke/snacks.nvim",
		"https://github.com/ibhagwan/fzf-lua",
		"https://github.com/folke/noice.nvim",
		"https://github.com/folke/flash.nvim",
		"https://github.com/stevearc/quicker.nvim",
		"https://github.com/stevearc/conform.nvim",
		"https://github.com/brenton-leighton/multiple-cursors.nvim",
		-- These Things
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/williamboman/mason.nvim",
		"https://github.com/mason-org/mason-lspconfig.nvim",
		"https://github.com/nvim-treesitter/nvim-treesitter",
		"https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
		---
		"https://github.com/rafamadriz/friendly-snippets",
		"https://github.com/saghen/blink.cmp",
		-- Remove harpoon and yazi
		"https://github.com/nvim-lua/plenary.nvim",
		"https://github.com/OXY2DEV/markview.nvim",
		"https://github.com/offGustavo/md-agenda.nvim",
		"https://github.com/christoomey/vim-titlecase",
		"https://github.com/tpope/vim-eunuch",
		"https://github.com/tpope/vim-rsi",
		"https://github.com/HakonHarnes/img-clip.nvim",
		"https://github.com/m00qek/baleia.nvim",
	},
}

-- vim.g.loaded_netrwPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_fzf = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1

require("config.pack")
-- require("config.lazy")

vim.cmd("color tokyonight")
