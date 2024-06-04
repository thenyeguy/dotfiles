return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        -- Set how quickly which-key UI appears.
        vim.o.timeout = true
        vim.o.timeoutlen = 250
    end,
    config = function()
        -- Don't trigger which-key for visual mode
        local presets = require("which-key.plugins.presets")
        presets.operators["v"] = nil

        local wk = require("which-key")
        wk.setup({})
        wk.register({
            ["<leader>p"] = "+Pick",
            ["<leader>l"] = "+LSP",
            ["gs"] = "+Surround",
        })
    end,
}
