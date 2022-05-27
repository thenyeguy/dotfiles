-- Automatically resize splits
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd ="
})
