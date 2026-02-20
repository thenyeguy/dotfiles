return {
    "folke/snacks.nvim",
    opts = {
        explorer = {
            enabled = true,
        },
        picker = {
            enabled = true,
            formatters = {
                file = {
                    truncate = "left",
                },
            },
            layout = {
                hidden = { "preview" },
                layout = {
                    backdrop = false,
                    min_width = 80,
                },
            },
            matcher = {
                frecency = true,
            },
            sources = {
                explorer = {
                    layout = {
                        layout = { width = 60 },
                    },
                },
                recent = {
                    filter = { cwd = true },
                },
            },
            win = {
                input = {
                    keys = {
                        ["<Esc>"] = { "close", mode = { "n", "i" } },
                    },
                },
            },
        },
    },
    keys = {
        {
            "<leader>pf",
            function() Snacks.picker.files() end,
            desc = "Find files",
        },
        {
            "<leader>po",
            function() Snacks.picker.buffers() end,
            desc = "Open files",
        },
        {
            "<leader>pr",
            function() Snacks.picker.recent() end,
            desc = "Recent files",
        },
        {
            "<leader>ph",
            function() Snacks.picker.help() end,
            desc = "Help pages",
        },
        {
            "<leader>pe",
            function() Snacks.picker.explorer() end,
            desc = "File explorer",
        },
    },
}
