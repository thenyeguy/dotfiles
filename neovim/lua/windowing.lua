-- Fix an issue where neovim doesn't properly handle resizes during startup.
vim.api.nvim_create_autocmd({"VimEnter"}, {
  callback = function()
    local pid, WINCH = vim.fn.getpid(), vim.loop.constants.SIGWINCH
    vim.defer_fn(function() vim.loop.kill(pid, WINCH) end, 20)
  end
})

-- Automatically resize splits
vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd ="
})
