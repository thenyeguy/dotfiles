require("packer").startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Colorscheme
    use {
        "ellisonleao/gruvbox.nvim",
        config = function ()
            vim.g.gruvbox_sign_column = "bg0"
            vim.cmd("colorscheme gruvbox")
        end,
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
        after = "gruvbox.nvim",
        config = function()
            require("mini.comment").setup({
                mappings = {
                    comment = "gc",
                    comment_line = "gcc",
                    textobject = "gc",
                }
            })

            require("mini.indentscope").setup({
                draw = {
                    animation = require("mini.indentscope").gen_animation("none"),
                    delay = 0,
                },
                symbol = "▏",
            })
            vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "GruvboxBg2" })

            require("mini.pairs").setup({})
        end,
    }

    -- Dim inactive splits
    use {
        "sunjon/shade.nvim",
        config = function() require("shade").setup({ overlay_opacity = 65 }) end
    }

    -- Statusline
    use {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup({
                options = { globalstatus = true },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = { { "filename", path = 1 } },
                    lualine_c = {},
                    lualine_x = { {
                        "diagnostics",
                        symbols = { error = "‼ ", warn = "! " },
                        sections = { "error", "warn", "info" },
                    } },
                    lualine_y = {"location"},
                    lualine_z = {},
                },
            })
        end
    }

    -- Telescope (fuzzy finding)
    use {
        "nvim-telescope/telescope.nvim",
        requires = { {"nvim-lua/plenary.nvim"} },
        after = "mini.nvim",
        config = function ()
            -- Configure telescope
            require("telescope").setup({
                defaults = {
                    generic_sorter = require("mini.fuzzy").get_telescope_sorter,
                    path_display = { "truncate" },
                    mappings = {
                        i = {
                            ["<C-j>"] = "move_selection_next",
                            ["<C-k>"] = "move_selection_previous",
                            ["<C-u>"] = "results_scrolling_up",
                            ["<C-d>"] = "results_scrolling_down",
                            ["<Esc>"] = "close",
                        }
                    }
                }
            })

            -- Map telescope commands
            vim.keymap.set("n", "<C-r>", "<cmd>Telescope find_files<cr>")
            vim.keymap.set("n", "<leader>b", "<cmd>Telescope buffers<cr>")
        end,
    }

    -- Lightspeed (easy motion)
    use {
        "ggandor/lightspeed.nvim",
        config = function()
            require("lightspeed").setup({ ignore_case = true })
        end
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-n>",
                        node_incremental = "<C-n>",
                        node_decremental = "<C-S-n>",
                        scope_incremental = "<C-A-n>",
                    },
                },
                ensure_installed = { "cpp", "fish", "julia", "lua", "python", "rust" },
            })
        end
    }

    -- LSP plugins
    use "neovim/nvim-lspconfig"
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
end)

-- Automatically re-compile plugin config
local packer_grp = vim.api.nvim_create_augroup("packer_user_config", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
    group = packer_grp,
})
