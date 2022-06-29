-- Configure leader
vim.g.mapleader = " "

-- Configure command mode
vim.keymap.set("", ";", ":")
vim.keymap.set("", "<return>", ":")
vim.keymap.set("", "<a-return>", "<return>")

-- Configure split movement
vim.keymap.set("", "<C-h>", "<C-w><C-h>")
vim.keymap.set("", "<C-j>", "<C-w><C-j>")
vim.keymap.set("", "<C-k>", "<C-w><C-k>")
vim.keymap.set("", "<C-l>", "<C-w><C-l>")

-- Kakoune-style navigation
vim.keymap.set("", "gh", "0")
vim.keymap.set("", "gj", "G")
vim.keymap.set("", "gk", "gg")
vim.keymap.set("", "gl", "$")
vim.keymap.set("", "gi", "^")
vim.keymap.set("", "m", "%")

-- Remap move by display line, since they're overwritten above.
vim.keymap.set("", "<a-j>", "gj")
vim.keymap.set("", "<a-k>", "gk")

-- Don't deselect after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Clipboard copy/paste
vim.keymap.set("", "<leader>y", '"+y', { remap = true })
vim.keymap.set("", "<leader>Y", '"+Y', { remap = true })
vim.keymap.set("n", "<leader>p", "<cmd>put +<cr>", { silent = true })
vim.keymap.set("n", "<leader>P", "<cmd>put! +<cr>", { silent = true })
vim.keymap.set("v", "<leader>p", '"+p')

-- Undo/redo
vim.keymap.set("n", "U", "<C-r>")

-- Spell-check
vim.keymap.set("n", "zs", "z=")

-- Toggle search highlight
vim.keymap.set("", "<leader>n", "<Cmd>let v:hlsearch = ! v:hlsearch<CR>")

-- Save/quit
vim.keymap.set("", "<leader>w", "<Cmd>w<CR>")
vim.keymap.set("", "<leader>q", "<Cmd>q<CR>")
