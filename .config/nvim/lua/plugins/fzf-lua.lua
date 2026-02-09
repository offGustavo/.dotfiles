return {
	"ibhagwan/fzf-lua",
	cmd = "FzfLua",
	enabled = true,
	config = function()
		require("fzf-lua").register_ui_select()
		require("fzf-lua").setup({
			"ivy",
		})
	end,
	keys = {
		{ "<c-j>", "<c-j>", ft = "fzf", mode = "t", nowait = true },
		{ "<c-k>", "<c-k>", ft = "fzf", mode = "t", nowait = true },
		{
			"<leader>,",
			"<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>",
			desc = "Switch Buffer",
		},
		{ "<leader>/", "<Cmd>FzfLua live_grep<CR>", desc = "Grep (Root Dir)" },
		{ "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{
			"<leader><space>",
			"<cmd>FzfLua files<CR>",
			desc = "Find Files (Root Dir)",
		},
		-- find
		{ "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
		{ "<leader>fB", "<cmd>FzfLua buffers<cr>", desc = "Buffers (all)" },
		{
			"<leader>fc",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			"<cmd>FzfLua files<CR>",
			desc = "Find Files (Root Dir)",
		},
		{ "<leader>fF", "<cmd>FzfLua files<CR>", desc = "Find Files (cwd)" },
		{
			"<leader>fg",
			"<cmd>FzfLua git_files<cr>",
			desc = "Find Files (git-files)",
		},
		{ "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent" },
		-- git
		{ "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
		{ "<leader>gd", "<cmd>FzfLua git_diff<cr>", desc = "Git Diff (hunks)" },
		{ "<leader>gl", "<cmd>FzfLua git_commits<CR>", desc = "Commits" },
		{ "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Status" },
		{ "<leader>gS", "<cmd>FzfLua git_stash<cr>", desc = "Git Stash" },
		-- search
		{ '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Registers" },
		{ "<leader>s/", "<cmd>FzfLua search_history<cr>", desc = "Search History" },
		{ "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Auto Commands" },
		{ "<leader>sb", "<cmd>FzfLua lines<cr>", desc = "Buffer Lines" },
		{ "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
		{ "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Commands" },
		{ "<leader>sd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics" },
		{ "<leader>sD", "<cmd>FzfLua diagnostics_document<cr>", desc = "Buffer Diagnostics" },
		{ "<leader>sg", "<Cmd>FzfLua live_grep<CR>", desc = "Grep (Root Dir)" },
		{ "<leader>sG", "<Cmd>FzfLua live_grep<CR>", desc = "Grep (cwd)" },
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
		{
			"<leader>sH",
			"<cmd>FzfLua highlights<cr>",
			desc = "Search Highlight Groups",
		},
		{ "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Jumplist" },
		{ "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Key Maps" },
		{ "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Location List" },
		{ "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Man Pages" },
		{ "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Jump to Mark" },
		{ "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
		{ "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Quickfix List" },
		-- { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
		-- { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
		-- { "<leader>sw", LazyVim.pick("grep_visual"), mode = "x", desc = "Selection (Root Dir)" },
		-- { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "x", desc = "Selection (cwd)" },
		{ "<leader>uC", "<Cmd>FzfLua colorschemes<Cr>", desc = "Colorscheme with Preview" },
		{ "<leader>sr", "<cmd>FzfLua lsp_references<cr>", desc = "Lsp References" },
		{ "<leader>fa", "<cmd>FzfLua builtin<cr>", desc = "Fzf" },
		{
			"<leader>ss",
			function()
				require("fzf-lua").lsp_document_symbols({
					regex_filter = symbols_filter,
				})
			end,
			desc = "Goto Symbol",
		},
		{
			"<leader>sS",
			function()
				require("fzf-lua").lsp_live_workspace_symbols({
					regex_filter = symbols_filter,
				})
			end,
			desc = "Goto Symbol (Workspace)",
		},
	},
}
