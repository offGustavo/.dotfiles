-- Função principal
local function align_regexp(opts)
  -- pede separador (regex)
  local sep = vim.fn.input("Separador (regex ou texto): ")
  if sep == "" then
    return
  end

  -- obtém range
  local start_line = opts.line1
  local end_line = opts.line2
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- divide linhas e calcula larguras
  local split_lines = {}
  local col_widths = {}

  for _, line in ipairs(lines) do
    -- usa regex se aplicável
    local parts = vim.split(line, sep, { plain = true, trimempty = false })
    table.insert(split_lines, parts)
    for i, part in ipairs(parts) do
      local len = vim.fn.strdisplaywidth(vim.trim(part))
      col_widths[i] = math.max(col_widths[i] or 0, len)
    end
  end

  -- monta linhas alinhadas
  local aligned = {}
  for _, parts in ipairs(split_lines) do
    local new_parts = {}
    for i, part in ipairs(parts) do
      local pad = col_widths[i] - vim.fn.strdisplaywidth(vim.trim(part))
      table.insert(new_parts, vim.trim(part) .. string.rep(" ", pad))
    end
    table.insert(aligned, table.concat(new_parts, " " .. sep .. " "))
  end

  -- substitui no buffer
  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, aligned)
end

-- cria comando
vim.api.nvim_create_user_command("AlignRegexp", align_regexp, { range = true })

if vim.fn.executable("zoxide") == 1 then
  local function zoxide_list()
    if vim.fn.executable("zoxide") ~= 1 then
      return {}
    end

    local handle = io.popen("zoxide query --list")
    if not handle then
      return {}
    end

    local results = {}
    for line in handle:lines() do
      if line ~= "" then
        table.insert(results, line)
      end
    end
    handle:close()

    return results
  end

  -- Better Cd with Zoxide
  vim.api.nvim_create_user_command("CD", function(opts)
    local target = opts.args
    if target == "" then
      vim.cmd("cd ~")
      return
    end
    local handle = io.popen("zoxide query " .. vim.fn.shellescape(target))
    if not handle then
      vim.notify("Failed to run zoxide", vim.log.levels.ERROR)
      return
    end
    local result = handle:read("*l")
    handle:close()
    if result and result ~= "" then
      vim.cmd("cd " .. vim.fn.fnameescape(result))
      print("Changed directory to: " .. result)
    else
      print("zoxide: no match for '" .. target .. "'")
    end
  end, {
    nargs = "?",
    complete = function(_, line)
      -- Extract the argument being typed
      local arg = line:match("^%S+%s+(.*)$") or ""
      local paths = zoxide_list()
      if arg == "" then
        return paths
      end
      -- Simple substring match (same behavior as zoxide itself)
      local matches = {}
      for _, path in ipairs(paths) do
        if path:find(arg, 1, true) then
          table.insert(matches, path)
        end
      end
      return matches
    end,
  })

  -- Better tcd
  vim.api.nvim_create_user_command("TCD", function(opts)
    local target = opts.args
    if target == "" then
      vim.cmd("tcd ~")
      return
    end
    local handle = io.popen("zoxide query " .. vim.fn.shellescape(target))
    if not handle then
      vim.notify("Failed to run zoxide", vim.log.levels.ERROR)
      return
    end
    local result = handle:read("*l")
    handle:close()
    if result and result ~= "" then
      vim.cmd("tcd " .. vim.fn.fnameescape(result))
      print("Changed directory to: " .. result)
    else
      print("zoxide: no match for '" .. target .. "'")
    end
  end, {
    nargs = "?",
    complete = function(_, line)
      -- Extract the argument being typed
      local arg = line:match("^%S+%s+(.*)$") or ""
      local paths = zoxide_list()
      if arg == "" then
        return paths
      end
      -- Simple substring match (same behavior as zoxide itself)
      local matches = {}
      for _, path in ipairs(paths) do
        if path:find(arg, 1, true) then
          table.insert(matches, path)
        end
      end
      return matches
    end,
  })
end
