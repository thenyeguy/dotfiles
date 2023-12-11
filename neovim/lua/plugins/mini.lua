return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup({})

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

        require("mini.operators").setup({})

        require("mini.pairs").setup({
            modes = { command = true },
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
                    action = "open", pair = "  ", neigh_pattern = "[%(%[{][%)%]}]",
                },
            },
        })

        local starter = require("mini.starter")
        starter.setup({
            evaluate_single = true,
            items = {
                starter.sections.builtin_actions(),
                starter.sections.recent_files(10, true),
                starter.sections.telescope(),
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
    end,
}
