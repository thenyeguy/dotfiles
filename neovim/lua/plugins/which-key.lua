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
            { "<leader>p", desc = "Mini.Pick" },
            { "<leader>y", desc = "Yank" },
            { "gs", desc = "Surround" },
        },
    },
}
