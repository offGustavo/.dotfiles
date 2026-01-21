if true then return {} end
return {
  -- { "tpope/vim-fugitive" },
  {
    "NeogitOrg/neogit",
    enabled = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
    },
    keys = {
      { "<A-g>", "<Cmd>Neogit kind=replace cwd=%:h<Cr>", silent = true, desc = "Neogit" },
    },
  },
}
