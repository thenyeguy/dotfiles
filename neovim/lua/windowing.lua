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

-- Intelligently calculate split direction
vim.keymap.set("", "<leader>s", function()
    if vim.api.nvim_win_get_width(0) > 150 then
        vim.cmd([[vsplit]])
    else
        vim.cmd([[split]])
    end
end)
