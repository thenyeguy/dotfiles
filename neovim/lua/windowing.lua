-- Automatically resize splits
vim.api.nvim_create_autocmd("VimResized", { command = "wincmd =" })

-- Hide cursorline when windows lose focus
vim.api.nvim_create_autocmd("FocusLost", { command = "set nocursorline" })
vim.api.nvim_create_autocmd("FocusGained", { command = "set cursorline" })
vim.api.nvim_create_autocmd("WinLeave", { command = "setlocal nocursorline" })
vim.api.nvim_create_autocmd("WinEnter", { command = "setlocal cursorline" })

-- Intelligently calculate split direction
vim.keymap.set("", "<leader>s", function()
    if vim.api.nvim_win_get_width(0) > 150 then
        vim.cmd("vsplit")
    else
        vim.cmd("split")
    end
end)
