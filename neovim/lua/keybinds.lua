-- Configure leader
vim.g.mapleader = " "

-- Configure command mode
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<return>", ":")

-- Configure split movement
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")

-- Swap hjkl and g+hjkl
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gk", "k")

-- Don't deselect after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Clipboard copy/paste
vim.keymap.set("", "<leader>y", '"+y')
vim.keymap.set("", "<leader>Y", '"+y$')
vim.keymap.set("v", "<leader>p", '"+p')
vim.keymap.set("n", "<leader>p", "<Cmd>put +<CR>", { silent = true })
vim.keymap.set("n", "<leader>P", "<Cmd>put! +<CR>", { silent = true })

-- Undo/redo
vim.keymap.set("n", "U", "<C-r>")

-- Toggle search highlight
vim.keymap.set("n", "<leader>n", "<Cmd>let v:hlsearch = ! v:hlsearch<CR>")

-- Split/save/quit management
vim.keymap.set("n", "<leader>s", "<Cmd>split<CR>")
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>")
vim.keymap.set("n", "<leader>q", "<Cmd>q<CR>")
