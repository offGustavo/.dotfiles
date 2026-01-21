vim.filetype.add({
  extension = {
    kbd = "kbd", -- maps *.kbd → filetype=kbd
  },
})

-- bootstrap lazy.nvim, LazyVim and your plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    --
    lazy = true,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = false, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
  },
})

-- Custom Things
-- require("fish.multi_marks")
require("fish.commads")

-- External Programs
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function(ev)
    require("fish.neovide")
  end,
})
-- require("fish.vscode")

if vim.uv.os_uname().sysname == "Windows_NT" then
else
  if os.getenv("DISPLAY") then
    -- Theme
    require("fish.theme")
    -- require("themes.compline").setup()
  else
    vim.cmd([[
      colorscheme default
      set notermguicolors
      ]])
  end
  require("fish.kitty")
  -- require("fish.wezterm")
  -- require("fish.tmux")
  -- require("fish.lazygit")
end

-- require("fzf-lua").setup({
--   "ivy",
--   --
--   -- Set fzf's terminal colorscheme (optional)
--   --
--   -- Set to `true` to automatically generate an fzf's colorscheme from
--   -- Neovim's current colorscheme:
--   -- fzf_colors       = true,
--   --
--   -- Building a custom colorscheme, has the below specifications:
--   -- If rhs is of type "string" rhs will be passed raw, e.g.:
--   --   `["fg"] = "underline"` will be translated to `--color fg:underline`
--   -- If rhs is of type "table", the following convention is used:
--   --   [1] "what" field to extract from the hlgroup, i.e "fg", "bg", etc.
--   --   [2] Neovim highlight group(s), can be either "string" or "table"
--   --       when type is "table" the first existing highlight group is used
--   --   [3+] any additional fields are passed raw to fzf's command line args
--   -- Example of a "fully loaded" color option:
--   --   `["fg"] = { "fg", { "NonExistentHl", "Comment" }, "underline", "bold" }`
--   -- Assuming `Comment.fg=#010101` the resulting fzf command line will be:
--   --   `--color fg:#010101:underline:bold`
--   -- NOTE: to pass raw arguments `fzf_opts["--color"]` or `fzf_args`
--   -- NOTE: below is an example, not the defaults:
--   fzf_colors = {
--     true, -- inherit fzf colors that aren't specified below from
--     -- the auto-generated theme similar to `fzf_colors=true`
--     ["fg"] = { "fg", "CursorLine" },
--     ["bg"] = { "bg", "Normal" },
--     ["hl"] = { "fg", "Comment" },
--     ["fg+"] = { "fg", "Normal"  },
--     ["bg+"] = { "bg", { "CursorLine", "Normal" } },
--     ["hl+"] = { "fg", "Statement" },
--     ["info"] = { "fg", "PreProc" },
--     ["prompt"] = { "fg", "Conditional" },
--     ["pointer"] = { "fg", "Exception" },
--     ["marker"] = { "fg", "Keyword" },
--     ["spinner"] = { "fg", "Label" },
--     ["header"] = { "fg", "Comment" },
--     ["gutter"] = "-1",
--   },
-- })

vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}
