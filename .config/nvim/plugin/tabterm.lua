vim.opt.rtp:append("/home/gustavo/Projects/TabTerm.nvim/")

-- TabTerm Config
vim.g.tabterm_config = {
  -- Winbar Config
  separator_right = " ",
  separator_left = " ",
  separator_first = " ",
  center = true,
  default_highlight = "%#Tabline#",
  tab_highlight = "%#TablineSel#",
  -- Window Config
  vertical_size = 20,
  float = false,
}

vim.keymap.set({ "n", "x", "i", "t" }, "<M-n>", function()
  require("TabTerm"):new()
end, { desc = "New Terminal" })

vim.keymap.set({ "n", "x", "i", "t" }, "<M-x>", function()
  require("TabTerm"):close()
end, { desc = "Close Terminal" })

vim.keymap.set({ "n", "x", "i", "t" }, "<M-/>", function()
  require("TabTerm"):toggle()
end, { desc = "Toggle Terminal" })

for i = 1, 9 do
  vim.keymap.set({ "n", "x", "i", "t" },
    "<M-" .. i .. ">",
    function()
      require("TabTerm"):go(i)
    end,
    { desc = "Go to Terminal [" .. i .. "]" })
end
