return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        -- Set how quickly which-key UI appears.
        vim.o.timeout = true
        vim.o.timeoutlen = 250
    end,
    config = function()
        local wk = require("which-key")
        wk.setup({
            plugins = {
                -- Don't show for operator movements. Primarily because visual
                -- mode is considered an operator.
                presets = { operators = false },
            },
        })
        wk.register({
            ["<leader>p"] = "+Pick",
            ["<leader>l"] = "+LSP",
            ["gs"] = "+Surround",
        })
    end,
}
