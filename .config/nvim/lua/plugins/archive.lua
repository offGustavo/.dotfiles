return {
  "Old-est/archive.nvim",
  config = function()
    require("archive").setup()
    vim.keymap.set("n", "<A-t>", function()
      require("archive.task").create_task()
    end, { desc = "Create Task from Cursor" })
    vim.keymap.set("n", "<leader>pt", function()
      return Snacks.picker.pick("task")
    end, { desc = "Find Tasks" })
  end,
}
