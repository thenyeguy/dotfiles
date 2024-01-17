return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "onsails/lspkind.nvim",
    },
    config = function()
        local cmp = require("cmp")

        -- Helpers for completion mappings
        local if_active = function(f)
            return cmp.mapping(function(fallback)
                -- stylua: ignore
                if cmp.get_active_entry() then f() else fallback() end
            end)
        end
        local if_visible = function(f)
            return cmp.mapping(function(fallback)
                -- stylua: ignore
                if cmp.visible() then f() else fallback() end
            end)
        end

        cmp.setup({
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = require("lspkind").cmp_format({
                    ellipsis_char = "…",
                    mode = "symbol",
                }),
            },
            mapping = cmp.mapping.preset.insert({
                ["<CR>"] = if_active(cmp.confirm),
                ["<C-f>"] = if_visible(cmp.mapping.confirm({ select = true })),
                ["<Esc>"] = if_active(cmp.close),
                ["<C-c>"] = if_visible(cmp.abort),
                ["<Tab>"] = if_visible(cmp.select_next_item),
                ["<S-Tab>"] = if_visible(cmp.select_prev_item),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if not cmp.visible() then cmp.complete() end
                    cmp.select_next_item()
                end),
                ["<C-p>"] = if_visible(cmp.select_prev_item),
            }),
            preselect = cmp.PreselectMode.None,
            snippet = {
                expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
            }, {
                {
                    name = "buffer",
                    option = {
                        get_bufnrs = function()
                            -- Pull keywords from all visible buffers
                            local bufs = {}
                            for _, win in ipairs(vim.api.nvim_list_wins()) do
                                bufs[vim.api.nvim_win_get_buf(win)] = true
                            end
                            return vim.tbl_keys(bufs)
                        end,
                    },
                },
                { name = "path" },
            }),
            window = {
                completion = cmp.config.window.bordered({ col_offset = -4 }),
                documentation = cmp.config.window.bordered(),
            },
        })

        -- Enable completion in command line.
        cmp.setup.cmdline(":", {
            formatting = { fields = { "abbr", "menu" } },
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "cmdline" },
                { name = "path" },
            }),
        })

        -- Enable completion when searching.
        local search_opts = {
            completion = { autocomplete = false },
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
        }
        cmp.setup.cmdline("/", search_opts)
        cmp.setup.cmdline("?", search_opts)

        -- Hide completion by default in text files.
        cmp.setup.filetype({ "gitcommit", "markdown", "text" }, {
            completion = { autocomplete = false },
        })

        -- Pad symbol map so icons show up double-wide.
        require("lspkind").init({
            symbol_map = { TypeParameter = "" },
        })
        local symbols = require("lspkind").symbol_map
        for key, _ in pairs(symbols) do
            symbols[key] = symbols[key] .. " "
        end
    end,
}
