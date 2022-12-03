return {
    "echasnovski/mini.nvim",
    config = function()
        require("mini.ai").setup({})

        require("mini.comment").setup({
            mappings = {
                comment = "gc",
                comment_line = "gcc",
                textobject = "gc",
            }
        })

        require("mini.jump").setup({
            delay = { highlight = 0, idle_stop = 5000 },
            mappings = { repeat_jump = "" }
        })

        local indentscope = require("mini.indentscope")
        indentscope.setup({
            draw = {
                animation = indentscope.gen_animation.none(),
                delay = 0,
            },
            options = {
                border = "top",
                try_as_border = true,
            },
            symbol = "▏",
        })

        require("mini.pairs").setup({})

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
