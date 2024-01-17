return {
    {
        "tpope/vim-repeat",
        config = function()
            -- Prevent this plugin from overwriting <C-R>
            vim.keymap.set("n", "<nop>", "<Plug>(RepeatRedo)")
        end,
    },
    {
        "ggandor/leap.nvim",
        dependencies = { "tpope/vim-repeat" },
        config = function()
            require("leap").set_default_keymaps()

            -- Remap cross-window bindings to not conflict with surround.
            vim.keymap.del("", "gs")
            vim.keymap.set("n", "gz", "<Plug>(leap-cross-window)")
        end,
    },
    {
        "ggandor/flit.nvim",
        dependencies = { "ggandor/leap.nvim" },
        opts = {},
    },
}
