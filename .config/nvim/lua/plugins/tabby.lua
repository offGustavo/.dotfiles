return {
	{ "tiagovla/scope.nvim", lazy = false, config = true },
	{
		"nanozuki/tabby.nvim",
		lazy = false,
		config = function()
			local theme = {
				bg = "Normal",
				bg_alt = "lualine_b_normal",
				fg = "NormalNC",
				fill = "TabLineFill",
				head = "TabLine",
				current_tab = "lualine_a_normal",
				tab = "TabLine",
				win = "TabLine",
				tail = "TabLine",
			}

			-- Table to store CWD per tab
			local tab_cwd = {}

			-- Function to update CWD for current tab
			local function update_tab_cwd()
				local tabnr = vim.api.nvim_get_current_tabpage()
				local cwd = vim.fn.getcwd()
				tab_cwd[tabnr] = cwd
			end

			-- Function to get CWD for a specific tab
			local function get_tab_cwd(tabnr)
				return tab_cwd[tabnr] or vim.fn.getcwd()
			end

			-- Set up autocmd to track CWD changes
			vim.api.nvim_create_autocmd({ "DirChanged", "TabEnter", "VimEnter" }, {
				callback = update_tab_cwd,
			})

			-- Initial update
			update_tab_cwd()

			require("tabby").setup({
				line = function(line)
					return {
						"%=",
						line.tabs().foreach(function(tab)
							local hl = tab.is_current() and theme.current_tab or theme.bg
							local cwd = get_tab_cwd(tab.id)
							local cwd_name = vim.fn.fnamemodify(cwd, ":t")
							return {
								line.sep(" ", hl, theme.bg),
								tab.number(),
								{
									cwd_name .. "/",
									tab.name(),
								},
								tab.close_btn(""),
								line.sep(" ", hl, theme.bg),
								hl = hl,
								margin = " ",
							}
						end),
						line.spacer(),
					}
				end,
			})

			-- Keymaps
			vim.keymap.set("n", "<leader><Tab>r", ":TabRename ", { desc = "Rename Tab" })
			vim.keymap.set("n", "<leader><Tab>{", "<Cmd>-tabmove<Cr>", { desc = "Move Tab Left" })
			vim.keymap.set("n", "<leader><Tab>}", "<Cmd>+tabmove<Cr>", { desc = "Move Tab Right" })
			vim.keymap.set("n", "<leader><Tab>p", "<Cmd>Tabby pick_window<Cr>", { desc = "Pick Windows" })
		end,
	},
}
