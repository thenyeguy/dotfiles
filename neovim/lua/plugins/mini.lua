return {
    "echasnovski/mini.nvim",
    config = function()
        local extra = require("mini.extra")
        extra.setup({})

        require("mini.ai").setup({
            search_method = "cover",
            mappings = {
                around_last = "aN",
                inside_last = "iN",
            },
            custom_textobjects = {
                e = extra.gen_ai_spec.buffer(),
                l = extra.gen_ai_spec.line(),
            },
        })

        require("mini.comment").setup({})

        local indentscope = require("mini.indentscope")
        indentscope.setup({
            draw = {
                animation = indentscope.gen_animation.none(),
                delay = 0,
            },
            options = {
                border = "top",
                indent_at_cursor = false,
            },
            symbol = "▏",
        })

        require("mini.operators").setup({
            sort = { prefix = "" },
        })

        require("mini.pairs").setup({
            mappings = {
                -- Don't open pairs on start of words.
                ["("] = { neigh_pattern = "[^\\][^%w_]" },
                ["["] = { neigh_pattern = "[^\\][^%w_]" },
                ["{"] = { neigh_pattern = "[^\\][^%w_]" },
                ['"'] = { neigh_pattern = "[^\\][^%w_]" },
                ["'"] = { neigh_pattern = "[^%a\\][^%w_]" },
                ["`"] = { neigh_pattern = "[^\\][^%w_]" },
                -- Expand spaces inside brackets
                [" "] = {
                    action = "open",
                    pair = "  ",
                    neigh_pattern = "[%(%[{][%)%]}]",
                },
            },
        })

        require("mini.pick").setup({
            mappings = {
                move_down = "<C-j>",
                move_up = "<C-k>",
                scroll_left = "<Left>",
                scroll_right = "<Right>",
            },
            window = { config = { width = 120 } },
        })
        vim.keymap.set("n", "<C-r>", "<cmd>Pick files<cr>")
        vim.keymap.set(
            "n",
            "<leader>pf",
            "<cmd>Pick files<cr>",
            { desc = "Files" }
        )
        vim.keymap.set(
            "n",
            "<leader>po",
            "<cmd>Pick buffers<cr>",
            { desc = "Open buffers" }
        )
        vim.keymap.set(
            "n",
            "<leader>pr",
            "<cmd>Pick visit_paths<cr>",
            { desc = "Recent files" }
        )
        vim.keymap.set(
            "n",
            "<leader>pc",
            "<cmd>Pick commands<cr>",
            { desc = "Commands" }
        )
        vim.keymap.set(
            "n",
            "<leader>ph",
            "<cmd>Pick help<cr>",
            { desc = "Help files" }
        )

        local starter = require("mini.starter")
        starter.setup({
            evaluate_single = true,
            items = {
                starter.sections.builtin_actions(),
                starter.sections.recent_files(10, true),
                starter.sections.pick(),
            },
        })

        require("mini.surround").setup({
            mappings = {
                add = "gsa",
                delete = "gsd",
                find = "gsf",
                find_left = "gsF",
                highlight = "gsh",
                replace = "gsr",
                update_n_lines = "",
            },
        })

        require("mini.visits").setup({})
    end,
}
