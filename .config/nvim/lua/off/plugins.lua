if true then
	return {}
end
return {
	{
		"m00qek/baleia.nvim",
		lazy = false,
		cmd = "BaleiaColorize",
		version = "*",
		config = function()
			vim.g.baleia = require("baleia").setup({})
			-- Command to colorize the current buffer
			vim.api.nvim_create_user_command("BaleiaColorize", function()
				vim.g.baleia.once(vim.api.nvim_get_current_buf())
			end, { bang = true })
			-- Command to show logs
			vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
			--
			-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
			--   pattern = "*.txt",
			--   callback = function()
			--     vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
			--   end,
			-- })
			--
			-- vim.api.nvim_create_autocmd({ "BufReadPost" }, {
			--   pattern = "quickfix",
			--   callback = function()
			--     vim.api.nvim_set_option_value("modifiable", true, { buf = buffer })
			--     vim.g.baleia.automatically(vim.api.nvim_get_current_buf())
			--     vim.api.nvim_set_option_value("modified", false, { buf = buffer })
			--     vim.api.nvim_set_option_value("modifiable", false, { buf = buffer })
			--   end,
			-- })
		end,
	},
	{
		-- "Old-est/archive.nvim",
		dir = "~/Projects/archive.nvim/",
		lazy = true,
		config = function()
			require("archive").setup({
				storage = "tasks",
				task = {
					icon = "T ",
					colors = {
						status = { fg = "#ffd700", bg = "none", bold = true },
						task = { fg = "#52796f", bg = "none", bold = true },
						desc = { fg = "#ffd700", bg = "none", bold = true },
					},
					-- tags = {
					--   type = { name = "TYPE", default_value = M.get_type },
					--   status = { name = "STATUS", values = { "OPEN", "DONE", "INPROGRESS", "PAUSED" }, default_value = "OPEN" },
					--   priority = { name = "PRIORITY", default_value = M.get_priority },
					--   creation_date = { name = "OPEN DATE (UTC)", default_value = M.get_creation_time },
					--   close_date = { name = "CLOSE DATE (UTC)" },
					-- },
					tags_order = { "type", "status", "priority", "creation_date", "close_date" },
					source = {
						TODO = { priority = 30 },
						BUG = { priority = 50 },
						FIX = { priority = 40 },
					},
				},
				search = {
					command = "rg",
					args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
					root_markers = { ".git", "stylua.toml" },
				},
			})
			vim.keymap.set("n", "<A-t>", function()
				require("archive.task").create_task()
			end, { desc = "Create Task from Cursor" })
			vim.keymap.set("n", "<leader>pt", function()
				return Snacks.picker.pick("task")
			end, { desc = "Find Tasks" })
		end,
	},
	{
		"brenoprata10/nvim-highlight-colors",
		lazy = true,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		config = function()
			require("nvim-highlight-colors").setup({
				---Render style
				---@usage 'background'|'foreground'|'virtual'
				render = "background",
				---Set virtual symbol (requires render to be set to 'virtual')
				virtual_symbol = "■",
				---Set virtual symbol suffix (defaults to '')
				virtual_symbol_prefix = "",
				---Set virtual symbol suffix (defaults to ' ')
				virtual_symbol_suffix = " ",
				---Set virtual symbol position()
				---@usage 'inline'|'eol'|'eow'
				---inline mimics VS Code style
				---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
				---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
				virtual_symbol_position = "inline",
				---Highlight hex colors, e.g. '#FFFFFF'
				enable_hex = true,
				---Highlight short hex colors e.g. '#fff'
				enable_short_hex = true,
				---Highlight rgb colors, e.g. 'rgb(0 0 0)'
				enable_rgb = true,
				---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
				enable_hsl = true,
				---Highlight ansi colors, e.g '\033[0;34m'
				enable_ansi = true,
				-- Highlight hsl colors without function, e.g. '--foreground: 0 69% 69%;'
				enable_hsl_without_function = true,
				---Highlight CSS variables, e.g. 'var(--testing-color)'
				enable_var_usage = true,
				---Highlight named colors, e.g. 'green'
				enable_named_colors = false,
				---Highlight tailwind colors, e.g. 'bg-blue-500'
				enable_tailwind = true,
				---Set custom colors
				---Label must be properly escaped with '%' to adhere to `string.gmatch`
				--- :help string.gmatch
				-- custom_colors = {
				--   { label = "%-%-theme%-primary%-color", color = "#0f1219" },
				--   { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
				-- },
				-- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
				exclude_filetypes = {},
				exclude_buftypes = {},
				-- Exclude buffer from highlighting e.g. 'exclude_buffer = function(bufnr) return vim.fn.getfsize(vim.api.nvim_buf_get_name(bufnr)) > 1000000 end'
				exclude_buffer = function(bufnr) end,
			})
			vim.keymap.set("n", "<leader>oca", function()
				require("nvim-highlight-colors").turnOn()
			end, { silent = true, desc = "Colorizer Attach To Buffer" })
			vim.keymap.set("n", "<leader>oct", function()
				require("nvim-highlight-colors").toggle()
			end, { silent = true, desc = "Colorizer Toggle" })
			vim.keymap.set("n", "<leader>ocr", function()
				require("nvim-highlight-colors").turnOff()
				require("nvim-highlight-colors").turnOn()
			end, { silent = true, desc = "Colorizer Reload All Buffers" })
			vim.keymap.set("n", "<leader>ocd", function()
				require("nvim-highlight-colors").turnOff()
			end, { silent = true, desc = "Colorizer Detach To Buffer" })
		end,
	},
	{
		"mistweaverco/kulala.nvim",
		lazy = true,
		keys = {
			{ "<leader>Rs", desc = "Send request" },
			{ "<leader>Ra", desc = "Send all requests" },
			{ "<leader>Rb", desc = "Open scratchpad" },
		},
		ft = { "http", "rest" },
		opts = {
			global_keymaps = true,
			-- global_keymaps_prefix = "<leader>R",
			-- kulala_keymaps_prefix = "",
		},
	},
}
