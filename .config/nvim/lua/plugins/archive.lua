return {
  -- "Old-est/archive.nvim",
  dir = "~/Projects/archive.nvim/",
  lazy = true,
  config = function()
    require("archive").setup({
      storage = "tasks",

      task = {
        icon = "T ",
        colors = {
          status = { fg = "#ffd700", bg = "none", bold = true },
          task = { fg = "#52796f", bg = "none", bold = true },
          desc = { fg = "#ffd700", bg = "none", bold = true },
        },

        -- tags = {
        --   type = { name = "TYPE", default_value = M.get_type },
        --   status = { name = "STATUS", values = { "OPEN", "DONE", "INPROGRESS", "PAUSED" }, default_value = "OPEN" },
        --   priority = { name = "PRIORITY", default_value = M.get_priority },
        --   creation_date = { name = "OPEN DATE (UTC)", default_value = M.get_creation_time },
        --   close_date = { name = "CLOSE DATE (UTC)" },
        -- },

        tags_order = { "type", "status", "priority", "creation_date", "close_date" },

        source = {
          TODO = { priority = 30 },
          BUG = { priority = 50 },
          FIX = { priority = 40 },
        },
      },

      search = {
        command = "rg",
        args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
        root_markers = { ".git", "stylua.toml" },
      },
    })
    vim.keymap.set("n", "<A-t>", function()
      require("archive.task").create_task()
    end, { desc = "Create Task from Cursor" })
    vim.keymap.set("n", "<leader>pt", function()
      return Snacks.picker.pick("task")
    end, { desc = "Find Tasks" })
  end,
}
