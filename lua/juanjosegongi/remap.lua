vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Oil, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>gtj", "<cmd> GoTagAdd json <CR>", { desc = "Add go json struct tags" })
vim.keymap.set("n", "<leader>gty", "<cmd> GoTagAdd yaml <CR>", { desc = "Add go yaml struct tags" })

