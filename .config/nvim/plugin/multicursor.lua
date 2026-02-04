-- vim.cmd([[
-- let g:mc = "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>"
--
-- nnoremap cn *``cgn
-- nnoremap cN *``cgN
--
-- vnoremap <expr> cn g:mc . "``cgn"
-- vnoremap <expr> cN g:mc . "``cgN"
--
-- function! SetupCR()
--   nnoremap <Enter> :nnoremap <lt>Enter> n@z<CR>q:<C-u>let @z=strpart(@z,0,strlen(@z)-1)<CR>n@z
-- endfunction
--
-- nnoremap cq :call SetupCR()<CR>*``qz
-- nnoremap cQ :call SetupCR()<CR>#``qz
--
-- vnoremap <expr> cq ":\<C-u>call SetupCR()\<CR>" . "gv" . g:mc . "``qz"
-- vnoremap <expr> cQ ":\<C-u>call SetupCR()\<CR>" . "gv" . substitute(g:mc, '/', '?', 'g') . "``qz"
-- ]])

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function ()

    require("multiple-cursors").setup {
      pre_hook = function()
        vim.g.minipairs_disable = true
        vim.b.completion = false
        -- Set MultipleCursorsCursor to be slightly darker than Cursor
        local cursor = vim.api.nvim_get_hl(0, { name = "Cursor" })
        cursor.bg = cursor.bg - 3355443 -- -#333333
        vim.api.nvim_set_hl(0, "MultipleCursorsCursor", cursor)

        -- Set MultipleCursorsVisual to be slightly darker than Visual
        local visual = vim.api.nvim_get_hl(0, { name = "Visual" })
        visual.bg = visual.bg - 1118481 -- -#111111
        vim.api.nvim_set_hl(0, "MultipleCursorsVisual", visual)
      end,
      post_hook = function()
        vim.g.minipairs_disable = false
        vim.b.completion = true
      end,
    } -- This causes the plugin setup function to be called

    vim.keymap.set({"x", "n" }, "<C-m>", "<Cmd>MultipleCursorsLock<CR>", { desc = "Lock virtual cursors", })
    vim.keymap.set({"x", "n" }, "<C-S-k>", "<Cmd>MultipleCursorsAddUp<CR>", { desc = "Add cursor and move up", })
    vim.keymap.set({"x", "n" }, "<C-S-j>", "<Cmd>MultipleCursorsAddDown<CR>", { desc = "Add cursor and move down", })
    vim.keymap.set({"x", "n" }, "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", { desc = "Add or remove cursor", })
    vim.keymap.set({"x", "n" }, "<C-;>", "<Cmd>MultipleCursorsAddVisualArea<CR>", { desc = "Add cursors to the lines of the visual area", })
    vim.keymap.set({"x", "n" }, "<C-;>", "<Cmd>MultipleCursorsAddMatchesV<CR>", { desc = "Add cursors to cword in previous area", })
    vim.keymap.set({"x", "n" }, "<C-S-d>", "<Cmd>MultipleCursorsAddMatches<CR>", { desc = "Add cursors to cword" })
    vim.keymap.set({"x", "n" }, "<C-.>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", { desc = "Add cursor and jump to next cword", })
    vim.keymap.set({"x", "n" }, "<C-n>", "<Cmd>MultipleCursorsJumpNextMatch<CR>", { desc = "Jump to previous cword" })
    vim.keymap.set({"x", "n" }, "<C-,>", "<Cmd>MultipleCursorsAddJumpPrevMatch<CR>", { desc = "Add cursor and jump to next cword", })
    vim.keymap.set({"x", "n" }, "<C-p>", "<Cmd>MultipleCursorsJumpPrevMatch<CR>", { desc = "Jump to previous cword" })
  end
})



