vim.api.nvim_create_autocmd({ "VimEnter", "VimResume", "UIEnter" }, {
	group = vim.api.nvim_create_augroup("KittySetVarVimEnter", { clear = true }),
	callback = function()
		if vim.api.nvim_ui_send then
			vim.api.nvim_ui_send("\x1b]1337;SetUserVar=in_editor=MQo\007")
		else
			io.stdout:write("\x1b]1337;SetUserVar=in_editor=MQo\007")
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimLeave", "VimSuspend" }, {
	group = vim.api.nvim_create_augroup("KittyUnsetVarVimLeave", { clear = true }),
	callback = function()
		if vim.api.nvim_ui_send then
			vim.api.nvim_ui_send("\x1b]1337;SetUserVar=in_editor=MQo\007")
		else
			io.stdout:write("\x1b]1337;SetUserVar=in_editor\007")
		end
	end,
})

vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from System" })
vim.keymap.set({ "n", "v" }, "<C-s-v>", '"+p', { desc = "Paste from System" })
vim.keymap.set({ "n", "v" }, "<C-S-c>", '"+y', { desc = "Yank from System" })
vim.keymap.set({ "n", "v" }, "<D-c>", '"+y', { desc = "Yank from System" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to System" })
vim.keymap.set({ "n" }, "<C-S-c><C-S-c>", '"+yy', { desc = "Yank from System" })

-- vim.o.clipboard = "unnamed,unnamedplus"
