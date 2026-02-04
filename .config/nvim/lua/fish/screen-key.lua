-- Add this to your init.lua 
local key_buffer = ""
local last_clear = vim.loop.now()

-- Function to display pressed keys in statusline
function Screen_key()
	-- Clear buffer if more than 2 seconds have passed since last key
	if vim.loop.now() - last_clear > 2000 then
		key_buffer = ""
	end

	-- Limit display length and format
	if #key_buffer > 5 then
		return "[" .. key_buffer:sub(-5) .. "]"
	elseif #key_buffer > 0 then
		return "[" .. key_buffer .. "]"
	end

	return ""
end

-- Capture key presses
vim.on_key(function(key)
	last_clear = vim.loop.now()

	-- Skip certain keys for cleaner display
	if key == "<" then
		return
	end -- Ignore modifier start

	-- Convert common keys to readable format
	local display_key = key:gsub("<CR>", "⏎")
		:gsub("<Tab>", "⇥")
		:gsub("<Esc>", "⎋")
		:gsub("<Space>", "␣")
		:gsub("<Up>", "↑")
		:gsub("<Down>", "↓")
		:gsub("<Left>", "←")
		:gsub("<Right>", "→")
		:gsub("<BS>", "⌫")
		:gsub("<Del>", "⌦")
		:gsub("<C%-", "C-") -- Simplify Ctrl combos

	-- Add to buffer
	key_buffer = key_buffer .. display_key

	-- Clear after certain sequences
	if display_key == "⏎" or display_key == "⎋" then
		vim.defer_fn(function()
			key_buffer = ""
		end, 500)
	end
end)

local function setStatus()
	local old = vim.o.statusline

	-- If no existing statusline, create one with the key display
	if not old or old == "" then
		vim.o.statusline = "%<%f %h%m%r " .. "%=" .. "  %{%v:lua.Screen_key()%} %-14.(%l,%c%V%) %P"
		return
	end

	-- Check if statusline contains "%=" (separator between left and right sections)
	if string.find(old, "%%=") then
		-- Split at the first occurrence of %=
		local left_part, right_part = string.match(old, "^(.-)%%=(.*)$")

		if left_part and right_part then
			-- Insert Screen_key() at the beginning of the right part
			local new_statusline = left_part .. "%=" .. " %{%v:lua.Screen_key()%}" .. "%=" .. right_part
			vim.o.statusline = new_statusline
		else
			-- If split didn't work as expected, append to end
			vim.o.statusline = old .. " %{%v:lua.Screen_key()%}"
		end
	else
		-- If no %= found, add it with the key display
		vim.o.statusline = old .. "%=" .. " %{%v:lua.Screen_key()%}"
	end
end

-- Set the statusline
setStatus()

