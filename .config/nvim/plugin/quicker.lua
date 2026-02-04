-- TODO: Add cutom setup to quicker
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		require("quicker").setup()
		vim.keymap.set("n", "<leader>qt", function()
			require("quicker").toggle()
		end, {
			desc = "Toggle quickfix",
		})
		vim.keymap.set("n", "<leader>lt", function()
			require("quicker").toggle({ loclist = true })
		end, {
			desc = "Toggle loclist",
		})
	end,
})
