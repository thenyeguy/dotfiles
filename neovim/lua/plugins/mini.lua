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

        local hipatterns = require("mini.hipatterns")
        hipatterns.setup({
            highlighters = {
                todo = {
                    pattern = "%f[%w]()TODO()%f[%W]",
                    group = "@comment.todo"
                },
                note = {
                    pattern = "%f[%w]()NOTE()%f[%W]",
                    group = "@comment.note"
                },
                -- Highlight hex color strings (`#rrggbb`) using that color
                hex_color = hipatterns.gen_highlighter.hex_color(),
            },
        })

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

        local starter = require("mini.starter")
        starter.setup({
            evaluate_single = true,
            items = {
                starter.sections.builtin_actions(),
                starter.sections.recent_files(10, true),
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
