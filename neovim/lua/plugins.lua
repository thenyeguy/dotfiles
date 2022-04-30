return require("packer").startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Colorscheme
    use {
        "ellisonleao/gruvbox.nvim",
        config = { vim.cmd([[colorscheme gruvbox]]) }
    }

    -- Textobjects
    use {
        "wellle/targets.vim",
        config = function()
            -- Swao "inner" and "inner with whitespace"
            vim.g.targets_aiAI = "aIAi"
        end,
    }

    -- Mini plugins
    use {
        "echasnovski/mini.nvim",
        config = {
            require("mini.comment").setup({
                mappings = {
                    comment = "gc",
                    comment_line = "gcc",
                    textobject = "gc",
                }
            })
        }
    }

    -- Telescope (fuzzy finding)
    use {
        "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} },
        config = function ()
            -- Configure telescope
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            ["<Esc>"] = "close",
                        }
                    }
                }
            })

            -- Map telescope commands
            vim.keymap.set("n", "<C-r>", "<cmd>Telescope find_files<cr>")
        end,
    }

    -- Lightspeed (easy motion)
    use {
        "ggandor/lightspeed.nvim",
        config = {
            require("lightspeed").setup({
                ignore_case = true,
                exit_after_idle_msecs = { labeled = 2000 }
            })
        }
    }
end)
