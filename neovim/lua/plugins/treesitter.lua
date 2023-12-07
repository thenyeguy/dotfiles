return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "RRethy/nvim-treesitter-endwise" },
    config = function()
        require("nvim-treesitter.configs").setup({
            endwise = { enable = true },
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-n>",
                    node_incremental = "<C-n>",
                    node_decremental = "<C-S-n>",
                    scope_incremental = "<C-A-n>",
                },
            },
            auto_install = true,
        })
    end,
}
