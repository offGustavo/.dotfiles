-- Ref: [Build your own Vim statusline | George Ornbo](https://shapeshed.com/vim-statuslines/)

-- TODO: Improve the highligth, made custom highlighs
local function RC_statusline_mode()
  return "%#TabLineSel#" .. "   " .. "%* "

  -- return "%#TabLineSel# " .. vim.fn.mode() .. " %* "
end

local function RC_statusline_file()
  -- Get just the filename and its parent directory
  local filepath = vim.fn.expand("%:p")
  local parent = vim.fn.fnamemodify(filepath, ":h:t")
  local filename = vim.fn.fnamemodify(filepath, ":t")
  if filename == "" then
    return "[NA] "
  end
  if vim.bo.readonly then
    return parent .. "/" .. filename .. "%#WarningMsg#" .. " [RO] " .. "%* "
  end
  if vim.bo.modified then
    return parent .. "/" .. "%#WarningMsg#" .. filename .. "%* "
  end
  return parent .. "/" .. filename .. " "
end

local function RC_statusline_location()
  return "%l:%L %p%% "
end

local function RC_statusline_cmd()
  return "%S %a"
end

local function RC_statusline_lsp()
  if vim.fn.has("nvim-0.12") == 1 then
    return vim.diagnostic.status()
  else
    return ""
  end
end

-- local function RC_statusline_search_count()
--   local count = vim.fn.searchcount()
--   vim.print(count)
--   return ( "[" .. count.current .. "/" .. count.total .. "] " .. " ")
-- end

function RC_statusline_macro()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "@" .. recording_register .. " "
  end
end

local function RC_statusline_git_branch()
  -- Ref: Mini.nvim git statusline sction
  local summary = vim.b.minigit_summary_string or vim.b.gitsigns_head
  if summary == nil then
    return ""
  end
  return summary .. " "
end

-- local function RC_statusline_gitdiff()
--   -- Ref: Mini.nvim git statusline sction
--   local summary = vim.b.minidiff_summary_string or vim.b.gitsigns_status
--   if summary == nil then
--     return ""
--   end
--   return summary .. " "
-- end

local function RC_statusline_file_encode()
  return "%{&fileencoding?&fileencoding:&encoding} "
end

-- TODO: Make this uppercase
local function RC_statusline_file_format()
  return "[%{&fileformat}] "
end

local function RC_statusline_end()
  return "%#TabLineSel#" .. " ▊" .. "%* "
end

function RC_statusline()
  return RC_statusline_mode()
    .. RC_statusline_file()
    .. RC_statusline_location()
    -- .. RC_statusline_cmd()
    .. RC_statusline_lsp()
    .. " "
    .. "%="
    -- .. RC_statusline_search_count()
    .. RC_statusline_macro()
    .. RC_statusline_git_branch()
    .. RC_statusline_file_encode()
    .. RC_statusline_file_format()
    .. RC_statusline_end()
end

-- vim.o.statusline =
--   "%<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%{% luaeval('(package.loaded[''vim.diagnostic''] and #vim.diagnostic.count() ~= 0 and vim.diagnostic.status() .. '' '') or '''' ') %}%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"

vim.o.statusline = "%{%v:lua.RC_statusline()%}"
