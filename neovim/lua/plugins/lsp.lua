return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Configure diagnostics symbols
            local signs = { Error = "▶", Warn = "▷", Info = "»", Hint = "›" }
            for type, icon in pairs(signs) do
              local hl = "DiagnosticSign" .. type
              vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            vim.diagnostic.config({ virtual_text = false })

            -- Configure lsp keybindings
            local bind_lsp_keys = function(_, bufnr)
                local opts = function(d)
                    return { buffer = bufnr, desc = d }
                end

                -- Goto mappings
                vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                    opts("Move to definition"))
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                    opts("Move to declaration"))
                vim.keymap.set("n", "gI", vim.lsp.buf.implementation,
                    opts("Move to implementation"))
                vim.keymap.set("n", "gR", vim.lsp.buf.references,
                    opts("Move to references"))

                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
                    opts("Previous diagnostic"))
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
                    opts("Next diagnostic"))

                -- Hover info
                vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover,
                    opts("Show hover information"))
                vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float,
                    opts("Show diagnostics"))
                vim.keymap.set("n", "<leader>lD", vim.diagnostic.setqflist,
                    opts("Open diagnostics quickfix"))

                -- LSP commands
                vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action,
                    opts("Code actions"))
                vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format,
                    opts("Format buffer"))
            end

            -- Setup language servers
            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            lspconfig.ocamllsp.setup({
                on_attach = bind_lsp_keys,
                capabilities = capabilities,
            })
            lspconfig.rust_analyzer.setup({
                on_attach = bind_lsp_keys,
                capabilities = capabilities,
            })
        end,
    },
    {
        "stevearc/dressing.nvim",
        config = function()
            require("dressing").setup()
        end,
    },
}
