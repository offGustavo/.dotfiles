vim.keymap.set("n", "<localleader>r", "<Cmd>!python %<Cr>", { silent = true, desc = "Execute File with Python", buffer = true })
vim.keymap.set("n", "<localleader>R", "<Cmd>horizontal term python %<Cr>", { silent = true, desc = "Execute File with Python", buffer = true })
