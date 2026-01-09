return {
  -- { "tpope/vim-fugitive" },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    keys = {
      { "<leader>gg", "<Cmd>Neogit kind=replace cwd=%:h<Cr>", silent = true, desc = "Neogit" },
    },
  },
}
