-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.cmd([[
  let maplocalleader = "\<BS>"
]])

vim.g.snacks_animate = false

-- vim.o.scrolloff = 999
vim.o.scrolloff = 0

vim.o.wrap = false

vim.o.list = false

vim.o.swapfile = false

vim.o.spelllang = "pt_br,en_us,es"

vim.cmd([[
  " let g:netrw_banner = 0
  set path+=**
  set wildignore+=**/node_modules/**
]])

-- vim.g.lazyvim_picker = "snacks"
-- vim.g.lazyvim_picker = "telescope"
-- vim.g.lazyvim_picker = "fzf-lua"

-- Disable autoformat
vim.g.autoformat = false -- globally

-- local function Winbar()
--   local normal_color = "%#Normal#"
--   local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
--   local file_name = "%-.16t"
--   local buf_nr = "[%n]"
--   local modified = "%#MiniIconsRed% %-M"
--   local file_type = " %y"
--   local right_align = "%="
--   local line_no = "%10([%l/%L%)]"
--   local pct_thru_file = "%5p%%"
--   return string.format("%s%s%s", normal_color, file_name, modified)
-- end
-- vim.o.winbar = Winbar()

----------------------
-- NEOVIDE          --
----------------------

if vim.g.neovide then
  vim.g.neovide_padding_top = 8
  vim.g.neovide_padding_bottom = 8
  vim.g.neovide_padding_right = 8
  vim.g.neovide_padding_left = 8
end

if vim.uv.os_uname().sysname == "Windows_NT" then
  vim.o.shell = "pwsh.exe"
  vim.o.shellcmdflag =
    "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
end

-- vim.o.makeprg = "make"

-- if vim.fn.has("nvim-0.12") == 1 then
--   if not vim.g.vscode then
--     vim.o.cmdheight = 1
--     -- Experimental
--     require("vim._extui").enable({
--       enable = true, -- Whether to enable or disable the UI.
--       msg = { -- Options related to the message module.
--         ---@type 'cmd'|'msg' Where to place regular messages, either in the
--         ---cmdline or in a separate ephemeral message window.
--         target = "msg",
--         timeout = 2000, -- Time a message is visible in the message window.
--       },
--     })
--   end
-- end

-- Better Grep and Find with ripgrep
if vim.fn.executable("rg") then
  vim.o.grepprg = "rg --vimgrep --smart-case"
  function _G.RgFindFiles(cmdarg, _cmdcomplete)
    local fnames = vim.fn.systemlist('rg --files --color=never')
    if #cmdarg == 0 then
      return fnames
    else
      return vim.fn.matchfuzzy(fnames, cmdarg)
    end
  end
  vim.o.findfunc = "v:lua.RgFindFiles"
end


vim.o.timeout = false

-- vim.o.winborder = "rounded"

-- vim.o.acd = true
-- vim.cmd([[
-- let g:netrw_dirkeep = 0
-- let g:netrw_keepdir = 0
-- ]]

-- -- Diagnostics
-- vim.diagnostic.config {
--   -- Use the default configuration
--   virtual_lines = false,
--   virtual_text = true,
--   signs = {
--     text = {
--       [vim.diagnostic.severity.ERROR] = "E",
--       [vim.diagnostic.severity.WARN] = "W",
--       [vim.diagnostic.severity.INFO] = "I",
--       [vim.diagnostic.severity.HINT] = "H",
--     }
--   }
-- }

vim.o.laststatus = 3

vim.o.cursorline = false

vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrw = 1
