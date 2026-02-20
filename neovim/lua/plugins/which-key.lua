return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "modern",
        icons = {
            group = "",
            mappings = false,
        },
        spec = {
            { "<leader>p", desc = "Picker" },
            { "<leader>y", desc = "Yank" },
            { "gs", desc = "Surround" },
        },
    },
}
