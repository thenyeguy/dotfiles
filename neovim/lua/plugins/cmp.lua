return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-buffer",
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
                    symbol_map = { TypeParameter = "" },
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
            snippet = {
                expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
            },
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "nvim_lsp_signature_help" },
            }, {
                { name = "buffer" },
                { name = "path" },
            }),
            window = {
                completion = cmp.config.window.bordered({ col_offset = -3 }),
                documentation = cmp.config.window.bordered(),
            },
        })

        cmp.setup.filetype({ "gitcommit", "markdown", "text" }, {
            completion = { autocomplete = false },
        })
    end,
}
