require("packer").startup(function()
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Colorscheme
    use {
        "ellisonleao/gruvbox.nvim",
        config = function ()
            local c = require("gruvbox.palette")
            require("gruvbox").setup({
                inverse = false,
                overrides = {
                    -- Syntax
                    Operator = { fg=c.red, italic=false },
                    String = { fg=c.neutral_green, italic=true },
                    SpecialChar = { link="Special" },
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
            vim.cmd("colorscheme gruvbox")
        end,
    }

    -- Textobjects
    use "kana/vim-textobj-user"
    use "kana/vim-textobj-entire"
    use "glts/vim-textobj-comment"
    use "Julian/vim-textobj-variable-segment"

    -- Merge Conflicts
    use "rhysd/conflict-marker.vim"

    -- Mini plugins
    use {
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
                delay = { highlight = 0, idle_stop = 1000 },
                mappings = { repeat_jump = "" }
            })

            require("mini.indentscope").setup({
                draw = {
                    animation = require("mini.indentscope").gen_animation("none"),
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
                            ["<ScrollWheelUp>"] = "move_selection_previous",
                            ["<ScrollWheelDown>"] = "move_selection_next",
                            ["<LeftMouse>"] = function() end,
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
        "ggandor/leap.nvim",
        config = function()
            require("leap").set_default_keymaps()

            -- Remap cross-window bindings to not conflict with surround.
            vim.keymap.del("", "gs")
            vim.keymap.set("n", "gz", "<Plug>(leap-cross-window)")
        end,
    }

    -- Tmux integration
    use {
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                -- Only use copy_sync for the clipboard registers
                copy_sync = {
                    enable = true,
                    sync_clipboard = true,
                    sync_registers = false,
                },
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
            {"hrsh7th/cmp-path"},
            {"hrsh7th/cmp-vsnip"},
            {"hrsh7th/vim-vsnip"},
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
