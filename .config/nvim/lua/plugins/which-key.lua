return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  lazy = true,
  -- enabled = false,
  opts = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "helix",
    delay = 1000,
    defaults = {},
    spec = {
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>c", group = "code" },
        { "<leader>a", icon = "󰃭", name = "Md Agenda" },
        { "<leader>cl", group = "lsp" },
        { "<leader>d", group = "debug" },
        { "<A-m>", group = "tabterm", icon = "" },
        { "<leader>dp", group = "profiler" },
        { "<leader>R", group = "kulala", icon = "󰏚" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>q", group = "quit/session/quickfix" },
        { "<leader>s", group = "search" },
        { "<leader>r", group = "search/replace" },
        --TODO: terminar isso
        { "<leader>l", group = "lazy/location list" },
        { "<leader>h", group = "harpoon", icon = "⇁" },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        -- { "<leader>p", group = "Snacks Pickers", icon = { icon = "💤", color = "green" } },
        { "<leader>K", name = "Man Pages", icon = { icon = " " } },
        -- { "<leader><Cr>", icon = { icon = "󰮯" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "z", group = "fold" },
        { "<leader>t", group = "terminal/tabs" },
        { "<leader>i", group = "insert", icon = ""},
        { "<leader>o", group = "options/custom", icon = "" },
        { "<leader>oa", group = "agenda", icon = "" },
        { "<leader>oo", group = "obsidian", icon = "" },
        { "<leader>om", group = "markdown", icon = "" },
        { "<leader>oc", group = "colorizer", icon = "󰌁" },
        { "g<C-a>", desc = "Increase numbres in order" },
        { "<leader>z", icon = { icon = "", color = "purple" } },
        { "<leader>Z", icon = { icon = "", color = "purple" } },
        { "<leader>cj", group = "Java" },
        { "<leader>`", hidden = true },
        -- { "<leader><space>", hidden = true }, -- hide this keymap
        { "<leader>-", hidden = true },
        { "<leader>|", hidden = true },
        {
          "<leader>b",
          group = "buffer",
          expand = function()
            return require("which-key.extras").expand.buf()
          end,
        },
        -- {
        --   "<leader>w",
        --   group = "windows",
        --   proxy = "<c-w>",
        --   expand = function()
        --     return require("which-key.extras").expand.win()
        --   end,
        -- },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
