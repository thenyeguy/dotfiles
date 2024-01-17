return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Configure diagnostics symbols
            local signs =
                { Error = "", Warn = "", Info = "", Hint = "" }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Configure floating windows
            vim.diagnostic.config({
                float = { border = "rounded" },
                virtual_text = false,
            })
            vim.lsp.handlers["textDocument/hover"] =
                vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help,
                { border = "rounded" }
            )

            -- Configure keybinds
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local bind = function(keys, f, desc)
                        vim.keymap.set(
                            "n",
                            keys,
                            f,
                            { buffer = bufnr, desc = desc }
                        )
                    end

                    -- Goto mappings
                    bind("gd", vim.lsp.buf.definition, "Move to definition")
                    bind("gD", vim.lsp.buf.declaration, "Move to declaration")
                    bind(
                        "gI",
                        vim.lsp.buf.implementation,
                        "Move to implementation"
                    )
                    bind("gR", vim.lsp.buf.references, "Move to references")

                    bind("[d", vim.diagnostic.goto_prev, "Previous diagnostic")
                    bind("]d", vim.diagnostic.goto_next, "Next diagnostic")

                    -- Hover info
                    bind(
                        "<leader>lh",
                        vim.lsp.buf.hover,
                        "Show hover information"
                    )
                    bind(
                        "<leader>ls",
                        vim.lsp.buf.signature_help,
                        "Show signature help"
                    )
                    bind(
                        "<leader>ld",
                        vim.diagnostic.open_float,
                        "Show diagnostics"
                    )
                    bind(
                        "<leader>lD",
                        vim.diagnostic.setqflist,
                        "Open diagnostics quickfix"
                    )

                    -- LSP commands
                    bind("<leader>la", vim.lsp.buf.code_action, "Code actions")
                    bind("<leader>lf", vim.lsp.buf.format, "Format buffer")
                end,
            })

            -- Setup language servers
            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()

            lspconfig.ocamllsp.setup({ capabilities = capabilities })
            lspconfig.rust_analyzer.setup({ capabilities = capabilities })
        end,
    },
    {
        "stevearc/dressing.nvim",
        opts = {},
    },
}
