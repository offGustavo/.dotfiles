vim.keymap.set('n', '<leader>qo', vim.cmd.copen, { desc = 'QuickFix Open', silent = true })
vim.keymap.set('n', '<leader>qc', vim.cmd.cclose, { desc = 'QuickFix Close', silent = true })

vim.keymap.set('n', '<leader>qq', vim.cmd.quit, { desc = 'Quit', silent = true })
vim.keymap.set('n', '<leader>qQ', ':qa!<Cr>', { desc = 'Force Quit All', silent = true })
vim.keymap.set('n', '<leader>qr', vim.cmd.restart, { desc = 'Restart', silent = true })

vim.keymap.set('n', '<leader>fc', ':e $MYVIMRC<Cr>', { silent = true })

vim.keymap.set('n', '<leader>bb', ':b #<Cr>', { desc = "Alternative Buffer"})
vim.keymap.set('n', '<M-a>', ':b #<Cr>', { desc = "Alternative Buffer"})
vim.keymap.set('n', '<leader>bd', ':bd<Cr>', { desc = "Delete Buffer"})
vim.keymap.set('n', '<leader>bD', ':bufdo bd<Cr>', { desc = "Delete All Buffers"})

vim.keymap.set(
  "n",
  "<leader>s/",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitute Current Word Globally" }
)
vim.keymap.set(
  "n",
  "<leader>s.",
  [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitute Current Word" }
)
vim.keymap.set("x", "S", ":s/", { desc = "Substitute in line" })

vim.keymap.set('n', '<leader>lu', function()
  vim.pack.update {}
end)
vim.keymap.set('n', '<leader>lx', function()
  vim.pack.del {}
end)
vim.keymap.set('n', '<leader>le', function()
  vim.cmd("e ~/.local/share/lvim/site/pack/core/opt/")
end)

-- {{{ Tabs
vim.keymap.set("n", "<leader><tab>o", "<Cmd>tabonly<CR>")
vim.keymap.set("n", "<leader><tab><tab>", "<Cmd>tabnew<CR>")
vim.keymap.set("n", "[<tab>", "<Cmd>tabprev<CR>")
vim.keymap.set("n", "[<tab>", "<Cmd>tabnext<CR>")
vim.keymap.set("n", "<leader><tab>c", "<Cmd>tabclose<CR>")
---}}}

-- [How to Use vim.pack - NeoVim's built-in Plugin Manager in Neovim 0.12+ - YouTube](https://www.youtube.com/watch?v=UE6XQTAxwE0)
vim.keymap.set('n', '<localleader>l', ':.lua<Cr>', { silent = true, desc = 'Execute Line in Lua' })
vim.keymap.set('v', '<localleader>l', ":'<,'>lua<Cr>", { silent = true, desc = 'Execute Selection in Lua' })

-- Poor man harpoon
vim.keymap.set('n', '<leader>ha', function()
  vim.cmd 'argadd %'
  vim.cmd 'argdedup'
end)

vim.keymap.set('n', '<leader>hd', function()
  vim.cmd 'argd %'
end)

-- assign arg to each number
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<CMD>argu ' .. i .. '<CR>', { silent = true, desc = 'Go to arg ' .. i })
  vim.keymap.set('n', '<leader>h' .. i, '<CMD>' .. i - 1 .. 'arga<CR>',
    { silent = true, desc = 'Add current to arg ' .. i })
  vim.keymap.set('n', '<leader>d' .. i, '<CMD>' .. i .. 'argd<CR>', { silent = true, desc = 'Delete current arg' })
end

-- to qf
vim.keymap.set('n', '<leader>he', function()
  local list = vim.fn.argv()
  if #list > 0 then
    local qf_items = {}
    for _, filename in ipairs(list) do
      table.insert(qf_items, {
        filename = filename,
        lnum = 1,
        text = filename,
      })
    end
    vim.fn.setqflist(qf_items, 'r')
    vim.cmd.copen()
  end
end, { silent = true, desc = 'Show args in qf' })

-- Convert quickfix list to argument list
vim.keymap.set('n', '<leader>hq', function()
  local qf_list = vim.fn.getqflist()
  if #qf_list == 0 then
    vim.notify("Quickfix list is empty", vim.log.levels.WARN)
    return
  end
  -- Clear current argument list
  vim.cmd '%argdelete'
  -- Add each quickfix item to argument list
  for _, item in ipairs(qf_list) do
    if item.filename and item.filename ~= '' then
      -- Use absolute path to avoid issues
      local filename = vim.fn.fnamemodify(item.filename, ':p')
      vim.cmd('argadd ' .. vim.fn.fnameescape(filename))
    elseif item.bufnr and vim.fn.bufexists(item.bufnr) > 0 then
      -- If we have a buffer number but no filename, use buffer name
      local bufname = vim.fn.bufname(item.bufnr)
      if bufname and bufname ~= '' then
        local filename = vim.fn.fnamemodify(bufname, ':p')
        vim.cmd('argadd ' .. vim.fn.fnameescape(filename))
      end
    end
  end
  -- Remove duplicates
  vim.cmd 'argdedup'
  vim.notify(string.format("Added %d files from quickfix to argument list", #qf_list))
end, { silent = true, desc = 'Quickfix to args' })

--- {{{ Windows
vim.keymap.set({'n', 'i', 't'}, '<M-j>', function ()
  vim.cmd.wincmd("w")
end)
vim.keymap.set({'n', 'i', 't'}, '<M-k>', function ()
  vim.cmd.wincmd("W")
end)
  --- }}}

--{{{ -- Terminal

vim.keymap.set('n', '<leader>tn', ':term ')
vim.keymap.set('n', '<leader>tn', ':term ')
vim.keymap.set('n', '<leader>tn', ':term ')
vim.keymap.set('n', '<leader>cc', ':hor term ')
vim.keymap.set('n', '<A-c>', ':hor term rg')


vim.keymap.set('n', '<leader>cc', ':hor term ')
vim.keymap.set('n', '<A-c>', ':hor term ')

vim.keymap.set('n', '<leader>cc', ':hor term ')
vim.keymap.set('n', '<A-c>', ':hor term ')

vim.keymap.set('t', '<S-Esc>', '<C-\\><C-n>', { silent = true, desc = 'Go To Normal Mode in Terminal' })

vim.keymap.set('n', '<leader>tn', ':term ')
vim.keymap.set('n', '<leader>cc', ':hor term ')
vim.keymap.set('n', '<A-c>', ':hor term ')

-- vim.o.timeout = false
-- local tmux_prefix = "<A-p>"
-- local map = vim.keymap.set
-- local modes = { "n", "x", "i", "t" }
-- local term_insert_mode = "<Cmd>term<Cr><Cmd>start<Cr>"
-- local insert_mode = "<Cmd>start<Cr>"
-- local exit_term_mode = "<C-\\><C-n>" 
--
-- map(modes, tmux_prefix .. "%", "<Cmd>split<Cr>" .. term_insert_mode, { desc = "Tmux Split" })
-- map(modes, "<A-s>", "<Cmd>split<Cr>" .. term_insert_mode, { desc = "Tmux Vertical Split" })
-- map(modes, tmux_prefix .. "\"", "<Cmd>vsplit<Cr>" .. term_insert_mode, { desc = "Tmux Vertical Split" })
-- map(modes, "<A-v>", "<Cmd>vsplit<Cr>" .. term_insert_mode, { desc = "Tmux Vertical Split" })
-- map(modes, tmux_prefix .. "c", "<Cmd>tabnew<Cr>" .. term_insert_mode, { desc = "Tmux New Tab" })
-- map(modes, "<A-n>", "<Cmd>tabnew<Cr>" .. term_insert_mode, { desc = "Tmux New Tab" })
-- map(modes, tmux_prefix .. "x", "<Cmd>close!<Cr>", { desc = "Tmux Close" })
-- map(modes, "<A-x>", "<Cmd>close!<Cr>", { desc = "Tmux Close" })
-- map(modes, tmux_prefix .. "w", ":b term:h", { desc = "Tmux Switch Terminals" })
-- map(modes, tmux_prefix .. "[", exit_term_mode, { desc = "Tmux Copy Mode" })
--
-- map(modes, tmux_prefix .. "h", exit_term_mode .. "<C-w>h" .. insert_mode, { desc = "Tmux Copy Mode" })
-- map(modes, tmux_prefix .. "j", exit_term_mode .. "<C-w>j" .. insert_mode, { desc = "Tmux Copy Mode" })
-- map(modes, tmux_prefix .. "k", exit_term_mode .. "<C-w>k" .. insert_mode, { desc = "Tmux Copy Mode" })
-- map(modes, tmux_prefix .. "l", exit_term_mode .. "<C-w>l" .. insert_mode, { desc = "Tmux Copy Mode" })
-- map(modes, "<A-h>", exit_term_mode .. "<C-w>h" .. insert_mode, { desc = "Tmux Copy Mode" })
-- map(modes, "<A-j>", exit_term_mode .. "<C-w>j" .. insert_mode, { desc = "Tmux Copy Mode" })
-- map(modes, "<A-k>", exit_term_mode .. "<C-w>k" .. insert_mode, { desc = "Tmux Copy Mode" })
-- map(modes, "<A-l>", exit_term_mode .. "<C-w>l" .. insert_mode, { desc = "Tmux Copy Mode" })
--
-- for i = 1, 9, 1 do
--     map({ "n", "x", "i"} , tmux_prefix .. i, "<Cmd>norm " .. i .. "gt<Cr>", { desc = "Tmux to tab " .. i })
--     map("t", tmux_prefix .. i, "<C-\\><C-o>:norm " .. i .. "gt<Cr>", { desc = "Tmux to tab " .. i })
-- end

--}}}
