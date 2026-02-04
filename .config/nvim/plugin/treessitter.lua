-- build = ":TSUpdate",
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function() 
		require("nvim-treesitter").setup {
			indent = { enable = true },
			highlight = { enable = true },
			folds = { enable = true },
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"python",
				"query",
				"regex",
				"toml",
				"tsx",
				"nix",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			}
		}
	end
})
