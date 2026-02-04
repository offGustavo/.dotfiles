if true then return end
-- local ivy_like = {
--             preview = false,
--             layout = {
--               box = "vertical",
--               backdrop = false,
--               row = -1,
--               width = 0,
--               height = 0.4,
--               border = "top",
--               title = " {title} {live} {flags}",
--               title_pos = "left",
--               {
--                 box = "horizontal",
--                 { win = "list", border = "none" },
--                 { win = "preview", width = 0.6, border = "rounded" },
--               },
--               { win = "input", height = 1, border = "none" },
--             },
--           }

-- TODO: improve and fix the layouts

-- local ivy_like = { preset = "ivy", layout = { position = "bottom" } }

local ivy_like = {
	preview = "main",
	layout = {
		box = "vertical",
		backdrop = false,
		width = 0,
		height = 0.4,
		position = "bottom",
		border = "top",
		title = " {title} {live} {flags}",
		title_pos = "left",
		{ win = "preview", title = "{preview}", width = 0.6, border = "none" },
		{ win = "input", height = 1, border = "none" },
		{
			box = "horizontal",
			{ win = "list", border = "none" },
		},
	},
}

local genga = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣯⠲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣏⢧⠀⠛⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡗⡞⡆⠀⠈⠛⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⢡⢻⡄⠀⠀⠀⠙⢦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⢥⢊⢷⡈⠔⠠⠐⢆⣩⢢⡀⢀⣿⣦⡀⠀⣤⠀⠀⠀⢀⣀⣤⢴⡶⡻⣍⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⢎⡱⢊⠗⣌⠣⡜⣨⠑⣎⠹⣲⠿⣯⠻⡾⣟⣧⣴⡞⣯⢻⡜⣧⢻⣵⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣏⠲⣄⣀⠀⠀⠀⠀⠀⢸⡘⢆⡫⠜⣤⠳⣘⠤⣋⠴⠃⠇⠙⠄⠓⠑⠢⠒⠦⡙⢬⠫⡝⢾⣣⣯⣤⢤⣤⣴⠆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠸⣿⡻⢟⠧⣠⠘⠻⢄⡀⠀⠀⠀⡿⡘⢤⡛⣄⡇⠃⢀⠀⠀⡀⠀⠀⠄⡀⢀⠃⠘⠀⠣⡘⢇⠻⡄⢇⡛⠿⣼⣼⠃⣀⣀⠀⣀⡀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀
⠀⢈⣳⢩⠒⡭⢲⡀⠀⠈⠓⢤⣀⡷⣩⡶⡛⣥⠀⠀⠀⠀⢀⠀⠀⠁⢂⠐⠠⠀⠀⠌⠐⠈⡌⠓⡜⢣⢍⠳⣌⠯⡱⣄⠈⠉⠁⠉⠁⢈⠀⠁⢀⠀⢀⠀⣄⣤⠶⣻⠟⠁
⠀⠛⠲⢧⡹⣐⢣⠹⢦⡀⢦⡘⣼⡿⣋⠴⢛⡁⠀⠠⠁⢀⠠⠀⠌⠀⠀⠠⠁⠀⠂⢀⠁⠂⢌⠱⣈⠇⣎⠳⣌⠳⡱⡌⠖⡄⠂⠌⡐⠠⢀⣂⣤⠖⡞⣹⢣⡾⠋⠀⠀⠀
⠀⠀⠀⠈⢳⡱⣊⢕⢪⡙⢮⠳⣉⠖⣡⡾⠋⠀⢰⡀⠀⠠⠀⠀⠀⢀⠀⠁⠠⠐⠀⢂⠈⡐⡈⠔⣌⠚⣤⠛⣌⢳⠱⡸⢱⢈⡡⠤⢖⡻⢍⠳⣌⠳⣜⠗⠋⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠈⢳⡱⣊⢦⡙⣌⢣⠕⣪⠑⢦⡑⢲⡬⣇⠠⠐⠀⠁⢀⠀⡀⠌⠐⡀⢁⠂⢄⢠⡑⢎⡔⣫⢔⡫⣜⡡⢇⡳⡱⢪⢕⡋⢦⢣⡙⢖⣬⠟⠁⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢻⡜⣶⣋⢦⠓⡎⢥⠛⡤⢭⠋⠀⢸⡄⠀⠌⡐⢀⠂⠄⡈⠄⡐⠠⢌⢢⠦⣙⢦⡹⢔⠮⡱⢦⠹⡜⢲⠍⣇⠞⣌⢣⢲⡽⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⣹⠳⡜⢦⠛⣜⢢⡛⢬⡏⡀⠀⠀⢿⣆⠰⣈⢦⣐⠠⣐⠢⣜⡱⢎⡣⢞⡡⢖⡍⣎⣳⡽⣌⠳⣉⢧⢚⣼⡚⣴⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢠⢇⡻⢌⠧⡛⣼⡧⢜⡡⣇⠁⢀⠀⢾⣏⢧⡙⢦⣃⠯⣔⢫⡔⠣⣜⠱⣣⣙⡦⠟⠉⣷⡱⣌⢣⢣⢎⡣⢞⡟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡼⢠⠙⣎⢳⡹⢴⠻⣎⠵⣙⠦⣅⡓⠀⠸⣶⡙⢦⢃⡞⢬⠲⣌⠓⣬⡷⠛⠉⠀⠠⢀⡷⡳⣌⠇⡞⣰⠹⣌⣯⢛⡳⣒⢖⡲⣒⠖⣦⠤⠤⢀⡀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⡏⠤⡙⡌⢧⡹⢾⠀⠈⠷⣎⡹⡜⣭⢛⠿⡽⡜⣣⢣⠞⣡⢳⡼⠛⠹⠃⠀⠀⠠⢡⡼⢳⡱⢪⡙⣖⣡⠓⣼⢧⢫⠴⣩⠎⡵⣸⢘⡴⢋⡽⠻⠤⣀⠀⠀
⠀⠀⠀⠀⠀⠀⣟⠰⢠⡙⢮⢵⣻⡄⠀⢠⠋⠳⢽⣰⢋⢮⡱⢎⡵⢪⡙⣖⢫⠗⣤⣀⣀⣀⣄⣶⠫⡝⣣⡕⣣⠝⡴⣊⡝⢦⣋⢎⢧⡑⢮⠱⢎⡱⢎⡵⢊⡟⠛⠉⠀⠀
⠀⠀⠀⠀⠀⠀⣏⠲⣁⢾⣩⣞⠶⣷⡀⡎⠀⠀⠀⠉⡛⠲⠽⣎⣜⢧⣙⢦⣋⠾⡰⢭⡹⣙⢞⡰⢫⣴⣟⡱⢣⢏⠶⡱⢎⡳⡜⣎⠶⣙⢦⢛⣬⡳⠗⠛⠳⠇⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣯⢳⡰⢊⡷⣯⢿⣹⣟⣧⠀⠀⠀⢠⠃⠀⠀⠀⠈⠉⠙⠲⠛⠚⠽⠷⠓⡟⠚⠋⣩⡟⣴⢫⡝⣮⢳⣝⣻⡵⣹⣬⣳⠽⠚⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⣴⣿⡧⡽⣭⣻⣽⣯⢷⣻⣞⣷⣦⡀⡼⠀⠀⠀⠀⠀⠀⢀⡇⠀⠀⠀⠀⢰⠁⢀⣼⢧⣻⣜⣧⢿⣼⣳⢾⠟⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣸⢿⣿⣷⡝⣾⣷⣿⣿⣿⣿⣽⣾⣟⣿⣷⣦⣤⣀⡀⠀⠀⢸⠀⠀⠀⠀⢀⣮⣶⣿⣽⣯⣷⢿⣞⣿⢾⣽⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣿⡓⣞⡿⣿⣳⣿⡿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⡿⣟⣾⣯⣷⣿⣿⣯⣿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣷⠙⣦⢻⣽⣿⢻⣽⣿⣿⡟⣿⣯⣿⣿⣾⣿⣿⢻⣽⣿⣿⣷⣿⣯⣿⣿⣽⣿⣿⢻⣽⣿⣽⣾⣿⣿⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠸⣷⣊⠶⣭⢻⣿⣿⣯⣷⣿⣿⣿⡿⣿⣿⢿⣻⣿⣿⣿⣿⣿⣻⣿⢿⡽⢏⡳⢬⢣⣓⢮⡻⢿⣿⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠙⢿⣾⣼⣿⣳⣿⣿⣯⡷⣿⡷⣿⣿⢿⣿⣿⣿⢿⣿⣻⣿⣿⢯⡛⣜⢣⡝⣎⢳⢬⠳⣝⢯⡿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⢻⣷⣿⣷⣿⣿⠛⢷⣻⡽⣯⢿⣿⡾⣿⡿⣟⣿⡿⣞⣯⢳⣌⢳⡜⡬⢓⢮⣹⡞⡿⣜⡷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠟⢿⡏⠙⠀⠀⠈⠙⠿⢿⣾⣟⣿⣽⣿⣻⣽⡻⣜⢯⣲⢯⡛⣴⢻⣋⠷⣩⢓⡎⡗⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠻⣿⣿⢿⣿⠏⠉⠙⢯⢎⡳⢎⣵⣏⣶⣯⢒⠥⣋⣼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠿⠏⠀⠀⠀⠈⢧⡝⣾⣿⣿⣿⣿⣾⣿⡼⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⣿⣿⣳⡿⣞⡿⠊⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠛⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀]]

