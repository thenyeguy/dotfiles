return {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
        local c = require("gruvbox").palette
        require("gruvbox").setup({
            inverse = false,
            overrides = {
                -- Syntax
                Operator = { fg=c.red, italic=false },
                String = { fg=c.neutral_green, italic=true },
                SpecialChar = { link="Special" },

                -- Treesitter overrides
                ["@namespace"] = { link="Include" },
                -- C++ only:
                ["@constructor.cpp"] = { link="Function" },
                ["@type.qualifier.cpp"] = { link="Keyword" },

                -- Search
                Search = { fg="", bg=c.dark2, bold=true, underline=true },
                IncSearch = { link="Search" },

                -- Vim UI
                Cursor = { fg=c.dark0, bg=c.light0 },
                FloatBorder = { fg=c.light1, bg=c.dark0 },
                Visual = { bg=c.dark2 },

                -- conflict-marker.vim
                ConflictMarkerBegin = { bg=c.dark2 },
                ConflictMarkerCommonAncestors = { bg=c.dark2 },
                ConflictMarkerSeparator = { bg=c.dark2 },
                ConflictMarkerEnd = { bg=c.dark2 },

                -- mini.nvim
                MiniIndentscopeSymbol = { fg=c.dark2 },
                MiniJump = { fg=c.bright_red, bold=true, underline=true },

                -- leap.nvim
                LeapMatch = { fg=c.bright_red, bold=true, underline=true },
                LeapLabelPrimary = { fg=c.light0, bg=c.neutral_red, bold=true, nocombine=true },
                LeapLabelSecondary = { fg=c.bright_red, bg=c.dark2, bold=true, nocombine=true },
            },
        })
        vim.o.background = "dark"
        vim.cmd.colorscheme("gruvbox")
    end,
}
