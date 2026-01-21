return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = { }, -- This causes the plugin setup function to be called
    lazy = true,
    keys = {
      { "<C-m>", "<Cmd>MultipleCursorsLock<CR>", mode = { "n", "x" }, desc = "Lock virtual cursors" },
      { "<C-S-k>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move up" },
      { "<C-S-j>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i", "x" }, desc = "Add cursor and move down" },
      { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" }, desc = "Add or remove cursor" },
      {
        "<C-;>",
        "<Cmd>MultipleCursorsAddVisualArea<CR>",
        mode = { "x" },
        desc = "Add cursors to the lines of the visual area",
      },
      {"<C-;>", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = {"n"}, desc = "Add cursors to cword in previous area"},
      { "<C-S-d>", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" }, desc = "Add cursors to cword" },
      {
        "<C-.>",
        "<Cmd>MultipleCursorsAddJumpNextMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      { "<C-n>", "<Cmd>MultipleCursorsJumpNextMatch<CR>", mode = { "n", "x" }, desc = "Jump to previous cword" },
      {
        "<C-,>",
        "<Cmd>MultipleCursorsAddJumpPrevMatch<CR>",
        mode = { "n", "x" },
        desc = "Add cursor and jump to next cword",
      },
      { "<C-p>", "<Cmd>MultipleCursorsJumpPrevMatch<CR>", mode = { "n", "x" }, desc = "Jump to previous cword" },
    },
}
