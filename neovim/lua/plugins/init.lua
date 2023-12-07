return {
    -- Textobjects
    { "kana/vim-textobj-user", priority=100 },
    { "kana/vim-textobj-entire" },
    { "glts/vim-textobj-comment" },
    { "Julian/vim-textobj-variable-segment" },

    { "rhysd/conflict-marker.vim" },

    {
        "levouh/tint.nvim",
        config = function()
            require("tint").setup({
                tint = -40,
                highlight_ignore_patterns = { "WinSeparator" },
            })
        end,
    },
    {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                -- Only use copy_sync for the clipboard registers
                copy_sync = {
                    enable = true,
                    sync_clipboard = true,
                    sync_registers = false,
                },
                navigation = { enable_default_keybindings = true },
            })
        end
    },
}
