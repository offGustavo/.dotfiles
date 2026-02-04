vim.g.loaded_netrwPlugin = 1
vim.autocmd("User", {
  pattern = "Later",
  callback = function()
    require("yazi").setup({
      open_for_directories = true,
    })
  end,
})

vim.autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
    vim.keymap.set("n", "-", function()
      require("yazi").yazi()
    end)
	end,
})

