return {
	"mason-org/mason-lspconfig.nvim",
	lazy = true,
	event = "VeryLazy",
	opts = {
		automatic_enable = true,
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {}, lazy = true, event = "VeryLazy" },
		-- "neovim/nvim-lspconfig", 
  },
}
