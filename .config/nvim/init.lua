require("config.options")
require("config.lazy")
require("config.theme")


-- PERF:
vim.schedule(function()
	require("config.autocmds")
	require("config.keymaps")
	require("config.zoxide")
end)


