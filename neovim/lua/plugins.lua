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

    -- Dim inactive splits
    use {
        "sunjon/shade.nvim",
        config = function() require("shade").setup({ overlay_opacity = 65 }) end
    }

    -- Statusline
    use {
        "nvim-lualine/lualine.nvim",
        requires = { {"arkav/lualine-lsp-progress"} },
        config = function()
            require("lualine").setup({
                options = { globalstatus = true },
                sections = {
                    lualine_a = {"mode"},
                    lualine_b = { { "filename", path = 1 } },
                    lualine_c = {},
                    lualine_x = {
                        {
                            "lsp_progress",
                            display_components = { "spinner", "lsp_client_name" },
                            separators = { lsp_client_name = { pre = "", post = "" } },
                            spinner_symbols = { "⠂", "⠒", "⠐", "⠰", "⠠", "⠤", "⠄", "⠆" },
                        },
                        {
                            "diagnostics",
                            symbols = { error = "‼ ", warn = "! " },
                            sections = { "error", "warn", "info" },
                        },
                    },
                    lualine_y = {"location"},
                    lualine_z = {},
                },
            })
        end
    }

    -- Telescope (fuzzy finding)
    use {
        "nvim-telescope/telescope.nvim",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
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
                        }
                    }
                }
            })
            telescope.load_extension("fzf")

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

    -- Tmux integration
    use {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                copy_sync = { enable = true },
                navigation = { enable_default_keybindings = true },
            })
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

            -- Fix an error with C++ highlighting where all CamelCase functions
            -- are considered constructors.
            vim.api.nvim_create_autocmd("Filetype", {
                pattern = "cpp",
                command = "highlight! link TSConstructor Function",
            })
        end
    }

    -- LSP plugins
    use {
        "neovim/nvim-lspconfig",
        config = function() require("plugins.lsp") end,
    }
    use {
        "stevearc/dressing.nvim",
        config = function() require("dressing").setup() end,
    }
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            {"hrsh7th/cmp-nvim-lsp"},
            {"hrsh7th/cmp-nvim-lsp-signature-help"},
            {"hrsh7th/cmp-buffer"},
        },
        config = function() require("plugins.cmp") end,
    }
end)

-- Automatically re-compile plugin config
local packer_grp = vim.api.nvim_create_augroup("packer_user_config", {})
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "plugins.lua",
    command = "source <afile> | PackerCompile",
    group = packer_grp,
})
