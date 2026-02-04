vim.autocmd = vim.api.nvim_create_autocmd
vim.defer = vim.defer_fn

vim.autocmd("VimEnter", {
	callback = function()
		vim.defer_fn(function()
			vim.api.nvim_exec_autocmds("User", { pattern = "Later" })
		end, 50)
	end,
})

vim.autocmd("VimEnter", {
	callback = function()
		vim.defer_fn(function()
			vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
		end, 100)
	end,
})

vim.pack.add(Fish.plugins.now)

vim.autocmd("User", {
  pattern = "Later",
  callback = function()
    vim.pack.add(Fish.plugins.later)
  end,
})
