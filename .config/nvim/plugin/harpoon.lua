vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- vim.pack.add({ { src = "https://github.com/otavioschwanck/arrow.nvim" } })
		-- require("arrow").setup({
		-- 	show_icons = true,
		-- 	leader_key = "<M-m>", -- Recommended to be a single key
		-- 	buffer_leader_key = "<M-b>", -- Per Buffer Mappings
		-- })
		--   vim.pack.add({
		--       src  = "https://github.com/ThePrimeagen/harpoon",
		--       version = 'harpoon2',
		--   })
		-- vim.keymap.set("n", "<leader>ha", function() require("harpoon"):list():add() end, { desc = "Harpoon Add" })
		-- vim.keymap.set("n", "<leader>he", function()
		-- 	local harpoon = require("harpoon")
		-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
		-- end, { desc = "Harpoon Menu" })
		--
		-- for i = 1, 9, 1 do
		-- 	vim.keymap.set("n", "<leader>" .. i, function()
		-- 		require("harpoon"):list():select(i)
		-- 	end, { desc = "Harpoon Add" })
		-- 	vim.keymap.set("n", "<leader>h" .. i, function()
		-- 		require("harpoon"):list():replace_at(i)
		-- 	end, { desc = "Harpoon Add" })
		-- end
	end,
})
