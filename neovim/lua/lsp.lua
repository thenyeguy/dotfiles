-- Configure diagnostics symbols
local signs = { Error = "▶", Warn = "▷", Info = "»", Hint = "›" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({ virtual_text = { prefix = "●" } })

-- Configure lsp keybindings
local bind_lsp_keys = function(_, bufnr)
    local opts = { buffer = bufnr }

    -- Goto mappings
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

    -- Hover info
    vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "<leader>D", vim.diagnostic.setqflist, opts)

    -- LSP commands
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>f", vim.lsp.buf.formatting, opts)
end

-- Configure completion.
local cmp = require("cmp");
local if_completion = function(f)
    return cmp.mapping(function(fallback)
        if cmp.visible() then f() else fallback() end
    end, {"i", "s"})
end

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = if_completion(function() cmp.confirm({ select = true }) end),
        ["<Esc>"] = if_completion(cmp.abort),
        ["<Tab>"] = if_completion(cmp.select_next_item),
        ["<S-Tab>"] = if_completion(cmp.select_prev_item),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
    })
})

-- Setup language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
require("lspconfig").rust_analyzer.setup({
    on_attach = bind_lsp_keys,
    capabilities = capabilities,
})
