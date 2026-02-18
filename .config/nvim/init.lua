-- We need to set this before
require("config.options")
require("config.clipboard")
-- Lazy.nvim/Plugins things
require("config.lazy")
-- Cool
require("fish.theme")

-- Our custom things
Fish = {}

-- PERF:
vim.schedule(function()
	require("config.autocmds")
	require("config.keymaps")
	require("config.zoxide")
	-- require("fish.espeto").setup()
end)
