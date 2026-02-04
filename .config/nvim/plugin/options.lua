-- vim.g.netrw_banner = 0

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = true
vim.o.laststatus = 3
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.linebreak = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 50
vim.o.timeoutlen = 400
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.spell = false
vim.o.list = false
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.confirm = true
vim.o.wrap = false
vim.o.tabstop = 2 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 2 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 2 -- Number of spaces inserted when indenting
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.showmode = true
vim.o.showcmd = true
vim.o.showcmdloc = "statusline"
vim.o.foldmethod = "indent"
vim.o.foldlevel = 99
vim.o.swapfile = false
vim.o.path = vim.o.path .. "**"
vim.cmd([[
  set wildignore=*.o,*.obj,**/node_modules/**,/
]])
vim.o.termguicolors = true

-- [Neovim native, built-in, LSP autocomplete · Tomas Vik](https://blog.viktomas.com/graph/neovim-native-built-in-lsp-autocomplete/)
-- prevent the built-in vim.lsp.completion autotrigger from selecting the first item
-- vim.o.autocomplete = true
-- vim.opt.completeopt = { 'menuone', 'noselect', 'popup' }

-- vim.o.acd = true
-- vim.g.netrw_keepdir = 0
-- vim.cmd([[
-- autocmd BufEnter * lcd %:p:h
-- ]])

-- require("vim._extui").enable({
-- 	enable = true, -- Whether to enable or disable the UI.
-- 	msg = { -- Options related to the message module.
-- 		---@type 'cmd'|'msg' Where to place regular messages, either in the
-- 		---cmdline or in a separate ephemeral message window.
-- 		target = "cmd",
-- 		timeout = 2000, -- Time a message is visible in the message window.
-- 	},
-- })

-- Better Grep and Find with ripgrep
if vim.fn.executable("rg") then
	vim.o.grepprg = "rg"

	-- [Native Fuzzy Finder in Neovim With Lua and Cool Bindings :: Cherry's Blog](https://cherryramatis.xyz/posts/native-fuzzy-finder-in-neovim-with-lua-and-cool-bindings/)
	function _G.RgFindFiles(cmdarg, _cmdcomplete)
		local fnames = vim.fn.systemlist("rg --files --hidden --color=never ")
		if #cmdarg == 0 then
			return fnames
		else
			return vim.fn.matchfuzzy(fnames, cmdarg)
		end
	end

	vim.o.findfunc = "v:lua.RgFindFiles"
end

vim.filetype.add({
	extension = {
		kbd = "kbd", -- maps *.kbd → filetype=kbd
	},
})

-- vim.cmd([[autocmd BufRead,BufNewFile *.kbd,*.cl,*.lisp,*.asd set filetype=commonlisp]])
