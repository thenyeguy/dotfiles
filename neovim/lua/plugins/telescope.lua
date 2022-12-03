return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function ()
        -- Configure telescope
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                layout_strategy = "vertical",
                path_display = { "truncate" },
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-u>"] = "results_scrolling_up",
                        ["<C-d>"] = "results_scrolling_down",
                        ["<Esc>"] = "close",
                        ["<ScrollWheelUp>"] = "move_selection_previous",
                        ["<ScrollWheelDown>"] = "move_selection_next",
                        ["<LeftMouse>"] = function() end,
                    }
                }
            }
        })
        telescope.load_extension("fzf")

        -- Map telescope commands
        vim.keymap.set("n", "<C-r>", "<cmd>Telescope find_files<cr>")

        vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>")
        vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>")
        vim.keymap.set("n", "<leader>tc", "<cmd>Telescope commands<cr>")
        vim.keymap.set("n", "<leader>tr", function()
            require("telescope.builtin").oldfiles({only_cwd=true})
        end)
        vim.keymap.set("n", "<leader>ts", function()
            require("telescope.builtin").lsp_document_symbols({
                symbol_width=55
            })
        end)
    end,
}
