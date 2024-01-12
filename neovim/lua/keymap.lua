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

-- Move to start of line on big jumps.
vim.keymap.set("", "gg", "gg^")
vim.keymap.set("", "G", "G^")

-- Kakoune-style navigation
vim.keymap.set("", "gh", "0")
vim.keymap.set("", "gj", "G^")
vim.keymap.set("", "gk", "gg^")
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
vim.keymap.set("", "gy", '"+y', { desc = "Copy to clipboard", remap = true })
vim.keymap.set("", "gY", '"+Y',
    { desc = "Copy to clipboard (to EOL)", remap = true })
vim.keymap.set("n", "gp", '"+p',
    { desc = "Paste from clipboard", silent = true })
vim.keymap.set("n", "gP", "<cmd>put! +<cr>",
    { desc = "Paste from clipboard (above)", silent = true })
vim.keymap.set("v", "gp", '"+P', { desc = "Paste from clipboard" })

-- Undo/redo
vim.keymap.set("n", "U", "<C-r>")

-- Spell-check
vim.keymap.set("n", "zs", "z=", { desc = "Spellcheck" })

-- Toggle search highlight
vim.keymap.set("", "<leader>n", "<Cmd>let v:hlsearch = ! v:hlsearch<CR>",
    { desc = "Toggle search highlight" })

-- Save/quit
vim.keymap.set("", "<leader>w", "<Cmd>w<CR>", { desc = "Write" })
vim.keymap.set("", "<leader>q", "<Cmd>q<CR>", { desc = "Quit window" })

vim.keymap.set("", "<leader>i", "<Cmd>Inspect<CR>")
