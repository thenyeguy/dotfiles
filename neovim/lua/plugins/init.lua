return {
    -- Textobjects
    { "kana/vim-textobj-user", priority=100 },
    { "glts/vim-textobj-comment" },
    { "Julian/vim-textobj-variable-segment" },

    { "rhysd/conflict-marker.vim" },

    {
        "nvim-tree/nvim-web-devicons",
        opts = {
            color_icons = false
        },
    },
    {
        "levouh/tint.nvim",
        opts = {
            tint = -40,
            highlight_ignore_patterns = {
                -- These colors are too dark to tint properly.
                "EndOfBuffer", "LineNr", "MiniIndentscopeSymbol", "WinSeparator"
            },
        },
    },
    {
        "aserowy/tmux.nvim",
        opts = {
            -- Only use copy_sync for the clipboard registers
            copy_sync = {
                enable = true,
                sync_clipboard = true,
                sync_registers = false,
            },
            navigation = { enable_default_keybindings = true },
        }
    },
}