local devil = [[
 ███     █████                       ███  ████ 
░███    ░░███                       ░░░  ░░███ 
░███  ███████   ██████  █████ █████ ████  ░███ 
░███ ███░░███  ███░░███░░███ ░░███ ░░███  ░███ 
░███░███ ░███ ░███████  ░███  ░███  ░███  ░███ 
░░░ ░███ ░███ ░███░░░   ░░███ ███   ░███  ░███ 
 ███░░████████░░██████   ░░█████    █████ █████
░░░  ░░░░░░░░  ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ]]

local cc_dashboard_config = {
	enabled = false,
	preset = {
		-- pick = function(cmd, opts)
		--   return LazyVim.pick(cmd, opts)()
		-- end,
		header = genga,
    -- stylua: ignore
    ---@type snacks.dashboard.Item[]
    keys = {
      -- { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
      -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
      -- { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
      -- { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
      -- { icon = " ", key = "z", desc = "Change Directory", action = ":lua Snacks.dashboard.pick('zoxide')" },
      -- { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
      -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
      -- { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
      -- { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
      -- { icon = " ", key = "q", desc = "Quit", action = ":qa" },
    },
	},
	sections = {
		{ section = "header" },
		-- {
		-- 	-- pane = 2,
		-- 	section = "startup",
		-- 	padding = { 1, 0 },
		-- },
		-- {
		--   pane = 2,
		--   section = "terminal",
		--   -- cmd = "pokeget --hide-name bulbasaur",
		--   cmd = "colorscript -e square",
		--   -- cmd = "colorscript -e pacman",
		--   -- cmd = "chafa ~/Pictures/Wallpapers/my/gengara.jpg --format symbols --symbols vhalf --size 60x11 --stretch",
		--   -- cmd = "fzf",
		--   height = 7,
		--   padding = { 2, 0 },
		--   -- indent = 10,
		-- },
		-- {
		--   pane = 2,
		--   icon = " ",
		--   desc = "Browse Repo",
		--   padding = 1,
		--   key = "b",
		--   action = function()
		--     Snacks.gitbrowse()
		--   end,
		-- },
		-- { section = "keys", gap = 1, padding = 1 },
		-- { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
		-- { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
		-- {
		--   pane = 2,
		--   icon = " ",
		--   title = "Git Status",
		--   section = "terminal",
		--   enabled = function()
		--     return Snacks.git.get_root() ~= nil
		--   end,
		--   cmd = "git status --short --branch --renames",
		--   height = 5,
		--   padding = 1,
		--   ttl = 5 * 60,
		--   indent = 3,
		-- },
	},
}

local cc_picker_config = {
	sources = {
		grep = { hidden = true, layout = ivy_like },
		git_log = { hidden = true, layout = ivy_like },
		buffers = { hidden = true, layout = ivy_like },
		recent = { hidden = true, layout = ivy_like },
		smart = {
			hidden = true,
			layout = ivy_like,
		},
		files = {
			hidden = true,
			layout = ivy_like,
		},
	},
	layout = ivy_like,
}

local cc_animate_config = {
	duration = 1, -- ms per step
	easing = "linear",
	fps = 120, -- frames per second. Global setting for all animations
}

local cc_keys = {
	{
		"<leader><space>",
		function()
			Snacks.picker.smart({
				-- finder = "explorer",
				-- tree = true,
				hidden = true,
				matcher = {
					frequency = true,
				},
				win = {
					input = {
						keys = {
							["d"] = "bufdelete",
							["J"] = "preview_scroll_down",
							["K"] = "preview_scroll_up",
							["H"] = "preview_scroll_left",
							["L"] = "preview_scroll_right",
							["-"] = "explorer_up",
							["<Bs>"] = "explorer_up",
							["<"] = "explorer_up",
							[">"] = "explorer_cd", -- CHANGE DIR into selected folder
							-- ["<CR>"] = "explorer_cd",  -- Enter also enters dir
							["h"] = "explorer_close", -- close directory
							["a"] = "explorer_add",
							["D"] = "explorer_del",
							["r"] = "explorer_rename",
							["c"] = "explorer_copy",
							["m"] = "explorer_move",
							["o"] = "explorer_open", -- open with system application
							["<c-o>"] = { "toggle_preview", mode = { "i", "n" } },
							["P"] = "toggle_preview",
							["y"] = { "explorer_yank", mode = { "n", "x" } },
							["p"] = "explorer_paste",
							["u"] = "explorer_update",
							--TODO: add this to explorer
							["z"] = "cd",
							["Z"] = "tcd",
							["<leader>/"] = "picker_grep",
							["t"] = "terminal",
							-- ["."] = "explorer_focus",
							["I"] = "toggle_ignored",
							["."] = "toggle_hidden",
							["M"] = "explorer_close_all",
							["]g"] = "explorer_git_next",
							["[g"] = "explorer_git_prev",
							["]d"] = "explorer_diagnostic_next",
							["[d"] = "explorer_diagnostic_prev",
							["]w"] = "explorer_warn_next",
							["[w"] = "explorer_warn_prev",
							["]e"] = "explorer_error_next",
							["[e"] = "explorer_error_prev",
							--FIXME: dont work
							["e"] = function(prompt)
								local item = prompt.item
								if not item or not item.path then
									return
								end
								local path = item.path
								local stat = vim.loop.fs_stat(path)
								if stat and stat.type == "file" then
									path = vim.fn.fnamemodify(path, ":h")
								end
								Snacks.picker.explorer({
									cwd = path,
									hidden = true,
								})
							end,
						},
					},
					list = {
						keys = {
							["<C-o>"] = "toggle_preview",
							["d"] = "bufdelete",
							["J"] = "preview_scroll_down",
							["K"] = "preview_scroll_up",
							["H"] = "preview_scroll_left",
							["L"] = "preview_scroll_right",
						},
					},
				},
			})
		end,
		desc = "Snacks Smart Picker",
	},
	{
		"<leader>fa",
		function()
			Snacks.picker()
		end,
		desc = "All Snacks Pickers",
	},
	{
		"<leader>sP",
		function()
			Snacks.picker.grep({
				hidden = true,
				cwd = vim.fn.stdpath("config"),
			})
		end,
		desc = "Zoxide Picker",
	},
	{
		"<leader>,",
		function()
			Snacks.picker.buffers({
				-- I always want my buffers picker to start in normal mode
				-- on_show = function()
				--   vim.cmd.stopinsert()
				-- end,
				finder = "buffers",
				format = "buffer",
				hidden = false,
				unloaded = true,
				current = true,
				sort_lastused = true,
				win = {
					input = {
						keys = {
							["d"] = "bufdelete",
						},
					},
					list = { keys = { ["d"] = "bufdelete" } },
				},
				-- In case you want to override the layout for this keymap
				-- layout = "ivy",
			})
		end,
		desc = "Snacks Buffers Picker",
	},
	{
		"<leader><",
		function()
			Snacks.picker.buffers({
				-- I always want my buffers picker to start in normal mode
				-- on_show = function()
				--   vim.cmd.stopinsert()
				-- end,
				finder = "buffers",
				format = "buffer",
				hidden = true,
				unloaded = true,
				current = true,
				sort_lastused = true,
				win = {
					input = {
						keys = {
							["d"] = "bufdelete",
						},
					},
					list = { keys = { ["d"] = "bufdelete" } },
				},
				-- In case you want to override the layout for this keymap
				-- layout = "ivy",
			})
		end,
		desc = "Snacks Buffers Picker",
	},
	{
		"<leader>/",
		function()
			Snacks.picker.grep({
				hidden = true,
			})
		end,
		desc = "Snacks Live Grep",
	},
	{
		"<leader>ow",
		function()
			Snacks.picker.grep({
				hidden = true,
				on_show = function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-r><C-a>", true, false, true), "i", true)
				end,
			})
		end,
		desc = "Grep cWord (root)",
	},
	{
		"<leader>oW",
		function()
			Snacks.picker.grep({
				hidden = true,
				cwd = ".",
				on_show = function()
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-r><C-a>", true, false, true), "i", true)
				end,
			})
		end,
		desc = "Grep cWord (cwd)",
	},
	{
		"<leader>lg",
		function()
			Snacks.lazygit()
			vim.keymap.set("t", "<Esc><Esc>", "<Esc><Esc>", { buffer = 0 })
			vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = 0 })
		end,
		desc = "Lazygit (cwd)",
	},
	{
		"<A-p>g",
		function()
			Snacks.lazygit()
			vim.keymap.set("t", "<Esc><Esc>", "<Esc><Esc>", { buffer = 0 })
			vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = 0 })
		end,
		desc = "Lazygit (cwd)",
	},
	{
		"<leader>gG",
		function()
			Snacks.lazygit()
			vim.keymap.set("t", "<Esc><Esc>", "<Esc><Esc>", { buffer = 0 })
			vim.keymap.set("t", "<Esc>", "<Esc>", { buffer = 0 })
		end,
		desc = "Lazygit (cwd)",
	},
	-- Top Pickers & Explorer
	{
		"<leader>,",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<leader>/",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>:",
		function()
			Snacks.picker.command_history()
		end,
		desc = "Command History",
	},
	{
		"<leader>n",
		function()
			Snacks.picker.notifications()
		end,
		desc = "Notification History",
	},
	-- find
	{
		"<leader>fb",
		function()
			Snacks.picker.buffers()
		end,
		desc = "Buffers",
	},
	{
		"<leader>fc",
		function()
			Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "Find Config File",
	},
	{
		"<leader>ff",
		function()
			Snacks.picker.files()
		end,
		desc = "Find Files",
	},
	{
		"<leader>fg",
		function()
			Snacks.picker.git_files()
		end,
		desc = "Find Git Files",
	},
	{
		"<leader>fp",
		function()
			Snacks.picker.projects()
		end,
		desc = "Projects",
	},
	{
		"<leader>fr",
		function()
			Snacks.picker.recent()
		end,
		desc = "Recent",
	},
	-- git
	{
		"<leader>gb",
		function()
			Snacks.picker.git_branches()
		end,
		desc = "Git Branches",
	},
	{
		"<leader>gl",
		function()
			Snacks.picker.git_log()
		end,
		desc = "Git Log",
	},
	{
		"<leader>gL",
		function()
			Snacks.picker.git_log_line()
		end,
		desc = "Git Log Line",
	},
	{
		"<leader>gs",
		function()
			Snacks.picker.git_status()
		end,
		desc = "Git Status",
	},
	{
		"<leader>gS",
		function()
			Snacks.picker.git_stash()
		end,
		desc = "Git Stash",
	},
	{
		"<leader>gd",
		function()
			Snacks.picker.git_diff()
		end,
		desc = "Git Diff (Hunks)",
	},
	{
		"<leader>gf",
		function()
			Snacks.picker.git_log_file()
		end,
		desc = "Git Log File",
	},
	-- gh
	{
		"<leader>gi",
		function()
			Snacks.picker.gh_issue()
		end,
		desc = "GitHub Issues (open)",
	},
	{
		"<leader>gI",
		function()
			Snacks.picker.gh_issue({ state = "all" })
		end,
		desc = "GitHub Issues (all)",
	},
	{
		"<leader>gp",
		function()
			Snacks.picker.gh_pr()
		end,
		desc = "GitHub Pull Requests (open)",
	},
	{
		"<leader>gP",
		function()
			Snacks.picker.gh_pr({ state = "all" })
		end,
		desc = "GitHub Pull Requests (all)",
	},
	-- Grep
	{
		"<leader>sb",
		function()
			Snacks.picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<leader>sB",
		function()
			Snacks.picker.grep_buffers()
		end,
		desc = "Grep Open Buffers",
	},
	{
		"<leader>sg",
		function()
			Snacks.picker.grep()
		end,
		desc = "Grep",
	},
	{
		"<leader>sw",
		function()
			Snacks.picker.grep_word()
		end,
		desc = "Visual selection or word",
		mode = { "n", "x" },
	},
	-- search
	{
		'<leader>s"',
		function()
			Snacks.picker.registers()
		end,
		desc = "Registers",
	},
	{
		"<leader>s/",
		function()
			Snacks.picker.search_history()
		end,
		desc = "Search History",
	},
	{
		"<leader>sa",
		function()
			Snacks.picker.autocmds()
		end,
		desc = "Autocmds",
	},
	{
		"<leader>sb",
		function()
			Snacks.picker.lines()
		end,
		desc = "Buffer Lines",
	},
	{
		"<leader>sc",
		function()
			Snacks.picker.command_history()
		end,
		desc = "Command History",
	},
	{
		"<leader>sC",
		function()
			Snacks.picker.commands()
		end,
		desc = "Commands",
	},
	{
		"<leader>sd",
		function()
			Snacks.picker.diagnostics()
		end,
		desc = "Diagnostics",
	},
	{
		"<leader>sD",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
	{
		"<leader>sh",
		function()
			Snacks.picker.help()
		end,
		desc = "Help Pages",
	},
	{
		"<leader>sH",
		function()
			Snacks.picker.highlights()
		end,
		desc = "Highlights",
	},
	{
		"<leader>si",
		function()
			Snacks.picker.icons()
		end,
		desc = "Icons",
	},
	{
		"<leader>sj",
		function()
			Snacks.picker.jumps()
		end,
		desc = "Jumps",
	},
	{
		"<leader>sk",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "Keymaps",
	},
	{
		"<leader>sl",
		function()
			Snacks.picker.loclist()
		end,
		desc = "Location List",
	},
	{
		"<leader>sm",
		function()
			Snacks.picker.marks()
		end,
		desc = "Marks",
	},
	{
		"<leader>sM",
		function()
			Snacks.picker.man()
		end,
		desc = "Man Pages",
	},
	{
		"<leader>sp",
		function()
			Snacks.picker.lazy()
		end,
		desc = "Search for Plugin Spec",
	},
	{
		"<leader>sq",
		function()
			Snacks.picker.qflist()
		end,
		desc = "Quickfix List",
	},
	{
		"<leader>sR",
		function()
			Snacks.picker.resume()
		end,
		desc = "Resume",
	},
	{
		"<leader>su",
		function()
			Snacks.picker.undo()
		end,
		desc = "Undo History",
	},
	{
		"<leader>uC",
		function()
			Snacks.picker.colorschemes()
		end,
		desc = "Colorschemes",
	},
	-- LSP
	{
		"<leader>cd",
		function()
			Snacks.picker.lsp_definitions()
		end,
		desc = "Goto Definition",
	},
	{
		"<leader>cD",
		function()
			Snacks.picker.lsp_declarations()
		end,
		desc = "Goto Declaration",
	},
	{
		"<leader>cr",
		function()
			Snacks.picker.lsp_references()
		end,
		nowait = true,
		desc = "References",
	},
	{
		"<leader>cI",
		function()
			Snacks.picker.lsp_implementations()
		end,
		desc = "Goto Implementation",
	},
	{
		"<leadr>cy",
		function()
			Snacks.picker.lsp_type_definitions()
		end,
		desc = "Goto T[y]pe Definition",
	},
	{
		"<leader>cii",
		function()
			Snacks.picker.lsp_incoming_calls()
		end,
		desc = "C[a]lls Incoming",
	},
	{
		"<leadr>cio",
		function()
			Snacks.picker.lsp_outgoing_calls()
		end,
		desc = "C[a]lls Outgoing",
	},
	{
		"<leader>ss",
		function()
			Snacks.picker.lsp_symbols()
		end,
		desc = "LSP Symbols",
	},
	{
		"<leader>sS",
		function()
			Snacks.picker.lsp_workspace_symbols()
		end,
		desc = "LSP Workspace Symbols",
	},
	-- Other
	{
		"<leader>uz",
		function()
			Snacks.zen()
		end,
		desc = "Toggle Zen Mode",
	},
	{
		"<leader>uZ",
		function()
			Snacks.zen.zoom()
		end,
		desc = "Toggle Zoom",
	},
	{
		"<leader>.",
		function()
			Snacks.scratch()
		end,
		desc = "Toggle Scratch Buffer",
	},
	{
		"<leader>S",
		function()
			Snacks.scratch.select()
		end,
		desc = "Select Scratch Buffer",
	},
	{
		"<leader>n",
		function()
			Snacks.notifier.show_history()
		end,
		desc = "Notification History",
	},
	{
		"<leader>bd",
		function()
			Snacks.bufdelete()
		end,
		desc = "Delete Buffer",
	},
	{
		"<leader>fR",
		function()
			Snacks.rename.rename_file()
		end,
		desc = "Rename File",
	},
	{
		"<leader>gB",
		function()
			Snacks.gitbrowse()
		end,
		desc = "Git Browse",
		mode = { "n", "v" },
	},
	{
		"<leader>gg",
		function()
			Snacks.lazygit()
		end,
		desc = "Lazygit",
	},
	{
		"<leader>un",
		function()
			Snacks.notifier.hide()
		end,
		desc = "Dismiss All Notifications",
	},
	{
		"]]",
		function()
			Snacks.words.jump(vim.v.count1)
		end,
		desc = "Next Reference",
		mode = { "n", "t" },
	},
	{
		"[[",
		function()
			Snacks.words.jump(-vim.v.count1)
		end,
		desc = "Prev Reference",
		mode = { "n", "t" },
	},
	{
		"<leader>N",
		desc = "Neovim News",
		function()
			Snacks.win({
				file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
				width = 0.6,
				height = 0.6,
				wo = {
					spell = false,
					wrap = false,
					signcolumn = "yes",
					statuscolumn = " ",
					conceallevel = 3,
				},
			})
		end,
	},
}

vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- Setup some globals for debugging (lazy-loaded)
		_G.dd = function(...)
			Snacks.debug.inspect(...)
		end
		_G.bt = function()
			Snacks.debug.backtrace()
		end

		-- Override print to use snacks for `:=` command
		if vim.fn.has("nvim-0.11") == 1 then
			vim._print = function(_, ...)
				dd(...)
			end
		else
			vim.print = _G.dd
		end
		-- Create some toggle mappings
		Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
		Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
		Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
		Snacks.toggle.diagnostics():map("<leader>ud")
		Snacks.toggle.line_number():map("<leader>ul")
		Snacks.toggle
			.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
			:map("<leader>uc")
		Snacks.toggle.treesitter():map("<leader>uT")
		Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
		Snacks.toggle.inlay_hints():map("<leader>uh")
		Snacks.toggle.indent():map("<leader>ug")
		Snacks.toggle.dim():map("<leader>uD")
	end,
})

require("snacks").setup({
	bigfile = { enabled = true },
	lazygit = { enabled = true },
	dashboard = cc_dashboard_config,
	explorer = { enabled = true },
	input = { enabled = false },
	notifier = { enabled = false },
	image = { enabled = true },
	picker = cc_picker_config,
	animate = cc_animate_config,
})

vim.keymap.set("n", "<leader><space>", function()
  require("snacks").picker.files()
end, { desc = "Find Files" })

vim.keymap.set("n", "<leader>/", function()
  require("snacks").picker.grep()
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>,", function()
  require("snacks").picker.buffers()
end, { desc = "Buffers" })


vim.keymap.set("n", "<leader>fa", function()
  require("snacks").picker()
end, { desc = "Snacks Pickeres" })

vim.keymap.set("n", "<leader>e", function()
  require("snacks").picker.explorer()
end, { desc = "File Explorer" })
