local M = {}

local config = vim.tbl_extend("force", {
  file_explorer = "yazi",
  git_ui = "lazygit",
}, vim.g.forge_extern_config or {})

local setENV = function (cmd, cwd)
  -- Set EDITOR for terminal buffers
  vim.api.nvim_create_autocmd("TermOpen", {
    callback = function()
      if vim.fn.exists("$NVIM") > 0 then
        vim.env.EDITOR = "nvim --server $NVIM --remote"
        vim.env.VISUAL = "nvim --server $NVIM --remote"
      end
    end,
  })
  vim.cmd.terminal(cmd)
  vim.cmd.start()
end

M.openFileExplorer = function (on_file)
  if on_file then
    setENV(config.file_explorer, true)
  end
    setENV(config.file_explorer, true)
end

M.openGitUi = function ()
  setENV(config.git_ui)
end

return M
