return {
    "gbprod/nord.nvim",
    priority = 1000,
    config = function()
        require("nord").setup({
            borders = true,
            styles = {
                comments = { italic = true },
                functions = { bold = true },
                keywords = { italic = true },
                variables = {},
            },

            -- Customize highlights
            on_highlights = function(hl, c)
                -- Fix typos in plugin :o
                c.frost.arctic_water = c.frost.artic_water
                c.frost.arctic_ocean = c.frost.artic_ocean

                -- Vim UI
                hl.CursorLineNr =
                    { fg = c.aurora.yellow, bg = c.polar_night.bright }
                hl.IncSearch = { link = "Search" }
                hl.WinSeparator = { fg = c.polar_night.brightest }

                -- Syntax highlighting
                hl["@constant"] = { fg = c.aurora.purple }
                hl["@function.call"] = { link = "@function" }
                hl["@method"] = { link = "@function" }
                hl["@method.call"] = { link = "@function" }
                hl["@namespace"] = { fg = c.frost.arctic_water }
                hl["@parameter"] = {}
                hl["@punctuation.bracket"] = { fg = c.frost.arctic_water }
                hl["@punctuation.delimiter"] = { fg = c.frost.arctic_water }
                hl["@string"] = { fg = c.aurora.green, italic = true }
                hl["@type"] = { link = "Type" }

                -- mini.nvim
                hl.MiniIndentscopeSymbol = { fg = c.polar_night.brighter }

                hl.MiniStarterHeader =
                    { fg = c.frost.arctic_water, bold = true }
                hl.MiniStarterSection =
                    { fg = c.frost.arctic_water, bold = true }
                hl.MiniStarterItemBullet = { fg = c.polar_night.light }
                hl.MiniStarterItemPrefix = { fg = c.aurora.purple }
                hl.MiniStarterQuery = { fg = c.aurora.yellow }
                hl.MiniStarterFooter = { link = "Comment" }

                -- leap.nvim
                hl.LeapMatch =
                    { fg = c.aurora.yellow, bold = true, underline = true }
                hl.LeapLabelPrimary = {
                    fg = c.polar_night.origin,
                    bg = c.aurora.yellow,
                    bold = true,
                }
                hl.LeapLabelSecondary = {
                    fg = c.polar_night.origin,
                    bg = c.aurora.purple,
                    bold = true,
                }
            end,
        })

        -- Load colorscheme.
        vim.o.termguicolors = true
        vim.cmd.colorscheme("nord")
    end,
}
